# RG Outputs

output "aks_rg_name" {
  value = azurerm_resource_group.aks_rg.name
}

output "ananalytics_rg_name" {
  value = azurerm_resource_group.analytics_rg.name
}

output "rg_location" {
  value = var.location
}

# AAD Outputs

output "azure_ad_group_id" {
  value = azuread_group.aks_administrators.id
}
output "azure_ad_group_objectid" {
  value = azuread_group.aks_administrators.object_id
}

# ACR Outputs

output "acr_id" {
  value     = module.acr.acr_id
  sensitive = true
}

# LOG Outputs

output "log_analytics_id" {
  value     = module.wks_log.analytics_id
  sensitive = true
}

# AKS Outputs

output "client_certificate" {
  value     = module.aks.client_certificate
  sensitive = true
}

output "client_key" {
  value     = module.aks.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.aks.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = module.aks.host
  sensitive = true
}

output "kube_config_raw" {
  value     = module.aks.kube_config_raw
  sensitive = true
}

output "identity" {
  value = module.aks.identity
}