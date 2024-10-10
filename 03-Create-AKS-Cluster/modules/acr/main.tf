# Azure Container Registry
# This module presents an easy way to provision your Azure Container Registry.

data "azurerm_resource_group" "acr" {
  name = var.resource_group_name
}

resource "random_string" "acr" {
  special = false
  lower   = true
  upper   = false
  length  = 4
}

resource "random_id" "acr_name_suffix" {
  byte_length = 2
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${random_id.acr_name_suffix.dec}"
  resource_group_name = var.resource_group_name
  location            = var.location == null ? data.azurerm_resource_group.acr.location : var.location
  sku                 = var.sku
  admin_enabled       = var.enable_admin
  tags                = var.tags
}