
resource "azurerm_virtual_network" "vnet_ap" {
  name                = "${var.prefix}-VNET-APPGW"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg-name
  tags                = var.tags
}

resource "azurerm_subnet" "internal_ap" {
  name                 = "${var.prefix}-SUBNET-APPGW"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet_ap.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "public-ip" {
  name = "${var.prefix}-PUBLIC-IP-APPGW"
  location = var.location
  resource_group_name = var.rg-name
  allocation_method = "Static"
  tags = var.tags
  sku = "Standard"
  
}
resource "azurerm_application_gateway" "appgw" {
  name = "${var.prefix}-APPGW"
  location = var.location
  resource_group_name = var.rg-name

sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = 0
    max_capacity = 2
  }

  gateway_ip_configuration {
    name      = azurerm_subnet.internal_ap.name
    subnet_id = azurerm_subnet.internal_ap.id
  }

  frontend_port {
    name = "${azurerm_virtual_network.vnet_ap.name}-feport"
    port = 80
  }

  frontend_port {
    name = "https_port"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "${azurerm_virtual_network.vnet_ap.name}-feip"
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }

  backend_address_pool {
    name = "${azurerm_virtual_network.vnet_ap.name}-backendap"
    fqdns =["k8-7f52f-prod-c97c63d1.hcp.westeurope.azmk8s.io"]
  }

  backend_http_settings {
    name                  = "${azurerm_virtual_network.vnet_ap.name}-be-htst"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = "${azurerm_virtual_network.vnet_ap.name}-httplstn"
    frontend_ip_configuration_name = "${azurerm_virtual_network.vnet_ap.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.vnet_ap.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${azurerm_virtual_network.vnet_ap.name}-rqrt"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.vnet_ap.name}-httplstn"
    backend_address_pool_name  = "${azurerm_virtual_network.vnet_ap.name}-backendap"
    backend_http_settings_name = "${azurerm_virtual_network.vnet_ap.name}-be-htst"
    priority = 100
  }

  tags = var.tags
  depends_on = [
    azurerm_virtual_network.vnet_ap,
    azurerm_public_ip.public-ip,
  ]
}
  
