
resource "azurerm_network_interface" "network-interface" {
  name = "${var.prefix}-${var.vm-name}-NIC"
  location = var.location
  resource_group_name = var.rg-name
  ip_configuration {
    name = "${var.vm-name}-NIC-CONFIG"
    subnet_id = var.subnet-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }
  tags = var.tags
}
resource "azurerm_public_ip" "public-ip" {
  name = "${var.prefix}-${var.vm-name}-PUBLIC-IP"
  location = var.location
  resource_group_name = var.rg-name
  allocation_method = "Static"
  domain_name_label= var.domain_name_label
  tags = var.tags
  
}
resource "azurerm_network_interface_security_group_association" "NSG-A" {
  network_interface_id = azurerm_network_interface.network-interface.id
  network_security_group_id = var.NSG-ID
}


resource "azurerm_linux_virtual_machine" "vm" {
  location = var.location
  name = "${var.prefix}-VM-${var.vm-name}"
  resource_group_name = var.rg-name
  size = "Standard_B2s"
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.network-interface.id,
  ]
   admin_ssh_key {
     username = "adminuser"
     public_key = file("C:/Users/denizh/Documents/Keys/denizkey.txt")
   }
   os_disk {
     caching = "ReadWrite"
     storage_account_type = "Premium_LRS"
   }

   source_image_reference {
     publisher = "canonical"
     offer ="0001-com-ubuntu-server-focal"
     sku = "20_04-lts-gen2"
     version = "latest"
   }
   tags = var.tags
}