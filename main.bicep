targetScope= 'resourceGroup'

param storageAccountName string = 'storract8967'
param vmName string ='myvm8975'
param vnetName string = 'vnet8789'
param location string = resourceGroup().location
param adminUsername string = 'hellouser'
param rgName1 string = 'New1RG'
param rgName2 string = 'New2RG'




module rg1Module 'Modules/RG 1-VM & SA/rg1.bicep'={
  name:'rg1Module'
  scope: subscription()
  params:{
    rgName1:rgName1
    location:location
  }
}

module rg2Module 'Modules/RG-2 VNET/rg2.bicep'={
  name:'rg2Module'
  scope:subscription()
  params:{
    rgName2:rgName2
    location:location
  }
}

module storageAccountModule 'Modules/StorageAccount/sa.bicep' = {
  name: 'storageAccountModule'
  params: {
    location:location
    storageAccountName: storageAccountName
  }
  scope:resourceGroup(rgName1)
}

module vnetModule 'Modules/VirtualNetwork/vnet.bicep' = {
  name: 'networkModule'
  params: {
    
    vnetName: vnetName
    location: location
  }
  scope:resourceGroup(rgName2)
  
}

module vmModule 'Modules/VirtualMachine/vm.bicep' = {
  name: 'vmModule'
  params: {
    vmName: vmName
    //storageAccountId: storageAccountModule.outputs.storageAccountId
    vnetId: vnetModule.outputs.vnetId
    location: location
    adminUsername:adminUsername
  }
  scope:resourceGroup(rgName1)
}

output vmId string = vmModule.outputs.vmId
output storageAccountId string = storageAccountModule.outputs.storageAccountId
output vnetId string = vnetModule.outputs.vnetId
