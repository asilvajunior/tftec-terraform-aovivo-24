# Azure Resource Groups

resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-${var.cx_prefix}-${var.aks_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "network_rg" {
  name     = "rg-${var.cx_prefix}-${var.network_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "analytics_rg" {
  name     = "rg-${var.cx_prefix}-${var.analytics_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

# Azure AD Group in Active Directory for AKS Admins

data "azuread_client_config" "existing" {
}

resource "azuread_group" "aks_administrators" {
  display_name            = "${var.aks_resource_group_name}-cluster-administrators"
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

# Azure Virtual Network Module

module "vnet_hub" {
  source = "../../modules/vnet"

  resource_group_name = azurerm_resource_group.network_rg.name
  location            = var.location
  tags                = merge(var.global_tags, var.aks_tags)
  vnet_name           = "vnet-${var.vnet_name_hub}-${terraform.workspace}-${var.location}-${var.vnet_code_hub}"
  address_space       = var.address_space_hub
  subnets             = var.subnets_hub
  dns_servers         = var.dns_servers
  nsg_ids = {
    snet-mgmt-brazilsouth-001 = module.nsg_spoke1.nsg_id
  }

  vnet_peering_settings = {
    "${var.vnet_name_hub}-to-${var.vnet_name_spoke1}-${var.vnet_code_spoke1}" = {
      remote_vnet_id          = module.vnet_spoke1.vnet_id
      allow_forwarded_traffic = true
      allow_gateway_transit   = false
      use_remote_gateways     = false
    }
  }

  depends_on = [
    azurerm_resource_group.network_rg,
    module.nsg_hub
  ]
}

module "vnet_spoke1" {
  source = "../../modules/vnet"

  resource_group_name = azurerm_resource_group.network_rg.name
  location            = var.location
  tags                = merge(var.global_tags, var.aks_tags)
  vnet_name           = "vnet-${var.vnet_name_spoke1}-${terraform.workspace}-${var.location}-${var.vnet_code_spoke1}"
  address_space       = var.address_space_spoke1
  subnets             = var.subnets_spoke1
  dns_servers         = var.dns_servers

  vnet_peering_settings = {
    "${var.vnet_name_spoke1}-${var.vnet_code_spoke1}-to-${var.vnet_name_hub}" = {
      remote_vnet_id          = module.vnet_hub.vnet_id
      allow_forwarded_traffic = true
      allow_gateway_transit   = false
      use_remote_gateways     = false
    }
  }

  depends_on = [
    azurerm_resource_group.network_rg,
    module.nsg_spoke1
  ]
}

# Network Security Groups Module

module "nsg_hub" {
  source = "../../modules/nsg"

  resource_group_name = azurerm_resource_group.network_rg.name
  location            = var.location
  nsg_name            = "nsg-${var.vnet_name_spoke1}-${terraform.workspace}-${var.location}-${var.vnet_code_spoke1}"
  tags                = merge(var.global_tags, var.network_tags)
  rules               = var.nsg_rules_hub

  depends_on = [
    azurerm_resource_group.network_rg
  ]
}

module "nsg_spoke1" {
  source = "../../modules/nsg"

  resource_group_name = azurerm_resource_group.network_rg.name
  location            = var.location
  nsg_name            = "nsg-${var.vnet_name_hub}-${terraform.workspace}-${var.location}-${var.vnet_code_hub}"
  tags                = merge(var.global_tags, var.network_tags)
  rules               = var.nsg_rules_spoke1

  depends_on = [
    azurerm_resource_group.network_rg
  ]
}

# Azure Container Registry Module

module "acr" {
  source = "../../modules/acr"

  acr_name            = "ACR${terraform.workspace}${var.acr_name}${var.location}"
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

  log_analytics_workspace_name = "wkslog-${var.log_analytics_workspace_name}-${terraform.workspace}-${var.location}"
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
  cluster_name        = "aks-${var.cluster_name}-${terraform.workspace}-${var.location}-${var.aks_code}"
  location            = var.location
  sku_tier            = var.sku_tier
  k8s_version         = var.aks_k8s_version
  tags                = merge(var.global_tags, var.aks_tags)

  # Default Node Configuration
  name_pool              = var.name_pool
  node_av_zone           = var.aks_node_av_zone
  agents_type            = var.agents_type
  vm_size                = var.vm_size
  enable_autoscaling     = var.aks_enable_autoscaling
  default_node_settings  = var.aks_default_node_settings
  max_pods               = var.aks_max_pods
  enable_node_public_ip  = var.enable_node_public_ip
  node_labels            = var.node_labels
  enable_host_encryption = var.enable_host_encryption
  node_vm_disk_size      = var.aks_node_vm_disk_size
  ultra_ssd_enabled      = var.ultra_ssd_enabled

  # Additional Node Configuration
  node_name             = var.aks_node_name
  additional_node_pools = var.aks_additional_node_pools

  # Identity Configuration
  disable_local_account             = var.disable_local_account
  is_identity_enabled               = var.aks_is_identity_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  rbac_aad_managed                  = var.rbac_aad_managed
  rbac_aad_admin_group_object_ids   = [azuread_group.aks_administrators.id]

  # Network Configuration
  network_plugin                   = var.network_plugin
  vnet_name                        = module.vnet_spoke1.vnet_name
  vnet_resource_group_name         = azurerm_resource_group.network_rg.name
  aks_network_cidr                 = var.default_aks_network_cidr
  node_subnet                      = var.aks_node_subnet
  aks_dns_ip                       = var.default_aks_dns_ip
  aks_docker_bridge                = var.default_aks_docker_bridge
  dns_prefix                       = var.dns_prefix
  lb_sku                           = var.lb_sku
  http_application_routing_enabled = var.http_application_routing_enabled
  private_cluster_enabled          = var.private_cluster_enabled
  api_server_authorized_ip_ranges  = var.api_server_authorized_ip_ranges
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
    module.vnet_spoke1,
    azuread_group.aks_administrators
  ]
}