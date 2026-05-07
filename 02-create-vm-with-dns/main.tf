# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create Public IP
resource "azurerm_public_ip" "main" {
  name                = "test-public-ip"
  location            = "East US"
  resource_group_name = "denmark-east-rg"

  allocation_method = "Static"
}

# Create Network Interface
resource "azurerm_network_interface" "main" {
  name                = "test-nic"
  location            = "East US"
  resource_group_name = "denmark-east-rg"

  ip_configuration {
    name                          = "testconfiguration1"

    subnet_id = "/subscriptions/cde5241e-289a-449b-b2b7-4efcf2d5c83c/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/Terraform-vnet/subnets/default"

    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.main.id
  }
}

# Create Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {

  name                = "test-vm"
  location            = "East US"
  resource_group_name = "denmark-east-rg"

  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  size = "Standard_D2s_v3"

  source_image_id = "/subscriptions/cde5241e-289a-449b-b2b7-4efcf2d5c83c/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/image/images/Imagedefinition/versions/1.0.0"

  admin_username = "Devops"
  admin_password = "DevOps@123456"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
