resource "random_password" "jenkins_admin_password" {
  length      = 16
  special     = true
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1

  # Optional: If you prefer fewer special characters, define allow_*:
  # override_special = "!@#%"
}

# Get latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Generate SSH key
resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "jenkins-key"
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

# Save private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.jenkins_key.private_key_pem
  filename = "jenkins-key.pem"

  provisioner "local-exec" {
    command = "chmod 400 jenkins-key.pem"
  }
}

# VPC Configuration
resource "aws_vpc" "jenkins_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "jenkins-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "jenkins-igw"
  }
}

# Public Subnet
resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = aws_vpc.jenkins_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "jenkins-subnet"
  }
}

# Route Table
resource "aws_route_table" "jenkins_rt" {
  vpc_id = aws_vpc.jenkins_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_igw.id
  }

  tags = {
    Name = "jenkins-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "jenkins_rta" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_rt.id
}

# Security Group
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins server"
  vpc_id      = aws_vpc.jenkins_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "jenkins_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y openjdk-17-jdk
              curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              apt-get update && apt-get install -y jenkins && systemctl enable jenkins && systemctl start jenkins

              # Wait a bit for Jenkins to start
              sleep 60

              # Retrieve the initial admin password (only valid until we run our Groovy script)
              JENKINS_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

              # Download Jenkins CLI
              wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar

              # Create Groovy script to set Jenkins to "INITIAL_SETUP_COMPLETED"
              # and create a new admin user with the random password
              cat <<GROOVY > create_admin.groovy
              import jenkins.model.*
              import hudson.security.*
              import jenkins.install.*

              def instance = Jenkins.getInstance()

              // Skip the Jenkins setup wizard
              instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

              // Create admin user with a random password
              def hudsonRealm = new HudsonPrivateSecurityRealm(false)
              hudsonRealm.createAccount("admin", "${random_password.jenkins_admin_password.result}")
              instance.setSecurityRealm(hudsonRealm)

              def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
              strategy.setAllowAnonymousRead(false)
              instance.setAuthorizationStrategy(strategy)

              instance.save()
              GROOVY

              # Use the initial Jenkins password to run the Groovy script
              java -jar jenkins-cli.jar \
                -s http://localhost:8080 \
                -auth admin:$JENKINS_PASS \
                groovy = < create_admin.groovy || {
                  echo "Failed to create admin user"
                  exit 1
                }

              rm -f create_admin.groovy

              # (Optional) Additional setup commands, e.g. Docker, etc.
              # ...
              EOF

  tags = {
    Name      = "jenkins-server",
    lifecycle = "deleteme"
  }
}


# # Instance Profile for Jenkins
# resource "aws_iam_instance_profile" "jenkins_profile" {
#   name = "jenkins_profile"
#   role = aws_iam_role.jenkins_role.name
# }

# # Security Group for Jenkins Agents
# resource "aws_security_group" "jenkins_agent_sg" {
#   name        = "jenkins-agent-sg"
#   description = "Security group for Jenkins agents"
#   vpc_id      = aws_vpc.jenkins_vpc.id

#   ingress {
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     security_groups = [aws_security_group.jenkins_sg.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "jenkins-agent-sg"
#   }
# }



resource "null_resource" "wait_for_jenkins_authenticated" {
  depends_on = [aws_instance.jenkins_server]

  provisioner "local-exec" {
    command = <<-EOT
      while true; do
        echo "Checking Jenkins with the new random password..."

        STATUS_CODE=$(curl -s -o /dev/null -w '%%{http_code}' \
          -u "admin:${random_password.jenkins_admin_password.result}" \
          http://${aws_instance.jenkins_server.public_ip}:8080/api/json)

        if [ "$STATUS_CODE" = "200" ]; then
          echo "Jenkins is responding with HTTP 200 to admin:${random_password.jenkins_admin_password.result}"
          break
        else
          echo "Got HTTP $STATUS_CODE. Waiting for Jenkins..."
          sleep 10
        fi
      done

      echo "Jenkins is fully up and accepting authenticated requests."
    EOT
  }
}



# Configure Jenkins EC2 agents
# resource "null_resource" "configure_jenkins_agents" {
#   depends_on = [null_resource.wait_for_jenkins]

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = tls_private_key.jenkins_key.private_key_pem
#     host        = aws_instance.jenkins_server.public_ip
#   }

#   provisioner "file" {
#     content     = tls_private_key.jenkins_key.private_key_pem
#     destination = "/tmp/jenkins-key.pem"
#   }

#   provisioner "file" {
#     content     = templatefile("${path.module}/configure_ec2_agent.groovy.tpl", {
#       ami_id           = data.aws_ami.ubuntu.id
#       subnet_id        = aws_subnet.jenkins_subnet.id
#       security_group_id = aws_security_group.jenkins_sg.id
#     })
#     destination = "/tmp/configure_ec2_agent.groovy"
#   }


#   provisioner "remote-exec" {
#     inline = [
#       # Setup SSH key for Jenkins
#       "sudo mkdir -p /var/lib/jenkins/.ssh",
#       "sudo mv /tmp/jenkins-key.pem /var/lib/jenkins/.ssh/",
#       "sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh",
#       "sudo chmod 700 /var/lib/jenkins/.ssh",
#       "sudo chmod 600 /var/lib/jenkins/.ssh/jenkins-key.pem",
#       "cat /tmp/configure_ec2_agent.groovy",
#       "wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar",
#       # Execute the Groovy script using Jenkins CLI
#       "java -jar jenkins-cli.jar -s http://localhost:8080 -auth admin:admin123! groovy = < /tmp/configure_ec2_agent.groovy",

#       # Cleanup
#       "rm /tmp/configure_ec2_agent.groovy"
#     ]
#   }
# }

# Create IAM user for Jenkins
resource "aws_iam_user" "jenkins_user" {
  name = "jenkins-user"
}

# Create access key for the IAM user
resource "aws_iam_access_key" "jenkins_user_key" {
  user = aws_iam_user.jenkins_user.name
}

# Attach policy to the user
resource "aws_iam_user_policy_attachment" "jenkins_user_policy" {
  user       = aws_iam_user.jenkins_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Output the credentials
output "jenkins_user_access_key" {
  value     = aws_iam_access_key.jenkins_user_key.id
  sensitive = true
}

output "jenkins_user_secret_key" {
  value     = aws_iam_access_key.jenkins_user_key.secret
  sensitive = true
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "ssh_connection_string" {
  value = "ssh -i jenkins-key.pem ubuntu@${aws_instance.jenkins_server.public_ip}"
}

output "jenkins_admin_password" {
  value     = random_password.jenkins_admin_password.result
  sensitive = true
}

output "fetch_admin_passwrd" {
  value = "cd terraform && terraform show -json | jq '.values.outputs.jenkins_admin_password.value'"
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}
