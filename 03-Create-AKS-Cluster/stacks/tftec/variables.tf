# Global Vars

variable "aks_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group do cluster AKS."
}

variable "analytics_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group de Log Analytics."
}

variable "cx_prefix" {
  type        = string
  description = "O nome do cliente ou produto que será destinado ao projeto."
}

variable "location" {
  type        = string
  default     = "eastus2"
  description = "A região do datacenter onde seus recursos serão criados."
}

variable "global_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos dos recursos globais."
}

variable "acr_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos acr."
}

variable "wks_log_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos log analytics."
}

variable "aks_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos aks."
}

# ACR Vars

variable "acr_name" {
  type        = string
  description = "Nome do Registro de Container. Precisa ser um nome único porque a partir daqui será gerado o nome do registry."
}

variable "acr_enable_admin" {
  type        = string
  description = "Habilita usuário administrativo no Azure Container Registry"
}

# AKS Vars

variable "aks_k8s_version" {
  type        = string
  description = "Versão do Kubernetes para o Kubernetes Services."
}

variable "aks_node_av_zone" {
  type        = list(number)
  default     = [1, 2, 3]
  description = "Lista de zonas de disponibilidade do node AKS."
}

variable "aks_default_node_settings" {
  type        = map(any)
  default     = {}
  description = "Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`."
}

variable "auto_scaling_enabled" {
  type        = bool
  description = "Habilita ou não as opções de autoscaling do default node pool."
}

variable "default_aks_network_cidr" {
  type        = string
  description = "Endereço CIDR da rede do Kubernetes Service."
}

variable "default_aks_dns_ip" {
  type        = string
  description = "IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`)."
}

variable "http_application_routing_enabled" {
  type        = bool
  default     = true
  description = "Habilitar ou não Roteamento HTTP de Aplicação."
}

variable "aks_additional_node_pools" {
  description = "O mapa de objetos para configurar um ou mais node pools adicinais com um número de VMs, seus sizes e Disponibilidade de zona."
  type = map(object({
    additional_node_name           = string
    node_count                     = number
    vm_size                        = string
    node_os_sku                    = string
    zones                          = list(string)
    max_pods                       = number
    os_disk_size                   = number
    node_os                        = string
    cluster_auto_scaling           = bool
    cluster_auto_scaling_min_count = number
    cluster_auto_scaling_max_count = number
    enable_public_ip               = bool
  }))
  default = {}
}

variable "aks_network_plugin" {
  type        = string
  default     = "azure"
  description = "Nome do Network plugin usado pelo Kubernetes Services. Use `azure` para a rede avançada (Azure CNI) ou `kubenet` para a rede básica."
}

variable "network_policy" {
  type        = string
  default     = "azure"
  description = "Nome da Network Policy usada pelo Kubernete Services. Utilize `azure`, `calico` ou `none`."
}

variable "aks_node_name" {
  type        = string
  default     = "default"
  description = "Nome do Default node do Kubernetes Services."
}

variable "aks_node_vm_count" {
  type        = number
  default     = 2
  description = "Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services."
}

variable "aks_max_pods" {
  type        = number
  default     = 30
  description = "Quantidade máxima de Pods por node (dentro do Default node)."
}

variable "aks_node_vm_disk_size" {
  type        = number
  default     = 30
  description = "Tamanho em GB do disco de SO do Node"
}

variable "node_labels" {
  type        = map(string)
  default     = {}
  description = "Mapa de labels que será aplicada ao node Kubernetes."
}

variable "ultra_ssd_enabled" {
  type        = bool
  default     = false
  description = "Usado para especificar se o UltraSSD está habilitado no pool de nós padrão. Default é false."
}

variable "private_cluster_enabled" {
  type        = bool
  default     = false
  description = "Habilita que o cluster teha suas APIs dipostas somente para a rede interna"
}

variable "aks_code" {
  type        = string
  description = "Número do Cluster Kubernetes no ambiente."
}

variable "azure_policy_enabled" {
  type        = bool
  default     = false
  description = "Habilitar ou não o add-on de Azure Policy para Kubernetes."
}

variable "cluster_name" {
  type        = string
  description = "Nome do Cluster Kubernetes."
}

variable "dns_prefix" {
  type        = string
  description = "Prefixo DNS do Cluster Kubernetes."
}

variable "name_pool" {
  type        = string
  description = "Nome do Pool do Cluster Kubernetes."
}

variable "vm_size" {
  type        = string
  description = "Size da VM do default node."
}

variable "os_sku" {
  type        = string
  default     = "AzureLinux"
  description = "Os do sistema operional que será usado para os nós do cluster Kubernetes. Os valores possíveis são AzureLinux e AzureWindows"
}

variable "network_plugin" {
  type        = string
  description = "Modelo de plugin de rede utilizado no Cluster Kubernetes."
}

variable "lb_sku" {
  type        = string
  description = "Modelo de SKU do Load Balancer no cluster Kubernetes."
}

variable "oms_agent_enabled" {
  type        = bool
  default     = true
  description = "Habilita o OMS Agent no Cluster Kubernetes."
}

variable "agents_type" {
  type        = string
  default     = "VirtualMachineScaleSets"
  description = " Tipo de node pool que de ver criado. Valores possíveis são: AvailabilitySet e VirtualMachineScaleSets. Valor padrão é VirtualMachineScaleSets."
}

variable "aks_enable_attach_acr" {
  type        = bool
  description = "Força o attach ou não do Kubernetes Services com o Azure Container Services (Obrigatório verificar a documentação adequada)"

}

variable "aks_is_identity_enabled" {
  type        = bool
  description = "Habilitar ou não o uso de identidade gerenciada."
}

variable "rbac_aad_admin_group_object_ids" {
  type        = any
  default     = null
  description = "Object ID dos grupos com acesso administrativo ao cluster Kubernetes."
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  default     = null
  description = "Habilita Role Based Access Control based com Azure AD"
}

variable "rbac_aad_client_app_id" {
  type        = string
  default     = null
  description = "Client ID da aplicação do Azure Active Directory."
}

variable "rbac_aad_managed" {
  type        = bool
  default     = false
  nullable    = false
  description = " Integração com Azure Active Directory, habilitado, significa que o Azure criará/gerenciará a entidade de Serviço usada para integração."
}

variable "rbac_aad_server_app_id" {
  type        = string
  default     = null
  description = "Server ID do Azure Active Directory Application."
}

variable "rbac_aad_server_app_secret" {
  type        = string
  default     = null
  description = "Server Secret do Azure Active Directory Application."
}

variable "rbac_aad_tenant_id" {
  type        = string
  default     = null
  description = "ID do tenant usada para o aplicativo do Azure Active Directory. Se isso não for especificado, a ID do tenant da assinatura atual será utilizado."
}

variable "role_based_access_control_enabled" {
  type        = bool
  default     = false
  nullable    = false
  description = "Habilitar Role Based Access Control."
}

variable "disable_local_account" {
  type        = bool
  default     = true
  description = "Desabilita o acesso ao cluster com usuários locais."
}

variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "O nível de SKU que deve ser usado para este cluster Kubernetes. Os valores possíveis são Free e Paid"
}

variable "microsoft_defender_enabled" {
  type        = bool
  default     = false
  nullable    = false
  description = "Habilita o Microsoft Defender no cluster. Requer `var.log_analytics_workspace_enabled` como `true`."
}

# Log Analytics Vars 

variable "log_analytics_workspace_name" {
  type        = string
  description = "Nome do workspace do Log Analytics."
}

variable "log_retention_in_days" {
  type        = number
  default     = 30
  description = "Define o número de dias em que os logs serão armazenados no Workspace."
}

# VNET Vars

variable "vnet_name" {
  type        = string
  description = "Nome da VNET."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Nome do Resource Group da VNET."
}

variable "snet_name" {
  type        = string
  description = "Nome da Subnet."
}