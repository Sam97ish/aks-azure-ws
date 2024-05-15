targetScope = 'subscription'

param name string = 'testRg'
param location string = 'eastus'
param tags object

resource testRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
  tags: tags
}
