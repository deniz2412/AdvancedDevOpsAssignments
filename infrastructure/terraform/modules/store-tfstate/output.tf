output "access_key" {
  value     = azurerm_storage_account.tfstate_ac.primary_access_key
  sensitive = true
}
output "storage_acc_name"{
  value = azurerm_storage_account.tfstate_ac.name
}
output "container_name" {
  value = azurerm_storage_container.tfstate.name
}
