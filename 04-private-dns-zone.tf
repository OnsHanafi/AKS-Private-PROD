resource "azurerm_private_dns_zone" "aks_dns" {
  name = var.dns_name
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_vnet_link" {
  name                  = "aks-vnet-link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
  virtual_network_id    = azurerm_virtual_network.aks_vnet.id
}

# LINK TO VM VNET TO ENBALE JUMPBOX TO RESOLVE AKS APISER
resource "azurerm_private_dns_zone_virtual_network_link" "aks_vnet_link" {
  name                  = "vm-vnet-link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_dns.name
  virtual_network_id    = azurerm_virtual_network.vm_vnet.id
}