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

output "aks_cluster_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.raw_kube_config
  description = "The raw kubeconfig to access the AKS cluster"
  sensitive = true
}

#----------------------
# JUMPBOX OUTPUT
#----------------------
output "vm_id" {
 value = azurerm_linux_virtual_machine.jumpbox.id
}
output "jumpbox_internal_ip" {
  value       = azurerm_network_interface.jumpbox.private_ip_address
  description = "The internal IP address of the Jumpbox VM"
}

#----------------------
# BASTION OUTPUT
#----------------------

output "bastion_host_ip" {
  value       = azurerm_public_ip.bastion.ip_address
  description = "The public IP of the Bastion host"
}
output "bastion_fqdn" {
  value       = azurerm_public_ip.bastion.fqdn
  description = "The FQDN of the Bastion host"
}

#-----------------------
# INGRESS + CERTMANAGER
#-----------------------

output "ingress_controller_ip" {
  value       = azurerm_public_ip.external_nginx.ip_address
  description = "The public IP of the Ingress controller"
}

output "certmanager_namespace" {
  value       = kubernetes_namespace.cert_manager.metadata.0.name
  description = "The namespace where CertManager is deployed"
}

output "deployment_status" {
  value       = "Deployment completed successfully!"
  description = "Confirmation message after deployment"
}