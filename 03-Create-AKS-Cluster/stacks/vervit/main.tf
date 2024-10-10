# Azure Resource Groups

resource "azurerm_resource_group" "api_rg" {
  name     = "rg-${var.cx_prefix}-${var.api_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "web_rg" {
  name     = "rg-${var.cx_prefix}-${var.web_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "bigdata_rg" {
  name     = "rg-${var.cx_prefix}-${var.bigdata_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "rg-${var.cx_prefix}-${var.aks_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "storage_rg" {
  name     = "rg-${var.cx_prefix}-${var.storage_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "network_rg" {
  name     = "rg-${var.cx_prefix}-${var.network_resource_group_name}-${terraform.workspace}"
  location = var.location
  tags     = var.global_tags
}

resource "azurerm_resource_group" "database_rg" {
  name     = "rg-${var.cx_prefix}-${var.db_resource_group_name}-${terraform.workspace}"
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

# Azure Storage Account Module

module "storage" {
  source = "../../modules/storage"

  for_each               = var.storage_accounts
  resource_group_name    = azurerm_resource_group.storage_rg.name
  location               = var.location
  tags                   = merge(var.global_tags, var.storage_tags)
  storage_account_name   = each.key
  tier                   = lookup(each.value, "tier", "Standard")
  kind                   = lookup(each.value, "kind", "StorageV2")
  replication            = lookup(each.value, "replication", "LRS")
  storacc_containers     = lookup(each.value, "storacc_containers", {})
  storacc_shares         = lookup(each.value, "storacc_shares", {})
  static_website_enabled = lookup(each.value, "static_website_enabled", false)
  static_website         = lookup(each.value, "static_website", null)

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

# Azure Redis Cache Module

module "redis" {
  source = "../../modules/redis"

  resource_group_name   = azurerm_resource_group.database_rg.name
  location              = var.location
  tags                  = merge(var.global_tags, var.redis_tags)
  redis_server_settings = var.redis_server_settings
  redis_configuration   = var.redis_server_configuration
  patch_schedule        = var.redis_patch_schedule

  depends_on = [
    azurerm_resource_group.database_rg
  ]
}

# Azure Bastion Host

module "bastion" {
  source = "../../modules/bastion"

  resource_group_name                 = azurerm_resource_group.network_rg.name
  location                            = var.location
  vnet_name                           = module.vnet_hub.vnet_name
  subnet_name                         = lookup(module.vnet_hub.vnet_subnet_names, "AzureBastionSubnet")
  bastion_name                        = "bh-${var.bastion_name}-${terraform.workspace}-${var.location}"
  bastion_host_sku                    = var.bastion_host_sku
  scale_units                         = var.bastion_scale_units
  bastion_pip_name                    = "pip-${var.bastion_pip_name}-${terraform.workspace}-${var.location}-${var.bastion_code}"
  bastion_public_ip_allocation_method = var.bastion_public_ip_allocation_method
  bastion_public_ip_sku               = var.bastion_public_ip_sku
  enable_copy_paste                   = var.enable_copy_paste
  enable_tunneling                    = var.enable_tunneling
  enable_ip_connect                   = var.enable_ip_connect
  enable_file_copy                    = var.enable_file_copy
  tags                                = merge(var.global_tags, var.network_tags)

  depends_on = [
    azurerm_resource_group.network_rg,
    module.vnet_hub
  ]
}

# Azure HDInsights

module "hdinsights" {
  source = "../../modules/hdinsights"

  resource_group_name  = azurerm_resource_group.bigdata_rg.name
  location             = var.location
  tags                 = merge(var.global_tags, var.bigdata_tags)
  hdinsights_settings  = var.hdinsights_settings
  storage_hdi_name     = var.storage_hdi_name
  storage_hdi_tier     = var.storage_hdi_tier
  storage_hdi_rep_type = var.storage_hdi_rep_type
  container_hdi_name   = var.container_hdi_name
  container_hdi_access = var.container_hdi_access
  is_default_storage   = true

  depends_on = [
    azurerm_resource_group.bigdata_rg
  ]
}

# Azure CosmosDB

module "cosmosdb" {
  source = "../../modules/cosmosdb"

  account_name             = "cosmos-${var.cosmosdb_name}-${terraform.workspace}-${var.location}"
  resource_group_name      = azurerm_resource_group.database_rg.name
  location                 = var.location
  kind                     = var.cosmosdb_kind
  automatic_failover       = var.cosmosdb_automatic_failover
  consistency_level        = var.cosmos_consistency_level
  primary_replica_location = var.cosmos_primary_replica_location
  tags                     = merge(var.global_tags, var.cosmos_tags)
  databases                = var.cosmos_databases
  sql_collections          = var.cosmos_sql_collections

  depends_on = [
    azurerm_resource_group.database_rg
  ]
}

# Azure APP Service (Web Apps)

module "appservice" {
  source = "../../modules/appservice"

  resource_group_name    = azurerm_resource_group.web_rg.name
  location               = var.location
  service_plan           = var.service_plan
  app_service_name       = "app-${var.app_service_name}-${terraform.workspace}-${var.location}-${var.appservice_code}"
  enable_client_affinity = var.enable_client_affinity
  site_config            = var.site_config
  app_settings           = var.app_settings
  app_insights_name      = "appins-${var.app_insights_name}-${terraform.workspace}-${var.location}"
  log_analytics_id       = module.wks_log.analytics_id
  wkslog_resource_group  = azurerm_resource_group.analytics_rg.name
  tags                   = merge(var.global_tags, var.appservice_tags)

  depends_on = [
    azurerm_resource_group.web_rg,
    module.wks_log
  ]
}

# Azure PostgreSQL

module "postgresql" {
  source = "../../modules/postgresql"

  pgsql_name                    = "pgsql-${var.pgsql_name}-${terraform.workspace}-${var.location}-${var.pgsql_code}"
  resource_group_name           = azurerm_resource_group.database_rg.name
  location                      = var.location
  sku_name                      = var.pgsql_sku_name
  storage_mb                    = var.pgsql_storage_mb
  backup_retention_days         = var.pgsql_backup_retention_days
  geo_redundant_backup_enabled  = var.pgsql_geo_redundant_backup_enabled
  administrator_login           = var.pgsql_administrator_login
  administrator_password        = var.pgsql_administrator_password
  server_version                = var.pgsql_server_version
  ssl_enforcement_enabled       = var.pgsql_ssl_enforcement_enabled
  public_network_access_enabled = var.pgsql_public_network_access_enabled
  db_names                      = var.pgsql_db_names
  db_charset                    = var.pgsql_db_charset
  db_collation                  = var.pgsql_db_collation
  tags                          = merge(var.global_tags, var.pgsql_tags)

  postgresql_configurations = {
    backslash_quote = "on",
  }

  depends_on = [
    azurerm_resource_group.database_rg,
    module.vnet_spoke1
  ]
}

# Azure API Management

module "apim" {
  source = "../../modules/apim"

  apim_name               = "apim-${var.apim_name}-${terraform.workspace}-${var.location}-${var.apim_code}"
  resource_group_name     = azurerm_resource_group.api_rg.name
  location                = var.location
  apim_publisher_name     = var.apim_publisher_name
  apim_publisher_email    = var.apim_publisher_email
  apim_publisher_sku_name = var.apim_publisher_sku_name
  apim_name_api           = var.apim_name_api
  apim_api_revision       = var.apim_api_revision
  apim_api_display_name   = var.apim_api_display_name
  apim_api_path           = var.apim_api_path
  tags                    = merge(var.global_tags, var.apim_tags)

  depends_on = [
    azurerm_resource_group.api_rg,
    module.wks_log
  ]
}
