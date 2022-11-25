resource "azurerm_storage_account" "tfstate_ac" {
  name = "denizhstorageaccount"
  resource_group_name = var.rg-name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags= var.tags
  
}
resource "azurerm_storage_container" "tfstate" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.tfstate_ac.name
  container_access_type = "blob"
}


