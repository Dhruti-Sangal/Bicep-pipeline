targetScope='subscription'

param location string ='East US'

param rgName1 string = 'New1RG'

resource rg1 'Microsoft.Resources/resourceGroups@2023-07-01'={
  name:rgName1
  location:location
}
