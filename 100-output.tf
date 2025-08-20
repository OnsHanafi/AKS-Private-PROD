output "rg_name" {
  value = azurerm_resource_group.this.name
}

#----------------------
# AKS OUTPUT
#----------------------
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster"
}



#----------------------
# JUMPBOX OUTPUT
#----------------------
output "vm_id" {
 value = azurerm_linux_virtual_machine.jumpbox.id
}

#----------------------
# BASTION OUTPUT
#----------------------


#-----------------------
# INGRESS + CERTMANAGER
#-----------------------
