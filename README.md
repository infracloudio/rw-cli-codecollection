Troubleshooting Tasks in Codecollection: **175**
Codebundles in Codecollection: **66**

![](docs/GitHub_Banner.jpg)

<p align="center">
  <a href="https://discord.gg/Ut7Ws4rm8Q">
    <img src="https://img.shields.io/discord/1131539039665791077?label=Join%20Discord&logo=discord&logoColor=white&style=for-the-badge" alt="Join Discord">
  </a>
  <br>
  <a href="https://runwhen.slack.com/join/shared_invite/zt-1l7t3tdzl-IzB8gXDsWtHkT8C5nufm2A">
    <img src="https://img.shields.io/badge/Join%20Slack-%23E01563.svg?&style=for-the-badge&logo=slack&logoColor=white" alt="Join Slack">
  </a>
</p>
<a href='https://codespaces.new/runwhen-contrib/rw-cli-codecollection?quickstart=1'><img src='https://github.com/codespaces/badge.svg' alt='Open in GitHub Codespaces' style='max-width: 100%;'></a>

# RunWhen Public Codecollection
This repository is a codecollection that is to be used within the RunWhen platform. It contains codebundles that can be used in SLIs, and TaskSets. 

Please see the **[contributing](CONTRIBUTING.md)** and **[code of conduct](CODE_OF_CONDUCT.md)** for details on adding your contributions to this project. 

Documentation for each codebundle is maintained in the README.md alongside the robot code and is published at [https://docs.runwhen.com/public/v/codebundles/](https://docs.runwhen.com/public/v/codebundles/). Please see the [readme howto](README_HOWTO.md) for details on crafting a codebundle readme that can be indexed.

## Getting Started
Head on over to our centralized documentation [here](https://docs.runwhen.com/public/v/runwhen-authors/codecollection-development/getting-started/running-your-first-codebundle) for detailed information on getting started.

File Structure overview of devcontainer:
```
-/app/
    |- auth/ # store secrets here, it should already be properly gitignored for you
    |- codecollection/
    |   |- codebundles/ # stores codebundles that can be run during development
    |   |- libraries/ # stores python keyword libraries used by codebundles
    |- dev_facade/ # provides interfaces equivalent to those used on the platform, but just dry runs the keywords to assist with development
    ...
```

The included script `ro` wraps the `robot` RobotFramework binary, and includes some extra functionality to write files to a consistent location for viewing in a HTTP server at http://localhost:3000/ that is always running as part of the devcontainer.

### Quickstart

Navigate to the codebundle directory
`cd codecollection/codebundles/curl-http-ok/`

Run the codebundle
`ro runbook.robot` 

## Codebundle Index
| Name | Supported Integrations | Tasks | Documentation |
|---|---|---|---|
| [AWS CloudWatch Overutlized EC2 Inspection](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-cloudwatch-overused-ec2/runbook.robot) | `AWS`, `CloudWatch` | `Check For Overutilized Ec2 Instances` | Queries AWS CloudWatch for a list of EC2 instances with a high amount of resource utilization, raising issues when overutilized instances are found. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-cloudwatch-overused-ec2) |
| [AWS EKS Cluster Health](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-eks-health/runbook.robot) | `AWS`, `EKS`, `Fargate` | `Check EKS Fargate Cluster Health Status`, `Check EKS Cluster Health Status`, `List EKS Cluster Metrics` | Checks the health status of EKS and/or Fargate clusters in the given AWS region. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-eks-health) |
| [AWS EKS Health Scan](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-eks-health/sli.robot) | `AWS`, `EKS`, `Fargate` | `Check EKS Cluster Health Status` | Monitors the status of EKS / Fargate in the given AWS region. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-eks-health) |
| [AWS EKS Nodegroup Status Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-eks-node-reboot/runbook.robot) | `AWS`, `EKS` | `Check EKS Nodegroup Status` | Queries a node group within a EKS cluster to check if the nodegroup has degraded service, indicating ongoing reboots or other issues. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-eks-node-reboot) |
| [AWS ElastiCache Health Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-elasticache-redis-health/runbook.robot) | `AWS Elasticache Redis` | `Scan AWS Elasticache Redis Status` | Checks the health status of Elasticache redis in the given region. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-elasticache-redis-health) |
| [AWS ElastiCache Health Monitor](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-elasticache-redis-health/sli.robot) | `AWS Elasticache Redis` | `Scan ElastiCaches` | Monitors the health status of elasticache redis in the AWS region. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-elasticache-redis-health) |
| [AWS Lambda Health Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-lambda-health/runbook.robot) | `AWS`, `Lambda` | `List Lambda Versions and Runtimes`, `Analyze AWS Lambda Invocation Errors`, `Monitor AWS Lambda Performance Metrics` | Scans for AWS Lambda invocation errors [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-lambda-health) |
| [AWS Lambda Health Monitor](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-lambda-health/sli.robot) | `AWS`, `Lambda` | `Analyze AWS Lambda Invocation Errors` | Monitor AWS Lambda Invocation Errors [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-lambda-health) |
| [AWS S3 Bucket Info Report](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/aws-s3-bucket-storage-report/runbook.robot) | `AWS`, `S3` | `Check AWS S3 Bucket Storage Utilization` | Generates a report for S3 buckets in a AWS region [Docs](https://docs.runwhen.com/public/v/cli-codecollection/aws-s3-bucket-storage-report) |
| [Azure Internal LoadBalancer Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/azure-loadbalancer-triage/runbook.robot) | `Kubernetes`, `AKS`, `Azure` | `Check Activity Logs for Azure Load Balancer `${AZ_LB_NAME}`` | Triages issues related to a Azure Loadbalancers and its activity logs. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/azure-loadbalancer-triage) |
| [Azure Monitor Activity Log SLI](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/azure-monitor-event-triage/sli.robot) | `Kubernetes`, `AKS`, `Azure` | `Run Azure Monitor Activity Log Triage` | Measures the count of error activity log entries as a SLI metric for the Azure tenancy. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/azure-monitor-event-triage) |
| [Azure Monitor Event Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/azure-monitor-event-triage/runbook.robot) | `Kubernetes`, `AKS`, `Azure` | `Run Azure Monitor Activity Log Triage` | Triages issues related to a Azure Loadbalancers, Kubernetes ingress objects and services. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/azure-monitor-event-triage) |
| [GCP Cloud Function Health](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/gcp-cloud-function-health/sli.robot) | `GCP` | `Count unhealthy GCP Cloud Functions in GCP Project `${GCP_PROJECT_ID}`` | Count the number of Cloud Functions in an unhealthy state for a GCP Project. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/gcp-cloud-function-health) |
| [GCP Gcloud Log Inspection](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/gcloud-log-inspection/runbook.robot) | `GCP`, `Gcloud`, `Google Monitoring` | `Inspect GCP Logs For Common Errors` | Fetches logs from a GCP using a configurable query and raises an issue with details on the most common issues. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/gcloud-log-inspection) |
| [GCP Node Prempt List](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/gcloud-node-preempt/sli.robot) | `GCP`, `GKE` | `Count the number of nodes in active prempt operation` | Counts nodes that have been preempted within the defined time interval. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/gcloud-node-preempt) |
| [GCP Storage Bucket Health](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/gcp-bucket-health/sli.robot) | `GCP`, `GCS` | `Fetch GCP Bucket Storage Utilization for `${PROJECT_IDS}``, `Check GCP Bucket Security Configuration for `${PROJECT_IDS}``, `Generate Bucket Score` | This SLI uses the GCP API or gcloud to score bucket health. Produces a value between 0 (completely failing thet test) and 1 (fully passing the test). Looks for usage above a threshold and public buckets. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/gcp-bucket-health) |
| [GKE Kong Ingress Host Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/curl-gmp-kong-ingress-inspection/runbook.robot) | `GCP`, `GMP`, `Ingress`, `Kong`, `Metrics` | `Check If Kong Ingress HTTP Error Rate Violates HTTP Error Threshold`, `Check If Kong Ingress HTTP Request Latency Violates Threshold`, `Check If Kong Ingress Controller Reports Upstream Errors` | Collects Kong ingress host metrics from GMP on GCP and inspects the results for ingress with a HTTP error code rate greater than zero over a configurable duration and raises issues based on the number of ingress with error codes. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/curl-gmp-kong-ingress-inspection) |
| [GKE Nginx Ingress Host Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/curl-gmp-nginx-ingress-inspection/runbook.robot) | `GCP`, `GMP`, `Ingress`, `Nginx`, `Metrics` | `Fetch Nginx HTTP Errors From GMP for Ingress `${INGRESS_OBJECT_NAME}``, `Find Owner and Service Health for Ingress `${INGRESS_OBJECT_NAME}`` | Collects Nginx ingress host controller metrics from GMP on GCP and inspects the results for ingress with a HTTP error code rate greater than zero over a configurable duration and raises issues based on the number of ingress with error codes. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/curl-gmp-nginx-ingress-inspection) |
| [K8s Jaeger Query](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-jaeger-http-query/runbook.robot) | `GKE EKS AKS Kubernetes HTTP` | `Query Traces in Jaeger for Unhealthy HTTP Response Codes in Namespace `${NAMESPACE}`` | This taskset queries Jaeger API directly for trace details and parses the results [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-jaeger-http-query) |
| [Kubeprometheus Operator Troubleshoot](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-prometheus-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `Prometheus` | `Check Prometheus Service Monitors`, `Check For Successful Rule Setup`, `Verify Prometheus RBAC Can Access ServiceMonitors`, `Identify Endpoint Scraping Errors`, `Check Prometheus API Healthy` | This taskset investigates the logs, state and health of Kubernetes Prometheus operator. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-prometheus-healthcheck) |
| [Kubernetes Application Monitor](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-app-troubleshoot/sli.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Measure Application Exceptions` | Measures the number of exception stacktraces present in an application's logs over a time period. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-app-troubleshoot) |
| [Kubernetes Application Troubleshoot](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-app-troubleshoot/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Get `${CONTAINER_NAME}` Application Logs`, `Scan `${CONTAINER_NAME}` Application For Misconfigured Environment`, `Troubleshoot `${CONTAINER_NAME}` Application Logs` | Performs application-level troubleshooting by inspecting the logs of a workload for parsable exceptions, and attempts to determine next steps. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-app-troubleshoot) |
| [Kubernetes ArgoCD Application Health & Troubleshoot](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-argocd-application-health/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `ArgoCD` | `Fetch ArgoCD Application Sync Status & Health for `${APPLICATION}``, `Fetch ArgoCD Application Last Sync Operation Details for `${APPLICATION}``, `Fetch Unhealthy ArgoCD Application Resources for `${APPLICATION}``, `Scan For Errors in Pod Logs Related to ArgoCD Application `${APPLICATION}``, `Fully Describe ArgoCD Application `${APPLICATION}`` | This taskset collects information and runs general troubleshooting checks against argocd application objects within a namespace. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-argocd-application-health) |
| [Kubernetes ArgoCD HelmRelease TaskSet](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-argocd-helm-health/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `ArgoCD` | `Fetch all available ArgoCD Helm releases in namespace `${NAMESPACE}``, `Fetch Installed ArgoCD Helm release versions in namespace `${NAMESPACE}`` | This codebundle runs a series of tasks to identify potential helm release issues related to ArgoCD managed Helm objects. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-argocd-helm-health) |
| [Kubernetes Artifactory Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-artifactory-health/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `Artifactory` | `Check Artifactory Liveness and Readiness Endpoints` | Performs a triage on the Open Source version of Artifactory in a Kubernetes cluster. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-artifactory-health) |
| [Kubernetes Cluster Resource Health](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-cluster-resource-health/sli.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Identify High Utilization Nodes for Cluster `${CONTEXT}`` | Counts the number of nodes above 90% CPU or Memory Utilization from kubectl top. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-cluster-resource-health) |
| [Kubernetes Daemonset Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-daemonset-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Get DaemonSet Log Details For Report`, `Get Related Daemonset Events`, `Check Daemonset Replicas` | Triages issues related to a Daemonset and its available replicas. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-daemonset-healthcheck) |
| [Kubernetes Deployment Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-deployment-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Check Deployment Log For Issues with `${DEPLOYMENT_NAME}``, `Check Liveness Probe Configuration for Deployment `${DEPLOYMENT_NAME}``, `Check Readiness Probe Configuration for Deployment `${DEPLOYMENT_NAME}``, `Inspect Deployment Warning Events for `${DEPLOYMENT_NAME}``, `Get Deployment Workload Details For `${DEPLOYMENT_NAME}` and Add to Report`, `Inspect Deployment Replicas for `${DEPLOYMENT_NAME}``, `Check Deployment Event Anomalies for `${DEPLOYMENT_NAME}``, `Check ReplicaSet Health for Deployment `${DEPLOYMENT_NAME}`` | Triages issues related to a deployment and its replicas. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-deployment-healthcheck) |
| [Kubernetes Flux Choas Testing](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-chaos-flux/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Suspend the Flux Resource Reconciliation`, `Find Random FluxCD Workload as Chaos Target`, `Execute Chaos Command`, `Execute Additional Chaos Command`, `Resume Flux Resource Reconciliation` | This taskset is used to suspend a flux resource for the purposes of executing chaos tasks. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-chaos-flux) |
| [Kubernetes Flux Suspend Namespace](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-flux-suspend-namespace/runbook.robot) | `Kubernetes Flux Chaos Engineering Namespace` | `Flux Suspend Namespace ${NAMESPACE}`, `Unsuspend Flux for Namespace ${NAMESPACE}` | Suspends the flux reconciliation being applied to a given namespace. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-flux-suspend-namespace) |
| [Kubernetes FluxCD HelmRelease TaskSet](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-fluxcd-helm-health/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `FluxCD` | `List all available FluxCD Helmreleases in Namespace `${NAMESPACE}``, `Fetch Installed FluxCD Helmrelease Versions in Namespace `${NAMESPACE}``, `Fetch Mismatched FluxCD HelmRelease Version in Namespace `${NAMESPACE}``, `Fetch FluxCD HelmRelease Error Messages in Namespace `${NAMESPACE}``, `Check for Available Helm Chart Updates in Namespace `${NAMESPACE}`` | This codebundle runs a series of tasks to identify potential helm release issues related to Flux managed Helm objects. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-fluxcd-helm-health) |
| [Kubernetes FluxCD Kustomization TaskSet](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-fluxcd-kustomization-health/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `FluxCD` | `List all available Kustomization objects in Namespace `${NAMESPACE}``, `Get details for unready Kustomizations in Namespace `${NAMESPACE}`` | This codebundle runs a series of tasks to identify potential Kustomization issues related to Flux managed Kustomization objects. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-fluxcd-kustomization-health) |
| [Kubernetes Fluxcd Reconciliation Monitor](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-fluxcd-reconcile/sli.robot) | `Kubernetes Fluxcd` | `Health Check Flux Reconciliation` | Measures failing reconciliations for fluxcd [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-fluxcd-reconcile) |
| [Kubernetes Fluxcd Reconciliation Report](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-fluxcd-reconcile/runbook.robot) | `Kubernetes Fluxcd` | `Health Check Flux Reconciliation` | Generates a report of the reconciliation errors for fluxcd in your cluster. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-fluxcd-reconcile) |
| [Kubernetes GitOps GitHub Remediation](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-gitops-gh-remediate/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `FluxCD`, `ArgoCD`, `GitHub` | `Remediate Readiness and Liveness Probe GitOps Manifests in Namespace `${NAMESPACE}``, `Increase ResourceQuota for Namespace `${NAMESPACE}``, `Adjust Pod Resources to Match VPA Recommendation in `${NAMESPACE}``, `Expand Persistent Volume Claims in Namespace `${NAMESPACE}`` | Provides a list of tasks that can remediate configuraiton issues with manifests in GitHub based GitOps repositories. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-gitops-gh-remediate) |
| [Kubernetes Grafana Loki Health Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-loki-healthcheck/runbook.robot) | `k8s` | `Check Loki Ring API`, `Check Loki API Ready` | This taskset checks the health of Grafana Loki and its hash ring. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-loki-healthcheck) |
| [Kubernetes Image Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-image-check/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Check Image Rollover Times for Namespace `${NAMESPACE}``, `List Images and Tags for Every Container in Running Pods for Namespace `${NAMESPACE}``, `List Images and Tags for Every Container in Failed Pods for Namespace `${NAMESPACE}``, `List ImagePullBackOff Events and Test Path and Tags for Namespace `${NAMESPACE}`` | This taskset provides detailed information about the images used in a Kubernetes namespace. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-image-check) |
| [Kubernetes Ingress GCE & GCP HTTP Load Balancer Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-ingress-gce-healthcheck/runbook.robot) | `Kubernetes`, `GKE`, `GCE`, `GCP` | `Search For GCE Ingress Warnings in GKE`, `Identify Unhealthy GCE HTTP Ingress Backends`, `Validate GCP HTTP Load Balancer Configurations`, `Fetch Network Error Logs from GCP Operations Manager for Ingress Backends`, `Review GCP Operations Logging Dashboard` | Troubleshoot GCE Ingress Resources related to GCP HTTP Load Balancer in GKE [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-ingress-gce-healthcheck) |
| [Kubernetes Ingress Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-ingress-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Fetch Ingress Object Health in Namespace `${NAMESPACE}``, `Check for Ingress and Service Conflicts in Namespace `${NAMESPACE}`` | Triages issues related to a ingress objects and services. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-ingress-healthcheck) |
| [Kubernetes Jenkins Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-jenkins-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `Jenkins` | `Query The Jenkins Kubernetes Workload HTTP Endpoint`, `Query For Stuck Jenkins Jobs` | This taskset collects information about perstistent volumes and persistent volume claims to validate health or help troubleshoot potential issues. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-jenkins-healthcheck) |
| [Kubernetes Labeled Pod Count](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-labeledpods-healthcheck/sli.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Measure Number of Running Pods with Label` | This codebundle fetches the number of running pods with the set of provided labels, letting you measure the number of running pods. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-labeledpods-healthcheck) |
| [Kubernetes Namespace Chaos Engineering](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-chaos-namespace/runbook.robot) | `Kubernetes Chaos Engineering Namespace` | `Test Namespace ${NAMESPACE} Highly Available`, `OOMKill Pods in Namespace ${NAMESPACE}`, `Mangle Service Selector In Namespace ${NAMESPACE}`, `Mangle Service Port In Namespace ${NAMESPACE}`, `Fill Pod Tmp In Namespace ${NAMESPACE}` | Provides chaos injection tasks for Kubernetes namespaces. These are destructive tasks and the expectation is that you can heal these changes by enabling your GitOps reconciliation. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-chaos-namespace) |
| [Kubernetes Namespace Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-namespace-healthcheck/sli.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Get Event Count and Score`, `Get Container Restarts and Score`, `Get NotReady Pods`, `Generate Namspace Score` | This SLI uses kubectl to score namespace health. Produces a value between 0 (completely failing thet test) and 1 (fully passing the test). Looks for container restarts, events, and pods not ready. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-namespace-healthcheck) |
| [Kubernetes Namespace Inspection](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-namespace-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Inspect Warning Events in Namespace `${NAMESPACE}``, `Inspect Container Restarts In Namespace `${NAMESPACE}``, `Inspect Pending Pods In Namespace `${NAMESPACE}``, `Inspect Failed Pods In Namespace `${NAMESPACE}``, `Inspect Workload Status Conditions In Namespace `${NAMESPACE}``, `Get Listing Of Resources In Namespace `${NAMESPACE}``, `Check Event Anomalies in Namespace `${NAMESPACE}``, `Check Missing or Risky PodDisruptionBudget Policies in Namepace `${NAMESPACE}``, `Check Resource Quota Utilization in Namespace `${NAMESPACE}`` | This taskset runs general troubleshooting checks against all applicable objects in a namespace. Looks for warning events, odd or frequent normal events, restarting containers and failed or pending pods. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-namespace-healthcheck) |
| [Kubernetes Persistent Volume Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-pvc-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Fetch Events for Unhealthy Kubernetes PersistentVolumeClaims in Namespace `${NAMESPACE}``, `List PersistentVolumeClaims in Terminating State in Namespace `${NAMESPACE}``, `List PersistentVolumes in Terminating State in Namespace `${NAMESPACE}``, `List Pods with Attached Volumes and Related PersistentVolume Details in Namespace `${NAMESPACE}``, `Fetch the Storage Utilization for PVC Mounts in Namespace `${NAMESPACE}``, `Check for RWO Persistent Volume Node Attachment Issues in Namespace `${NAMESPACE}`` | This taskset collects information about storage such as PersistentVolumes and PersistentVolumeClaims to validate health or help troubleshoot potential storage issues. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-pvc-healthcheck) |
| [Kubernetes Pod Resources Health](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-podresources-health/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Show Pods Without Resource Limit or Resource Requests Set in Namespace `${NAMESPACE}``, `Get Pod Resource Utilization with Top in Namespace `${NAMESPACE}``, `Identify VPA Pod Resource Recommendations in Namespace `${NAMESPACE}``, `Identify Resource Constrained Pods In Namespace `${NAMESPACE}`` | Inspects the resources provisioned for a given set of pods and raises issues or recommendations as necessary. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-podresources-health) |
| [Kubernetes Postgres Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-postgres-triage/runbook.robot) | `AKS`, `EKS`, `GKE`, `Kubernetes`, `Patroni`, `Postgres` | `Get Standard Postgres Resource Information`, `Describe Postgres Custom Resources`, `Get Postgres Pod Logs & Events`, `Get Postgres Pod Resource Utilization`, `Get Running Postgres Configuration`, `Get Patroni Output`, `Run DB Queries` | Runs multiple Kubernetes and psql commands to report on the health of a postgres cluster. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-postgres-triage) |
| [Kubernetes Redis Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-redis-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift`, `Redis` | `Ping `${DEPLOYMENT_NAME}` Redis Workload`, `Verify `${DEPLOYMENT_NAME}` Redis Read Write Operation` | This taskset collects information on your redis workload in your Kubernetes cluster and raises issues if any health checks fail. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-redis-healthcheck) |
| [Kubernetes Restart resource](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-restart-resource/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Get Current Resource State`, `Get Resource Logs`, `Restart Resource` | This taskset restarts a resource with a given set of labels, typically used with other tasksets. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-restart-resource) |
| [Kubernetes Service Account Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-serviceaccount-check/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Test Service Account Access to Kubernetes API Server in Namespace `${NAMESPACE}`` | This taskset provides tasks to troubleshoot service accounts in a Kubernetes namespace. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-serviceaccount-check) |
| [Kubernetes StatefulSet Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-statefulset-healthcheck/runbook.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Check Readiness Probe Configuration for StatefulSet `${STATEFULSET_NAME}``, `Check Liveness Probe Configuration for StatefulSet `${STATEFULSET_NAME}``, `Troubleshoot StatefulSet Warning Events for `${STATEFULSET_NAME}``, `Check StatefulSet Event Anomalies for `${STATEFULSET_NAME}``, `Fetch StatefulSet Logs for `${STATEFULSET_NAME}``, `Get Related StatefulSet `${STATEFULSET_NAME}` Events`, `Fetch Manifest Details for StatefulSet `${STATEFULSET_NAME}``, `List StatefulSets with Unhealthy Replica Counts In Namespace `${NAMESPACE}`` | Triages issues related to a StatefulSet and its replicas. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-statefulset-healthcheck) |
| [Kubernetes Vault Triage](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-vault-healthcheck/runbook.robot) | `AKS`, `EKS`, `GKE`, `Kubernetes`, `Vault` | `Fetch Vault CSI Driver Logs`, `Get Vault CSI Driver Warning Events`, `Check Vault CSI Driver Replicas`, `Fetch Vault Logs`, `Get Related Vault Events`, `Fetch Vault StatefulSet Manifest Details`, `Fetch Vault DaemonSet Manifest Details`, `Verify Vault Availability`, `Check Vault StatefulSet Replicas` | A suite of tasks that can be used to triage potential issues in your vault namespace. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-vault-healthcheck) |
| [Kubernetes cert-manager Healthcheck](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-certmanager-healthcheck/sli.robot) | `Kubernetes`, `AKS`, `EKS`, `GKE`, `OpenShift` | `Count Unready and Expired Certificates` | Counts the number of unhealthy cert-manager managed certificates in a namespace. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-certmanager-healthcheck) |
| [Terraform Cloud Workspace Lock Check](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/terraform-cloud-workspace-lock-check/runbook.robot) | `Terraform Cloud` | `Checking whether the Terraform Cloud Workspace is in a locked state` | Check whether the Terraform Cloud Workspace is in a locked state. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/terraform-cloud-workspace-lock-check) |
| [Test Issues](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/test-issue/runbook.robot) | `Test` | `Raise Full Issue` | A codebundle for testing the issues feature. Purely for testing flow. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/test-issue) |
| [cURL HTTP OK](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/curl-http-ok/sli.robot) | `Linux macOS Windows HTTP` | `Checking HTTP URL Is Available And Timely` | This taskset uses curl to validate the response code of the endpoint. Returns ascore of 1 if healthy, an 0 if unhealthy. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/curl-http-ok) |
| [cli-test-taskset](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/cli-test/runbook.robot) | `cli` | `Run CLI and Parse Output For Issues`, `Exec Test`, `Local Process Test` | This taskset smoketests the CLI codebundle setup and run process [Docs](https://docs.runwhen.com/public/v/cli-codecollection/cli-test) |
| [cmd-test-taskset](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/cmd-test/runbook.robot) | `cmd` | `Run CLI Command`, `Run Bash File`, `Log Suggestion` | This taskset smoketests the CLI codebundle setup and run process by running a bare command [Docs](https://docs.runwhen.com/public/v/cli-codecollection/cmd-test) |
| [k8s-kubectl-cmd-sli](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-kubectl-cmd/sli.robot) | `k8s` | `Run User Provided Kubectl Command` | This taskset runs a user provided kubectl command and pushes the metric. The supplied command must result in distinct single metric. Command line tools like jq are available. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-kubectl-cmd) |
| [k8s-kubectl-cmd-taskset](https://github.com/runwhen-contrib/rw-cli-codecollection/blob/main/codebundles/k8s-kubectl-cmd/runbook.robot) | `k8s` | `Run User Provided Kubectl Command` | This taskset runs a user provided kubectl command andadds the output to the report. Command line tools like jq are available. [Docs](https://docs.runwhen.com/public/v/cli-codecollection/k8s-kubectl-cmd) |

