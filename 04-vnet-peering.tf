# -------------------------
# VNet Peering
# -------------------------
resource "azurerm_virtual_network_peering" "vm_to_aks" {
  name                      = "vm-to-aks"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.vm_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.aks_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}

resource "azurerm_virtual_network_peering" "aks_to_vm" {
  name                      = "aks-to-vm"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.aks_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.vm_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
