# Azure Resource Groups

resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-${var.cx_prefix}-${var.aks_resource_group_name}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "analytics_rg" {
  name     = "rg-${var.cx_prefix}-${var.analytics_resource_group_name}"
  location = var.location
  tags     = var.global_tags
}

# Data Sources

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.snet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_virtual_network.existing_vnet.resource_group_name
}

# Azure AD Group in Active Directory for AKS Admins

data "azuread_client_config" "existing" {
}

resource "azuread_group" "aks_administrators" {
  display_name            = "${var.aks_resource_group_name}-cluster-administrators"
  owners                  = [data.azuread_client_config.existing.object_id]
  security_enabled        = true
  prevent_duplicate_names = true
  description             = "Azure AKS Kubernetes administrators for the ${var.aks_resource_group_name}-cluster."

  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

data "azurerm_subscription" "principal" {
}

resource "azurerm_role_assignment" "aks_administrators" {
  scope                = data.azurerm_subscription.principal.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.aks_administrators.object_id

  depends_on = [
    azurerm_resource_group.aks_rg,
    azuread_group.aks_administrators
  ]
}

# Terraform Modules

# Azure Container Registry Module

module "acr" {
  source = "../../modules/acr"

  acr_name            = "ACR${var.acr_name}${var.location}"
  enable_admin        = var.acr_enable_admin
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = var.location
  tags                = merge(var.global_tags, var.acr_tags)

  depends_on = [
    azurerm_resource_group.aks_rg
  ]
}

# Azure Log Analytics Module

module "wks_log" {
  source = "../../modules/log_analytics"

  log_analytics_workspace_name = "wkslog-${var.log_analytics_workspace_name}-${var.location}"
  resource_group_name          = azurerm_resource_group.analytics_rg.name
  location                     = var.location
  tags                         = merge(var.global_tags, var.wks_log_tags)
  log_retention_in_days        = var.log_retention_in_days

  depends_on = [
    azurerm_resource_group.analytics_rg
  ]
}

# Azure Kubernetes Servides Module with Log Analytics

module "aks" {
  source = "../../modules/aks"

  # Cluster Configuration
  resource_group_name = azurerm_resource_group.aks_rg.name
  cluster_name        = "aks-${var.cluster_name}-${var.location}-${var.aks_code}"
  location            = var.location
  sku_tier            = var.sku_tier
  k8s_version         = var.aks_k8s_version
  tags                = merge(var.global_tags, var.aks_tags)

  # Default Node Configuration
  name_pool             = var.name_pool
  node_av_zone          = var.aks_node_av_zone
  agents_type           = var.agents_type
  vm_size               = var.vm_size
  os_sku                = var.os_sku
  auto_scaling_enabled  = var.auto_scaling_enabled
  default_node_settings = var.aks_default_node_settings
  max_pods              = var.aks_max_pods
  node_labels           = var.node_labels
  node_vm_disk_size     = var.aks_node_vm_disk_size
  ultra_ssd_enabled     = var.ultra_ssd_enabled

  # Additional Node Configuration
  node_name             = var.aks_node_name
  additional_node_pools = var.aks_additional_node_pools

  # Identity Configuration
  disable_local_account             = var.disable_local_account
  is_identity_enabled               = var.aks_is_identity_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  rbac_aad_managed                  = var.rbac_aad_managed
  rbac_aad_admin_group_object_ids   = [azuread_group.aks_administrators.object_id] # Use object_id


  # Network Configuration
  network_plugin                   = var.network_plugin
  vnet_name                        = data.azurerm_virtual_network.existing_vnet.name
  vnet_resource_group_name         = data.azurerm_virtual_network.existing_vnet.resource_group_name
  aks_network_cidr                 = var.default_aks_network_cidr
  node_subnet                      = data.azurerm_subnet.existing_subnet.name
  aks_dns_ip                       = var.default_aks_dns_ip
  dns_prefix                       = var.dns_prefix
  lb_sku                           = var.lb_sku
  http_application_routing_enabled = var.http_application_routing_enabled
  network_policy                   = var.network_policy

  # Integrations Configuration
  enable_attach_acr          = var.aks_enable_attach_acr
  acr_id                     = module.acr.acr_id
  log_analytics_workspace_id = module.wks_log.analytics_id
  azure_policy_enabled       = var.azure_policy_enabled

  # Advanced Configuration

  depends_on = [
    module.acr,
    module.wks_log,
    azurerm_resource_group.aks_rg,
    azuread_group.aks_administrators
  ]
}