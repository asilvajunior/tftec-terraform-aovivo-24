# Azure Azure Log Analytics
# This module presents an easy way to provision your Azure Log Analytics.

data "azurerm_resource_group" "wks_log" {
  name = var.resource_group_name
}

resource "random_string" "aks" {
  special = false
  lower   = true
  upper   = false
  length  = 4
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 2
}

resource "azurerm_log_analytics_workspace" "wks_log" {
  location            = var.location == null ? data.azurerm_resource_group.wks_log.location : var.location
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_retention_in_days
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "wks_log" {
  location              = var.location == null ? data.azurerm_resource_group.wks_log.location : var.location
  resource_group_name   = var.resource_group_name
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.wks_log.name
  workspace_resource_id = azurerm_log_analytics_workspace.wks_log.id
  tags                  = var.tags

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}
