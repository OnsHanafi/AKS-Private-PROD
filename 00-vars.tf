
variable "location" { default = "westeurope" }
variable "prefix" { default = "leadbook-cluster" }
variable "resource_group_name" { default = "rg-leadbook" }
variable "aks_version" { default = "1.29.8" }
variable "aks_name" { default = "leadbook-cluster"}
variable "aks_vm_size" {default = "Standard_B2ms"}
variable "jumpbox_size" { default = "Standard_B1s" }
variable "acr_name" { default = "leadbook-acr" }


