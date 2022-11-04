output "nsg-id" {
  value = azurerm_network_security_group.nsg-rule.id
}
output "subnet-id" {
  value = azurerm_subnet.internal.id
}

