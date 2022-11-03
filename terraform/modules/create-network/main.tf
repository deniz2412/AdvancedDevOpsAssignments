
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-VNET"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg-name
  tags                = var.tags
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.prefix}-SUBNET"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "nsg-rule" {
  name                = "${var.prefix}-NSG"
  location            = var.location
  resource_group_name = var.rg-name
  security_rule = [{
      access                     = "Allow"
      description                = "Open connection for SSH"
      destination_address_prefix = "*"
      destination_address_prefixes = []
      destination_application_security_group_ids = []
      destination_port_range     = "22"
      destination_port_ranges = []
      direction                  = "Inbound"
      name                       = "Allow_SSH_Inbound"
      priority                   = 1001
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_address_prefixes = []
      source_application_security_group_ids = []
      source_port_range          = "*"
      source_port_ranges = []
    },
    {
      access                     = "Allow"
      description                = "Open HTTPS connection"
      destination_address_prefix = "*"
      destination_address_prefixes = []
      destination_application_security_group_ids = []
      destination_port_range     = "443"
      destination_port_ranges = []
      direction                  = "Inbound"
      name                       = "Allow_HTTPS_Inbound"
      priority                   = 1021
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_address_prefixes = []
      source_application_security_group_ids = []
      source_port_range          = "*"
      source_port_ranges = []
    },
    {
      access                     = "Allow"
      description                = "Allow HTTP connection"
      destination_address_prefix = "*"
      destination_address_prefixes = []
      destination_application_security_group_ids = []
      destination_port_range     = "80"
      destination_port_ranges = []
      direction                  = "Inbound"
      name                       = "Allow_HTTP_Inbound"
      priority                   = 1011
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_address_prefixes = []
      source_application_security_group_ids = []
      source_port_range          = "*"
      source_port_ranges = []
  }]
  tags = var.tags

}
