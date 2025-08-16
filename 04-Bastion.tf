resource "azurerm_public_ip" "pip-bastion" {
  name                = "pip-bastion"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                   = "bastion"
  resource_group_name    = azurerm_resource_group.this.name
  location               = azurerm_resource_group.this.location
  sku                    = "Developer" # "Standard" # "Basic", "Developer"
  copy_paste_enabled     = true
  file_copy_enabled      = false
  shareable_link_enabled = false
  tunneling_enabled      = true
  ip_connect_enabled     = false

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.vm_subnet.id
    public_ip_address_id = azurerm_public_ip.pip-bastion.id
  }
}