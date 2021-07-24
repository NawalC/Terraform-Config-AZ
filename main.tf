resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_location

  tags = {
    Environment = "Terraform Getting Started"
    Team        = "DevOps"
  }

}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_virtual_network
  address_space       = ["${var.network_address}"]
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name
}

