# Azure Virtual Machine Health
This codebundle runs a suite of metrics checks for VMs in Azure. It identifies:
- List Key Vault Availability
- Check Key Vault Configuration
- Check Expiring Key Vault Items (Keys, Secrets and Certificates)
- Check Key Vault Logs for Issues

## Configuration

The TaskSet requires initialization to import necessary secrets, services, and user variables. The following variables should be set:

- `AZ_USERNAME`: Service principal's client ID
- `AZ_SECRET_VALUE`: The credential secret value from the app registration
- `AZ_TENANT`: The Azure tenancy ID
- `AZ_SUBSCRIPTION`: The Azure subscription ID

## Testing 
See the .test directory for infrastructure test code. 

## Notes

This codebundle assumes the service principal authentication flow