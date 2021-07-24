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

variable "subnet_name" {
  description = "Name of subnet"
  type        = string
  default     = "mySubnet"
}

variable "azurerm_network_security_group" {
  description = "Name of security group"
  type        = string
  default     = "myNetworkSecurityGroup"
}
variable "azurerm_linux_virtual_machine" {
  description = "Name of VM"
  type        = string
  default     = "myVM"
}

variable "admin_username" {
  description = "Desired username for the provisioned resources"
  type        = string
  default     = "Nawal"
}

variable "admin_password" {
  description = "Desired password for the provisioned resources"
  type        = string
  default     = "sdfhq48SDFdf224sf"
  sensitive   = true
}