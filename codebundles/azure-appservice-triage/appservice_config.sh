#!/bin/bash

# ENV:
# AZ_USERNAME
# AZ_SECRET_VALUE
# AZ_SUBSCRIPTION
# AZ_TENANT
# APPSERVICE
# AZ_RESOURCE_GROUP

# # Log in to Azure CLI
# az login --service-principal --username $AZ_USERNAME --password $AZ_SECRET_VALUE --tenant $AZ_TENANT > /dev/null
# # Set the subscription
# az account set --subscription $AZ_SUBSCRIPTION

# Check if AZURE_RESOURCE_SUBSCRIPTION_ID is set, otherwise get the current subscription ID
if [ -z "$AZURE_RESOURCE_SUBSCRIPTION_ID" ]; then
    subscription=$(az account show --query "id" -o tsv)
    echo "AZURE_RESOURCE_SUBSCRIPTION_ID is not set. Using current subscription ID: $subscription"
else
    subscription="$AZURE_RESOURCE_SUBSCRIPTION_ID"
    echo "Using specified subscription ID: $subscription"
fi

# Set the subscription to the determined ID
echo "Switching to subscription ID: $subscription"
az account set --subscription "$subscription" || { echo "Failed to set subscription."; exit 1; }


az webapp show --name  $APPSERVICE --resource-group $AZ_RESOURCE_GROUP --subscription $AZ_SUBSCRIPTION

# TODO: perform config checks