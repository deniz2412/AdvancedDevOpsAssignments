data "azurerm_resource_group" "rg" {
  name = "RES-GRP-CT360-TUTORING-ADV-7F52F"
}
output "id" {
  value = data.azurerm_resource_group.rg.id
}
output "name" {
  value = data.azurerm_resource_group.rg.name
}
output "location" {
  value = data.azurerm_resource_group.rg.location
}
output "tags" {
  value = data.azurerm_resource_group.rg.tags
}