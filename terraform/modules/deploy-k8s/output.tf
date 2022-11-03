output "client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw

}
output "host" {
  value = "${azurerm_kubernetes_cluster.cluster.kube_config.0.host}"
}