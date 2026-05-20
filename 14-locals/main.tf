locals {
  a = 10
}

output "a" {
  value = local.a
}

resource "azurerm_public_ip" "frontend" {
  name                = "frontend1"
  location            = "Denmark East"
  resource_group_name = "denmark-east-rg"
  allocation_method   = "Static"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic1"
  location            = "Denmark East"
  resource_group_name = "denmark-east-rg"

  ip_configuration {
    name                          =  "frontend-nic1"
    subnet_id                     = "/subscriptions/3f2e42e1-ca06-4a99-8c56-be8d8ba306db/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/workstation-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend.id
  }
}

provider "azurerm" {
  features {}
}
