variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
}

variable "location" {
  type        = string
  description = "Localidade do Azure Container Registry"
}

variable "vnet_name" {
  description = "Nome da vnet"
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "Espaço de endereço utilizado pela vnet"
}

variable "subnets" {
  type        = any
  default     = {}
  description = "Todos os detalhes sobre a sub-rede que será criada."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Todos os detalhes sobre a sub-rede que será criada. Deve usar as seguintes entradas: <table><thead><tr><th>Nome</th><th>Tipo</th><th>Padrão</th><th>Descrição</th><th> Obrigatório</th></tr></thead><tbody><tr><td>nome</td><td>`string`</td><td>n/d</td><td> Este **deve ser usado como a chave do seu mapa**</td><td>yes</td></tr><tr><td>address_prefix</td><td>`string`</td ><td>n/d</td><td>Endereço CIDR de sub-rede</td><td>sim</td></tr><tr><td>service_endpoints</td><td>`list( string)`</td><td>`null`</td><td>Pontos de extremidade de serviço a serem usados ​​com esta sub-rede. Os valores aceitos são: `Microsoft.AzureActiveDirectory`, `Microsoft.CosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage `, `Microsoft.Web`</td><td>não</td></tr><tr><td>enforce_private_link_endpoint_network_policies</td><td>`bool`</td><td>`null` </td><td>Ative ou desative as políticas de rede para o endpoint de link privado na sub-rede. Definir isso como `true` **Desativa** a política e definir isso como `false` **Ativar** a política. *Observação*: Conflitos com `enforce_private_link_service_network_policies`.</td><td>não</td></tr><tr><td>enforce_private_link_service_network_policies</td><td>`bool`</td><td> `null`</td><td>Ative ou desative as políticas de rede para o serviço de link privado na sub-rede. Definir isso como `true` **Desativa** a política e definir isso como `false` **Ativar** a política. *Observação*: Conflitos com `enforce_private_link_endpoint_network_policies`.</td><td>sem</td></tr><tr><td>delegação</td><td>`map(any)`</td> <td>`null`</td><td>deve ter os seguintes detalhes: <table><thead><tr><th>Nome</th><th>Tipo</th><th>Padrão</th> th><th>Descrição</th><th>Obrigatório</th></tr></thead><tbody><tr><td>nome</td><td>`string`</td> <td>n/d</td><td>Nome de sua delegação de sub-rede</td><td>sim</td></tr><tr><td>service_actions</td><td>`map (qualquer)`</td><td>n/a</td><td>Deve seguir a mesma estrutura que a [documentação oficial](https://registry.terraform.io/providers/hashicorp/azurerm/latest /docs/resources/subnet#service_delegation) para este atributo de bloco</td><td>sim</td></tr></tbody></table></td><td>não</td>< /tr></tbody></table>"
}

variable "vnet_peering_settings" {
  type        = any
  default     = null
  description = "Mapa que descreve todas as configurações de emparelhamento de vnet. Aceita os seguintes valores: <table><thead><tr><th>Nome</th><th>Tipo</th><th>Padrão</th><th>Descrição</th><th>Obrigatório </th></tr></thead><tbody><tr><td>nome</td><td>`string`</td><td>n/d</td><td>Este é a chave para a variável map. Você deve digitar um nome para o emparelhamento de vnet</td><td>yes</td></tr><tr><td>remote_vnet_id</td><td>`string`</td><td>n /a</td><td>ID de recurso de rede virtual remota</td><td>sim</td></tr><tr><td>allow_forwarded_traffic</td><td>`bool`</td ><td>`true`</td><td>Isso especifica se esta vnet deve aceitar tráfego encaminhado</td><td>não</td></tr><tr><td>allow_gateway_transit</td> <td>`bool`</td><td>`false`</td><td>Se você tiver um Gateway VPN ou Circuito ExpressRoute, você pode habilitar esta opção. Caso contrário, deixe como está.</td><td>não</td></tr><tr><td>use_remote_gateways</td><td>`bool`</td><td>`false `</td><td>Se sua rede virtual peer tiver um VPN Gateway ou Circuito ExpressRoute, você pode habilitar esta opção. Caso contrário, deixe como está.</td><td>não</td></tr></tbody></table>"
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "Os servidores DNS a serem usados com a vnet. Omitir ou deixar este campo em branco fará com que o recurso use o DNS padrão do Azure"
}

variable "nsg_ids" {
  type        = map(string)
  default     = {}
  description = "Mapa de Network Security Group IDs."
}

variable "route_tables_ids" {
  type        = map(string)
  default     = {}
  description = "Mapa de Route table ids."
}

variable "nat_gateway_ids" {
  type        = map(string)
  default     = {}
  description = "Mapa de NAT Gateway ids."
}

variable "subnet_service_endpoints" {
  type        = map(any)
  default     = {}
  description = "Nome de sub-rede para pontos de extremidade de serviço para adicionar à sub-rede."
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = map(bool)
  default     = {}
  description = "Nome de sub-rede para habilitar/desabilitar políticas de rede de endpoint de link privado na sub-rede."
}

variable "subnet_enforce_private_link_service_network_policies" {
  type        = map(bool)
  default     = {}
  description = "Nome da sub-rede para habilitar/desabilitar as políticas de rede do serviço de link privado na sub-rede."
}