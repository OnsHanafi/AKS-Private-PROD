provider "azurerm" {
    features {}
    skip_provider_registration = true
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.16.0"
    }
  }
}
