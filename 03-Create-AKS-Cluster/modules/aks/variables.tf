variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "location" {
  type        = string
  description = "A região do datacenter onde seus recursos serão criados."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos dos recursos."
}

variable "aci_connector_linux_enabled" {
  type        = bool
  default     = false
  description = "Habilitar virtual node pool."
}

variable "agents_type" {
  type        = string
  default     = "VirtualMachineScaleSets"
  description = " Tipo de node pool que de ver criado. Valores possíveis são: AvailabilitySet e VirtualMachineScaleSets. Valor padrão é VirtualMachineScaleSets."
}

variable "node_labels" {
  type        = map(string)
  default     = {}
  description = "Mapa de labels que será aplicada ao node Kubernetes."
}

variable "only_critical_addons_enabled" {
  type        = bool
  default     = null
  description = "A ativação dessa opção irá marcar o pool de nós padrão com `CriticalAddonsOnly=true:NoSchedule` taint."
}

variable "orchestrator_version" {
  type        = string
  default     = null
  description = "Especifique qual versão do Kubernetes usar para a camada de orquestração. O padrão usado é a versão mais recente do Kubernetes disponível na região"
}

variable "disk_encryption_set_id" {
  type        = string
  default     = null
  description = "O ID do conjunto de criptografia de disco que deve ser usado para os nós e volumes."
}

variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "O nível de SKU que deve ser usado para este cluster Kubernetes. Os valores possíveis são Free e Paid"
}

variable "os_sku" {
  type        = string
  default     = "AzureLinux"
  description = "Os do sistema operional que será usado para os nós do cluster Kubernetes. Os valores possíveis são AzureLinux e AzureWindows"
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource Group da rede virtual."
}

variable "vnet_name" {
  type        = string
  description = "Nome da VNET"
}

variable "node_subnet" {
  type        = string
  description = "Subnet do default node."
}

variable "app_id" {
  type        = string
  default     = null
  description = "Application ID da service principal que irá governar o Kubernetes."
}

variable "password" {
  type        = string
  default     = null
  description = "Application Secret da service principal que irá governar o Kubernetes Services."
}

variable "k8s_version" {
  type        = string
  default     = "1.19.9"
  description = "Versão do Kubernetes."
}
variable "node_name" {
  type        = string
  default     = "default"
  description = "Nome do Default node do Kubernetes Services."
}

variable "node_vm_count" {
  type        = number
  default     = 2
  description = "Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services."
}

variable "max_pods" {
  type        = number
  default     = 30
  description = "Quantidade máxima de Pods por node (dentro do Default node)."
}

variable "node_vm_disk_size" {
  type        = number
  default     = 30
  description = "Tamanho em GB do disco de SO do Node"
}

variable "ultra_ssd_enabled" {
  type        = bool
  default     = false
  description = "Usado para especificar se o UltraSSD está habilitado no pool de nós padrão. Default é false."
}

variable "node_av_zone" {
  type        = list(number)
  default     = [1, 2, 3]
  description = "Availability Zones habilitadas para o cluster Kubernetes."
}

variable "dns_name" {
  type        = string
  default     = "service"
  description = "Node de DNS do cluster de Kubernetes."
}

variable "default_node_settings" {
  type        = map(any)
  default     = {}
  description = "Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`."
}

variable "auto_scaling_enabled" {
  type        = bool
  default     = false
  description = "Habilita ou não as opções de autoscaling do default node pool."
}

variable "aks_network_cidr" {
  type        = string
  description = "Endereço CIDR da rede do Kubernetes Service."
}

variable "aks_dns_ip" {
  type        = string
  description = "IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`)."
}

variable "additional_node_pools" {
  type = map(object({
    additional_node_name           = string
    node_count                     = number
    vm_size                        = string
    zones                          = list(string)
    max_pods                       = number
    os_disk_size                   = number
    node_os                        = string
    node_os_sku                    = string
    cluster_auto_scaling           = bool
    cluster_auto_scaling_min_count = number
    cluster_auto_scaling_max_count = number
    enable_public_ip               = bool
  }))
  default     = {}
  description = "O mapa de objetos para configurar um ou mais node pools adicinais com um número de VMs, seus sizes e Disponibilidade de zona."
}

variable "network_policy" {
  type        = string
  default     = "azure"
  description = "Nome da Network Policy usada pelo Kubernete Services. Utilize `azure`, `calico` ou `none`."
}

variable "azure_policy_enabled" {
  type        = bool
  default     = false
  description = "Habilitar ou não o add-on de Azure Policy para Kubernetes."
}

variable "http_application_routing_enabled" {
  type        = bool
  default     = true
  description = "Habilitar ou não Roteamento HTTP de Aplicação."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = false
  description = "ID do Log Analytics."
}

variable "oms_agent_enabled" {
  type        = bool
  default     = true
  description = "Habilita o OMS Agent no Cluster Kubernetes."
}

variable "cluster_name" {
  type        = string
  default     = "aks"
  description = "Nome do Cluster Kubernetes"
}

variable "dns_prefix" {
  type        = string
  default     = "aks"
  description = "Prefixo DNS do Cluster Kubernetes."
}

variable "name_pool" {
  type        = string
  default     = "agentpool"
  description = "Nome do pool do Cluster Kubernetes."
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2_v2"
  description = "Size da VM do default node"
}

variable "network_plugin" {
  type        = string
  default     = "kubenet"
  description = "Modelo de plugin de rede utilizado no Cluster Kubernetes."
}

variable "lb_sku" {
  type        = string
  default     = "standard"
  description = "Modelo de SKU do Load Balancer no cluster Kubernetes."
}

variable "aks_service_principal_app_id" {
  type        = string
  default     = ""
  description = "Credencial para conexão com service principal."
}

variable "aks_service_principal_client_secret" {
  type        = string
  default     = ""
  description = "Credencial para conexão com service principal."
}

variable "enable_attach_acr" {
  type        = bool
  default     = true
  description = "Força o attach ou não do Kubernetes Services com o Azure Container Services"
}

variable "acr_id" {
  type        = string
  default     = ""
  description = "ID do ACR a ser integrado com o AKS."
}

variable "is_identity_enabled" {
  type        = bool
  default     = false
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

variable "private_cluster_enabled" {
  type        = bool
  default     = false
  description = "Habilita que o cluster teha suas APIs dipostas somente para a rede interna"
}

variable "disable_local_account" {
  type        = bool
  default     = true
  description = "Desabilita o acesso ao cluster com usuários locais."
}

variable "microsoft_defender_enabled" {
  type        = bool
  default     = false
  nullable    = false
  description = "Habilita o Microsoft Defender no cluster. Requer `var.log_analytics_workspace_enabled` como `true`."
}