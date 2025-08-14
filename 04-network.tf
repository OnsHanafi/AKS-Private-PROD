
# ------------------------------------------
# AKS VNET + SUBNET
# ------------------------------------------
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "lead-vnet"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
}

# -------------------------
# Jumpbox VNet
# -------------------------
resource "azurerm_virtual_network" "vm_vnet" {
  name                = "vm-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = "jumpbox-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = ["10.1.1.0/24"]

}
