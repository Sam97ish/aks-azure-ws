targetScope = 'resourceGroup'

param acrName string = 'acr${uniqueString(resourceGroup().id)}'
param acrSku string = 'Basic'
param tags object
param aksIdentity string

resource acr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: acrName
  location: resourceGroup().location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true
  }
  tags: tags
}

/*
resource acrAttach 'Microsoft.ContainerService/managedClusters/providers/roleAssignments@2020-04-01-preview' = {
  scope: acr
  name: '${aksIdentity}/Microsoft.Authorization/${guid(aksIdentity, acr.id)}'
  properties: {
    roleDefinitionId: resourceId(
      subscription().subscriptionId,
      'Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d'
    )
    principalId: aksIdentity
  }
}
*/

output loginServer string = acr.properties.loginServer
