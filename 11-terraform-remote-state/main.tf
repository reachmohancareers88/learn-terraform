provider "azurerm" {
  features {}
}


terraform {
  backend "azurerm" {
    resource_group_name  = "denmark-east-rg"
    storage_account_name = "rdevopsb89"
    container_name       = "tfstates"
    key                  = "demo/terraform.tfstate"

    ## This option is to avoid multiple terraform runs in parallel.
    use_lockfile 	= true
  }
}

output "test" {
  value = "test"
}

