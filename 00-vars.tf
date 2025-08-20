#AZ AUTH
variable "subscription_id" {}
variable "tenant_id" {}

variable "location" { default = "West Europe" }
variable "prefix" { default = "leadbook-cluster" }
variable "resource_group_name" { default = "rg-leadbook" }
# variable "aks_version" { default = "1.29.8" }
variable "aks_name" { default = "leadbook-cluster"}
variable "aks_vm_size" {default = "Standard_B2ms"}
variable "aks_spot_size" {default = "Standard_D2s_v3"}
variable "jumpbox_size" { default = "Standard_F2s_v2" }
variable "acr_name" { default = "leadbookacr" }
variable "dns_name" { default = "privatelink.westeurope.azmk8s.io"}


