resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_location

  tags = {
    Environment = "Terraform Demo"
    Team        = "DevOps"
  }

}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_virtual_network
  address_space       = ["${var.network_address}"]
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    environment = "Terraform Demo"
  }
}

# Create network subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}

# Create public IP address

resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "myPublicIP"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}

# Create Network Security Group
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = var.azurerm_network_security_group
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Create virtual network interface card
resource "azurerm_network_interface" "myterraformnic" {
  name                = "myNIC"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "connect_security_group_to_nic" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = var.azurerm_linux_virtual_machine
  location              = var.resource_location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.myterraformnic.id]
  size                  = "Standard_DS1_v2"


  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = var.azurerm_linux_virtual_machine
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  


  boot_diagnostics {
    storage_account_uri = null
  }

  tags = {
    environment = "Terraform Demo"
  }
}
