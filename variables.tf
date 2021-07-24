variable "resource_group_name" {
  type    = string
  default = "myTFResourceGroup"
}

variable "azurerm_virtual_network" {
  type    = string
  default = "myTFVnet"
}

variable "resource_location" {
  description = "Location of resources"
  type        = string
  default     = "UK South"
}

variable "network_address" {
  description = "Network address space"
  type        = string
  default     = "10.0.0.0/22"
}
