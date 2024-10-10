# Global Vars

variable "api_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group da API Management."
}

variable "web_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group dos Apps Services Web."
}

variable "bigdata_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group de Big Data."
}

variable "aks_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group do cluster AKS."
}

variable "storage_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group de Storages."
}

variable "network_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group de Network."
}

variable "db_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group de Banco de Dados."
}

variable "analytics_resource_group_name" {
  type        = string
  description = "O nome do seu Resource Group de Log Analytics."
}

variable "cx_prefix" {
  type        = string
  description = "O nome do cliente ou produto que será destinado ao projeto."
}

variable "bastion_code" {
  type        = string
  description = "Número do IP Público."
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

variable "api_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos de api management."
}

variable "web_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos do app services."
}

variable "bigdata_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos de big data."
}

variable "aks_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos aks."
}

variable "network_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos network."
}

variable "storage_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos network."
}

variable "redis_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos redis cache."
}

variable "cosmos_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos cosmosdb."
}

variable "appservice_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos app service."
}

variable "pgsql_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos postgresql."
}

variable "apim_tags" {
  type        = map(any)
  default     = {}
  description = "Mapa de caracteres identificando através de `chave = valor` quais são os rótulos do recursos postgresql."
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

variable "aks_node_subnet" {
  type        = string
  description = "Subnet do default node."
}

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

variable "aks_enable_autoscaling" {
  type        = bool
  description = "Habilita ou não as opções de autoscaling do default node pool."
}

variable "default_aks_network_cidr" {
  type        = string
  description = "Endereço CIDR da rede do Kubernetes Service."
}

variable "default_aks_docker_bridge" {
  type        = string
  description = "endereço CIDR para ser usado como Docker Bridge."
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

variable "enable_node_public_ip" {
  type        = bool
  default     = false
  description = "Habilita ou não se os nós devem ter um endereço IP público. Default é false."
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

variable "enable_host_encryption" {
  type        = bool
  default     = false
  description = "Habilita criptografia no default node pool"
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

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  default     = null
  description = "Range de IPs que são liberados para gerência dos server nodes."
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

# Virtual Network Vars

variable "vnet_code_hub" {
  type        = string
  description = "Número da rede HUB no ambiente."
}

variable "vnet_code_spoke1" {
  type        = string
  description = "Número da rede spoke1 no ambiente."
}

variable "vnet_name_hub" {
  type        = string
  description = "Nome da Rede hub a ser consumida pelo ambiente."
}

variable "vnet_name_spoke1" {
  type        = string
  description = "Nome da Rede spoke1 a ser consumida pelo ambiente."
}

variable "address_space_hub" {
  type        = list(string)
  description = "Lista de todos os address spaces que serão usados pela rede hub."
}

variable "address_space_spoke1" {
  type        = list(string)
  description = "Lista de todos os address spaces que serão usados pela rede spoke1."
}

variable "subnets_hub" {
  type        = any
  default     = {}
  description = "Todos os detalhes sobre a sub-rede que será criada na rede HUB."
}

variable "subnets_spoke1" {
  type        = any
  default     = {}
  description = "Todos os detalhes sobre a sub-rede que será criada na rede spoke1"
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "Os servidores DNS a serem usados com a vnet. Omitir ou deixar este campo em branco fará com que o recurso use o DNS padrão do Azure"
}

# Storatge Accounts Vars

variable "storage_accounts" {
  type        = any
  description = "Deve conter as informações das storage accounts num formato de mapa de caracteres. Para consultar os inputs visite a documentação do módulo [clicando aqui](../../modules/storage-account/README.md)"
}

# Redis Cache Vars

variable "redis_server_settings" {
  type        = any
  description = "Configurações opcionais do servidor redis Premium e Standard/Basic SKU"
}

variable "redis_server_configuration" {
  type        = any
  description = " Configurações para instancia do Redis."
}

variable "redis_patch_schedule" {
  type        = any
  description = "Janela para manutenção do Redis. A Janela de Patch dura 5 horas a partir do `start_hour_utc` "
}

# Bastion Host Vars

variable "bastion_name" {
  type        = string
  description = "Nome do Bastion Host."
}

variable "enable_copy_paste" {
  type        = string
  description = "Habilitar função de copiar e colar."
}

variable "bastion_host_sku" {
  type        = string
  description = "SKU utilizado no Bastion Host. Valores aceitáveis: Basic e Standard."
}

variable "bastion_pip_name" {
  type        = string
  description = "Nome do IP válido utilizado no Bastion Host."
}

variable "enable_shareable_link" {
  type        = string
  default     = false
  description = "O recurso Link compartilhável está ativado para o Bastion Host. Suportado apenas quando o `sku` é `Standard`."
}

variable "enable_tunneling" {
  type        = string
  description = "O recurso de Tunneling está ativado para o Bastion Host. Suportado apenas quando o `sku` é `Standard`."
}

variable "bastion_scale_units" {
  type        = string
  default     = 2
  description = "Número de unidades de escala com as quais provisionar o Bastion Host. Os valores possíveis estão entre `2` e `50`. `scale_units` só pode ser alterado quando `sku` for `Standard`. `scale_units` é sempre `2` quando `sku` é `Basic`.."
}

variable "bastion_public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "Define o método de alocação para 0 endereço IP. Os valores possíveis são Static ou Dynamic."
}

variable "bastion_public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "SKU do IP público. Os valores aceitos são Basic e Standard."
}

variable "enable_ip_connect" {
  type        = string
  default     = false
  description = "Habilitar ou não o IP Connect."
}

variable "enable_file_copy" {
  type        = string
  default     = false
  description = "Habilitar ou não o recurso de cópia de arquivo. Suportado apenas para SKU Standard."
}

# NSG Vars

variable "nsg_rules_hub" {
  type        = any
  default     = []
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
}

variable "nsg_rules_spoke1" {
  type        = any
  default     = []
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
}

# HDInsights Vars

variable "hdinsights_settings" {
  type        = any
  description = "Configurações do cluster HDInsight."
}

variable "storage_hdi_name" {
  type        = string
  description = "Nome da Storage Account do HDInsight."
}

variable "storage_hdi_tier" {
  type        = string
  description = "Tier da Storage Account do HDInsight."
}

variable "storage_hdi_rep_type" {
  type        = string
  description = "Replicação da Storage Account do HDInsight."
}

variable "container_hdi_name" {
  type        = string
  description = "Nome do Container do HDInsight."
}

variable "container_hdi_access" {
  type        = string
  description = "Tipo de acesso do Container do HDInsight."
}

# CosmosDB Vars

variable "cosmosdb_name" {
  type        = string
  description = "Nome do CosmosDB Host."
}

variable "cosmosdb_automatic_failover" {
  default     = false
  description = "Determina se o failover automático está habilitado para o CosmosDB criado."
}

variable "cosmosdb_kind" {
  type        = string
  default     = "GlobalDocumentDB"
  description = "Determina o tipo de CosmosDB a ser criado. Pode ser 'GlobalDocumentDB' ou 'MongoDB'."
}

variable "cosmos_consistency_level" {
  default     = "Session"
  description = "O nível de consistência a ser usado para esta conta do CosmosDB. Pode ser 'BoundedStaleness', 'Eventual', 'Session', 'Strong' ou 'ConsistentPrefix'."
}

variable "cosmos_primary_replica_location" {
  type        = string
  description = "O nome da região do Azure para hospedar dados replicados."
}

variable "cosmos_databases" {
  type        = any
  default     = []
  description = "Nome do Bastion Host."
}

variable "cosmos_sql_collections" {
  type        = any
  default     = []
  description = "Nome do Bastion Host."
}

# App Service Vars

variable "service_plan" {
  type        = any
  default     = {}
  description = "Nome do App Service Plan"
}

variable "app_service_name" {
  type        = string
  description = "Nome do App Service."
}

variable "enable_client_affinity" {
  type        = string
  description = "Habilitar ou não o client affinity no App Service."
}

variable "site_config" {
  type        = any
  default     = {}
  description = "Configurações do application settings."
}

variable "app_settings" {
  type        = any
  default     = {}
  description = "Configurações do application settings."
}

variable "app_insights_name" {
  type        = string
  description = "Nome do application insight."
}

variable "appservice_code" {
  type        = string
  description = "Número do App Service no ambiente."
}

# PostgreSQL Vars

variable "pgsql_code" {
  type        = string
  description = "Número do PostgreSQL no ambiente."
}

variable "pgsql_name" {
  type        = string
  description = "Nome do PostgreSQL"
}

variable "pgsql_sku_name" {
  type        = string
  default     = "GP_Gen5_4"
  description = "Especifica o nome do SKU para este servidor PostgreSQL. O nome do SKU segue o padrão de camada + família + núcleos (por exemplo, B_Gen4_1, GP_Gen5_8)."
}

variable "pgsql_storage_mb" {
  type        = number
  default     = 102400
  description = "Armazenamento máximo permitido para um servidor. Os valores possíveis estão entre 5120 MB(5GB) e 1048576 MB(1TB) para SKU Básico e entre 5120 MB(5GB) e 4194304 MB(4TB) para SKUs de uso geral/memória otimizada."
}

variable "pgsql_backup_retention_days" {
  type        = number
  default     = 7
  description = "Dias de retenção de backup para o servidor, os valores suportados estão entre 7 e 35 dias."
}

variable "pgsql_geo_redundant_backup_enabled" {
  type        = bool
  default     = false
  description = "Habilitar georedundância ou não para backup do servidor. Os valores válidos para esta propriedade são Habilitado ou Desabilitado, sem suporte para a camada básica."
}

variable "pgsql_administrator_login" {
  type        = string
  description = "O login do administrador para o servidor PostgreSQL. Alterar isso força a criação de um novo recurso."
}

variable "pgsql_administrator_password" {
  type        = string
  description = "A senha associada ao administrador_login para o PostgreSQL Server."
}

variable "pgsql_server_version" {
  type        = string
  default     = "9.5"
  description = "Especifica a versão do PostgreSQL a ser usada. Os valores válidos são 9.5, 9.6 e 10.0. Alterar isso força a criação de um novo recurso."
}

variable "pgsql_ssl_enforcement_enabled" {
  type        = bool
  default     = true
  description = "Especifica se o SSL deve ser aplicado nas conexões. Os valores possíveis são Ativado e Desativado."
}

variable "pgsql_public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Se o acesso à rede pública é ou não permitido para este servidor. Os valores possíveis são Ativado e Desativado."
}

variable "pgsql_postgresql_configurations" {
  type        = map(string)
  default     = {}
  description = "Um mapa com configurações do PostgreSQL para habilitar."
}

variable "pgsql_db_names" {
  type        = list(string)
  default     = []
  description = "A lista de nomes do Banco de Dados PostgreSQL, que precisa ser um identificador PostgreSQL válido. Alterar isso força a criação de um novo recurso."
}

variable "pgsql_db_charset" {
  type        = string
  default     = "UTF8"
  description = "Especifica o conjunto de caracteres para o banco de dados PostgreSQL, que precisa ser um conjunto de caracteres PostgreSQL válido. Alterar isso força a criação de um novo recurso."
}

variable "pgsql_db_collation" {
  type        = string
  default     = "English_United States.1252"
  description = "Especifica o agrupamento para o banco de dados PostgreSQL, que precisa ser um agrupamento PostgreSQL válido. Observe que a Microsoft usa uma notação diferente - en-US em vez de en_US. Alterar isso força a criação de um novo recurso."
}

# API Management Vars

variable "apim_code" {
  type        = string
  description = "Número da API Manager no ambiente."
}

variable "apim_name" {
  description = "Nome da API Manager."
}

variable "apim_publisher_name" {
  type        = string
  description = "Nome do Publisher."
}

variable "apim_publisher_email" {
  type        = string
  description = "E-mail do Publisher."
}

variable "apim_publisher_sku_name" {
  type        = string
  description = "Tipode SKU da API."
}

variable "apim_name_api" {
  type        = string
  description = "Localidade da API Management."
}

variable "apim_api_revision" {
  type        = string
  description = "Revisão da API Management."
}

variable "apim_api_display_name" {
  type        = string
  description = "Nome de exibição da API Management."
}

variable "apim_api_path" {
  type        = string
  description = "Caminho do API Management."
}
