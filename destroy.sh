#!/bin/env bash

resourceGroupName="${1:-AKStestRg}"

# Delete the resource group
az group delete --name $resourceGroupName --yes