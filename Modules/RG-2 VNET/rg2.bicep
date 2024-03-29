targetScope='subscription'

param location string ='East US'

param rgName2 string = 'New2RG'

resource rg2 'Microsoft.Resources/resourceGroups@2023-07-01'={
  name:rgName2
  location:location
}
