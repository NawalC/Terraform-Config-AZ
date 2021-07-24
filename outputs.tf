output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "public_ip_address" {
  value = azurerm_public_ip.myterraformpublicip.ip_address
}