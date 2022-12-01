resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "k8-${var.prefix}-cluster"
  location            = var.location
  resource_group_name = var.rg-name
  dns_prefix          = "k8-${var.prefix}-${var.role}"
  


  default_node_pool {
    enable_auto_scaling = false
    name                = "${var.role}pool"
    node_count          = 2
    vm_size             = "Standard_B2s"
    os_sku              = "Ubuntu"
  }


  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "adminuser"
    ssh_key {
      key_data = file("C:/Users/denizh/Documents/Keys/denizkey.txt")

    }
  }
  ingress_application_gateway {
    gateway_id = var.agid

  }
  tags = var.tags

}