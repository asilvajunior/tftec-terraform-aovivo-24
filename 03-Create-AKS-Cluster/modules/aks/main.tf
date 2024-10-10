# Azure Kubernetes Services
# This module presents an easy way to provision your Azure Kubernetes Services.

data "azurerm_client_config" "aks" {
}

data "azurerm_resource_group" "aks" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "vnet" {
  name = var.vnet_resource_group_name
}

data "azurerm_virtual_network" "aks" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet.name
}

data "azurerm_subnet" "aks_node" {
  name                 = var.node_subnet
  resource_group_name  = data.azurerm_resource_group.vnet.name
  virtual_network_name = data.azurerm_virtual_network.aks.name
}

# AKS Cluster

resource "azurerm_kubernetes_cluster" "aks" {

  resource_group_name              = var.resource_group_name
  name                             = var.cluster_name
  location                         = var.location == null ? data.azurerm_resource_group.aks.location : var.location
  sku_tier                         = var.sku_tier
  kubernetes_version               = var.k8s_version
  local_account_disabled           = var.disable_local_account
  http_application_routing_enabled = var.http_application_routing_enabled
  private_cluster_enabled          = var.private_cluster_enabled
  api_server_authorized_ip_ranges  = var.api_server_authorized_ip_ranges
  azure_policy_enabled             = var.azure_policy_enabled
  dns_prefix                       = var.dns_prefix
  tags                             = var.tags

  default_node_pool {

    name                   = var.name_pool
    zones                  = var.node_av_zone
    type                   = var.agents_type
    vm_size                = var.vm_size
    enable_auto_scaling    = var.enable_autoscaling
    max_count              = var.enable_autoscaling == true ? lookup(var.default_node_settings, "max_count", null) : null
    min_count              = var.enable_autoscaling == true ? lookup(var.default_node_settings, "min_count", null) : null
    node_count             = lookup(var.default_node_settings, "node_count", var.node_vm_count)
    enable_node_public_ip  = var.enable_node_public_ip
    node_labels            = var.node_labels
    enable_host_encryption = var.enable_host_encryption
    os_disk_size_gb        = var.node_vm_disk_size
    ultra_ssd_enabled      = var.ultra_ssd_enabled
    vnet_subnet_id         = data.azurerm_subnet.aks_node.id
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled && var.rbac_aad_managed ? ["rbac"] : []

    content {
      admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      azure_rbac_enabled     = var.rbac_aad_azure_rbac_enabled
      managed                = true
      tenant_id              = var.rbac_aad_tenant_id
    }
  }
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled && !var.rbac_aad_managed ? ["rbac"] : []

    content {
      client_app_id     = var.rbac_aad_client_app_id
      managed           = false
      server_app_id     = var.rbac_aad_server_app_id
      server_app_secret = var.rbac_aad_server_app_secret
      tenant_id         = var.rbac_aad_tenant_id
    }
  }

  dynamic "service_principal" {
    for_each = var.is_identity_enabled ? [] : [1]
    content {
      client_id     = var.aks_service_principal_app_id
      client_secret = var.aks_service_principal_client_secret
    }
  }

  dynamic "identity" {
    for_each = var.is_identity_enabled ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender_enabled ? ["microsoft_defender"] : []

    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  network_profile {
    network_plugin     = var.network_plugin
    load_balancer_sku  = var.lb_sku
    network_policy     = var.network_policy
    service_cidr       = var.aks_network_cidr
    docker_bridge_cidr = var.aks_docker_bridge
    dns_service_ip     = var.aks_dns_ip
  }
}

# AKS Additional Node Pool

resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  lifecycle {
    ignore_changes = [node_count]
  }

  for_each = var.additional_node_pools

  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.value.additional_node_name #each.value.node_os == "linux" ? substr(each.key, 0, 6) : substr(each.key, 0, 12)
  orchestrator_version  = var.k8s_version
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size
  zones                 = each.value.zones
  max_pods              = each.value.max_pods != null ? each.value.max_pods : 60
  os_disk_size_gb       = each.value.os_disk_size
  os_type               = each.value.node_os
  vnet_subnet_id        = data.azurerm_subnet.aks_node.id
  enable_auto_scaling   = each.value.cluster_auto_scaling
  min_count             = each.value.cluster_auto_scaling_min_count
  max_count             = each.value.cluster_auto_scaling_max_count
  enable_node_public_ip = each.value.enable_public_ip
  tags                  = var.tags
}

# Attach Azure Container Registry

resource "azurerm_role_assignment" "attach_acr" {
  count = var.enable_attach_acr ? 1 : 0

  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = data.azurerm_client_config.aks.object_id
  skip_service_principal_aad_check = true
}