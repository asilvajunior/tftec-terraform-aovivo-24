#01 - Global Vars
location  = "brazilsouth"
cx_prefix = "tftec"
global_tags = {
  ambiente    = "ao vivo sao paulo 2024"
  empresa     = "tftec"
  provisioner = "terraform"
}


#02 - RGs Vars
aks_resource_group_name       = "kubernetes"
analytics_resource_group_name = "analytics"


#03 - VNET Vars
vnet_name                = "vnet-spoke-live-brazilsouth-001"
vnet_resource_group_name = "rg-tftec-network-live"
snet_name                = "snet-aks-brazilsouth-001"


#04 - AKS Vars
# Cluster Configuration
aks_code        = "001"
cluster_name    = "tftec"
sku_tier        = "Free"
aks_k8s_version = "1.30.0"
aks_tags = {
  "nome do aplicativo" = "tftec_app"
  "centro de custo"    = "TFTEC AO VIVO SP 2024"
  "nome do aprovador"  = "Antonio Junior"
  "equipe"             = "devops"
}
# Default Node Configuration
name_pool             = "systempool"
os_sku                = "AzureLinux"
aks_node_av_zone      = ["1", "2", "3"]
agents_type           = "VirtualMachineScaleSets"
vm_size               = "Standard_D2_v2"
auto_scaling_enabled  = true
aks_max_pods          = 30
aks_node_vm_disk_size = 200
ultra_ssd_enabled     = false
aks_default_node_settings = {
  node_count = 1
  min_count  = 1
  max_count  = 3
}
# Additional Node Configuration
aks_node_name = "default"
aks_additional_node_pools = {
  application_node_pool_1 = {
    additional_node_name           = "apppool"
    node_os                        = "Linux"
    node_os_sku                    = "AzureLinux"
    vm_size                        = "Standard_D2_v2"
    os_disk_size                   = 200
    max_pods                       = 50
    zones                          = ["1", "2", "3"]
    cluster_auto_scaling           = true
    cluster_auto_scaling_min_count = 1
    cluster_auto_scaling_max_count = 10
    enable_public_ip               = false
    node_count                     = 2
  }
}
# Identity Configuration
disable_local_account             = true
role_based_access_control_enabled = true
rbac_aad_managed                  = true
aks_enable_attach_acr             = true
aks_is_identity_enabled           = true
# Network Configuration
network_plugin                   = "azure"
default_aks_network_cidr         = "11.0.0.0/22"
default_aks_dns_ip               = "11.0.0.10"
dns_prefix                       = "tftec"
lb_sku                           = "standard"
http_application_routing_enabled = false
private_cluster_enabled          = true
network_policy                   = "azure"
# Integrations Configuration
azure_policy_enabled       = true
microsoft_defender_enabled = false
## ACR Vars
acr_name         = "tftec"
acr_enable_admin = true
acr_tags = {
  "nome do aplicativo" = "acrtftec"
  "centro de custo"    = "TFTEC AO VIVO SP 2024"
  "nome do aprovador"  = "Antonio Junior"
  equipe               = "devops"
}
## LOG Vars
log_analytics_workspace_name = "tftec"
log_retention_in_days        = 30
wks_log_tags = {
  "nome do aplicativo" = "logstftec"
  "centro de custo"    = "monitoramento"
  "nome do aprovador"  = "Antonio Junior"
  "equipe"             = "NOC"
}