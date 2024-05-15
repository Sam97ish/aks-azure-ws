param aksClusterName string = 'myAKSCluster'
param nodeCount int = 1
param vmSize string = 'Standard_DS2_v2'
param location string = 'eastus'
param tags object

resource aks 'Microsoft.ContainerService/managedClusters@2021-03-01' = {
  name: aksClusterName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: aksClusterName
    agentPoolProfiles: [
      {
        name: 'systempool'
        count: nodeCount
        vmSize: vmSize
        mode: 'System'
      }
      {
        name: 'userpool'
        count: nodeCount
        vmSize: vmSize
        mode: 'User'
        enableAutoScaling: true
        minCount: 1
        maxCount: 5
      }
    ]
    enableRBAC: true
    networkProfile: {
      networkPlugin: 'kubenet'
    }
    addonProfiles: {
      httpApplicationRouting: {
        enabled: false
      }
    }
  }
}

output aksIdentity string = aks.identity.principalId
