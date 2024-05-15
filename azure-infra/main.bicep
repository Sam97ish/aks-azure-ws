targetScope = 'subscription'

param resourceGroupName string = 'AKStestRg'
param location string = 'eastus'

var tags = {
  Env: 'test'
}

module rg './resourceGroup.bicep' = {
  name: 'AKSresourceGroupModule'
  params: {
    name: resourceGroupName
    location: location
    tags: tags
  }
}

module aks './aks.bicep' = {
  name: 'aksModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    aksClusterName: 'myTestAKSCluster'
    nodeCount: 1
    vmSize: 'Standard_DS2_v2'
    location: location
    tags: tags
  }
  dependsOn: [
    rg
  ]
}

/*
module acr './acr.bicep' = {
  name: 'AKSacrModule'
  scope: resourceGroup(resourceGroupName)
  params: {
    acrName: 'AKSmyTestACR'
    aksIdentity: aks.outputs.aksIdentity
    tags: tags
  }
  dependsOn: [
    rg
    aks
  ]
}
*/
