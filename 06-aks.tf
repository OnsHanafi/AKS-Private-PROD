# ------------------------------------------
#  CLUSTER 
# ------------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  # NOT USED AS THIS IS A PRIVATE CLUSTER
  # dns_prefix          = "${var.prefix}-dns"
  private_dns_zone_id = azurerm_private_dns_zone.aks_dns.id

#  kubernetes_version        = var.aks_version
  automatic_upgrade_channel = "stable"
  private_cluster_enabled = true
  node_resource_group       = "${var.resource_group_name}-${var.aks_name}"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  
  default_node_pool {
    name                 = "general"
    vm_size              = var.aks_vm_size
    vnet_subnet_id       = azurerm_subnet.aks_subnet.id
#    orchestrator_version = var.aks_version
    type                 = "VirtualMachineScaleSets"
    auto_scaling_enabled = true
    node_count           = 1
    min_count            = 1
    max_count            = 10

    node_labels = {
      role = "generale"
    }

  }
  

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    
  }

  auto_scaler_profile {
    skip_nodes_with_local_storage = false
  }
  # ignore node count since enabling node autoscaling
  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  # SEARCH WHAT THIS DOES
  # web_app_routing {
  #   dns_zone_ids = []
  # }

}

# -------------------------
# Node POOL - For Autoscaling
# -------------------------
#resource "azurerm_kubernetes_cluster_node_pool" "spot" {
#  name                  = "spot"
#  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#  vm_size               = var.aks_vm_size
#  vm_size               = var.aks_spot_size
#  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
#  orchestrator_version  = var.aks_version
#  priority              = "Spot"
#  spot_max_price        = -1
#  eviction_policy       = "Delete"

#  auto_scaling_enabled = true
#  node_count          = 1
#  min_count           = 1
#  max_count           = 10

#  node_labels = {
#    role                                    = "spot"
#    "kubernetes.azure.com/scalesetpriority" = "spot"
#  }
  

#  node_taints = [
#    "spot:NoSchedule",
#   "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
#  ]


  

#  lifecycle {
#    ignore_changes = [node_count]
#  }
#}



# ------------------------------------------
#  ACR Connection  
# ------------------------------------------
resource "azurerm_role_assignment" "this" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}





