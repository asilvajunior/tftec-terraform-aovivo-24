output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_location" {
  value = azurerm_virtual_network.vnet.location
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "vnet_subnet_names" {
  value = tomap(
    {
      for name, subnet in azurerm_subnet.subnet : name => subnet.name
    }
  )
}

output "vnet_subnet_ids" {
  value = tomap(
    {
      for id, subnet in azurerm_subnet.subnet : id => subnet.id
    }
  )
}



