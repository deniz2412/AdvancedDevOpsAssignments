output "client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.cluster.name
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw

}
output "host" {
  value = azurerm_kubernetes_cluster.cluster.kube_config.0.host
}