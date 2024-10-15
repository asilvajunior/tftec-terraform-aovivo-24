

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.attach_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.aks_node](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_dns_ip"></a> [aks\_dns\_ip](#input\_aks\_dns\_ip) | IP do DNS (deve estar dentro do range de IP do `aks_network_cidr`). | `string` | n/a | yes |
| <a name="input_aks_network_cidr"></a> [aks\_network\_cidr](#input\_aks\_network\_cidr) | Endereço CIDR da rede do Kubernetes Service. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | A região do datacenter onde seus recursos serão criados. | `string` | n/a | yes |
| <a name="input_node_subnet"></a> [node\_subnet](#input\_node\_subnet) | Subnet do default node. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da VNET | `string` | n/a | yes |
| <a name="input_vnet_resource_group_name"></a> [vnet\_resource\_group\_name](#input\_vnet\_resource\_group\_name) | Resource Group da rede virtual. | `string` | n/a | yes |
| <a name="input_aci_connector_linux_enabled"></a> [aci\_connector\_linux\_enabled](#input\_aci\_connector\_linux\_enabled) | Habilitar virtual node pool. | `bool` | `false` | no |
| <a name="input_acr_id"></a> [acr\_id](#input\_acr\_id) | ID do ACR a ser integrado com o AKS. | `string` | `""` | no |
| <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools) | O mapa de objetos para configurar um ou mais node pools adicinais com um número de VMs, seus sizes e Disponibilidade de zona. | <pre>map(object({<br/>    additional_node_name           = string<br/>    node_count                     = number<br/>    vm_size                        = string<br/>    zones                          = list(string)<br/>    max_pods                       = number<br/>    os_disk_size                   = number<br/>    node_os                        = string<br/>    node_os_sku                    = string<br/>    cluster_auto_scaling           = bool<br/>    cluster_auto_scaling_min_count = number<br/>    cluster_auto_scaling_max_count = number<br/>    enable_public_ip               = bool<br/>  }))</pre> | `{}` | no |
| <a name="input_agents_type"></a> [agents\_type](#input\_agents\_type) | Tipo de node pool que de ver criado. Valores possíveis são: AvailabilitySet e VirtualMachineScaleSets. Valor padrão é VirtualMachineScaleSets. | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_aks_service_principal_app_id"></a> [aks\_service\_principal\_app\_id](#input\_aks\_service\_principal\_app\_id) | Credencial para conexão com service principal. | `string` | `""` | no |
| <a name="input_aks_service_principal_client_secret"></a> [aks\_service\_principal\_client\_secret](#input\_aks\_service\_principal\_client\_secret) | Credencial para conexão com service principal. | `string` | `""` | no |
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | Application ID da service principal que irá governar o Kubernetes. | `string` | `null` | no |
| <a name="input_auto_scaling_enabled"></a> [auto\_scaling\_enabled](#input\_auto\_scaling\_enabled) | Habilita ou não as opções de autoscaling do default node pool. | `bool` | `false` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | Habilitar ou não o add-on de Azure Policy para Kubernetes. | `bool` | `false` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Nome do Cluster Kubernetes | `string` | `"aks"` | no |
| <a name="input_default_node_settings"></a> [default\_node\_settings](#input\_default\_node\_settings) | Configurações de `max_nodes` e `min_nodes` quando a opção `enable_autoscaling` está definida como `true`. | `map(any)` | `{}` | no |
| <a name="input_disable_local_account"></a> [disable\_local\_account](#input\_disable\_local\_account) | Desabilita o acesso ao cluster com usuários locais. | `bool` | `true` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | O ID do conjunto de criptografia de disco que deve ser usado para os nós e volumes. | `string` | `null` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | Node de DNS do cluster de Kubernetes. | `string` | `"service"` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | Prefixo DNS do Cluster Kubernetes. | `string` | `"aks"` | no |
| <a name="input_enable_attach_acr"></a> [enable\_attach\_acr](#input\_enable\_attach\_acr) | Força o attach ou não do Kubernetes Services com o Azure Container Services | `bool` | `true` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | Habilitar ou não Roteamento HTTP de Aplicação. | `bool` | `true` | no |
| <a name="input_is_identity_enabled"></a> [is\_identity\_enabled](#input\_is\_identity\_enabled) | Habilitar ou não o uso de identidade gerenciada. | `bool` | `false` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Versão do Kubernetes. | `string` | `"1.19.9"` | no |
| <a name="input_lb_sku"></a> [lb\_sku](#input\_lb\_sku) | Modelo de SKU do Load Balancer no cluster Kubernetes. | `string` | `"standard"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | ID do Log Analytics. | `string` | `false` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | Quantidade máxima de Pods por node (dentro do Default node). | `number` | `30` | no |
| <a name="input_microsoft_defender_enabled"></a> [microsoft\_defender\_enabled](#input\_microsoft\_defender\_enabled) | Habilita o Microsoft Defender no cluster. Requer `var.log_analytics_workspace_enabled` como `true`. | `bool` | `false` | no |
| <a name="input_name_pool"></a> [name\_pool](#input\_name\_pool) | Nome do pool do Cluster Kubernetes. | `string` | `"agentpool"` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Modelo de plugin de rede utilizado no Cluster Kubernetes. | `string` | `"kubenet"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Nome da Network Policy usada pelo Kubernete Services. Utilize `azure`, `calico` ou `none`. | `string` | `"azure"` | no |
| <a name="input_node_av_zone"></a> [node\_av\_zone](#input\_node\_av\_zone) | Availability Zones habilitadas para o cluster Kubernetes. | `list(number)` | <pre>[<br/>  1,<br/>  2,<br/>  3<br/>]</pre> | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | Mapa de labels que será aplicada ao node Kubernetes. | `map(string)` | `{}` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Nome do Default node do Kubernetes Services. | `string` | `"default"` | no |
| <a name="input_node_vm_count"></a> [node\_vm\_count](#input\_node\_vm\_count) | Número de Nodes (VMs) que serão criados para o default node do Kubernetes Services. | `number` | `2` | no |
| <a name="input_node_vm_disk_size"></a> [node\_vm\_disk\_size](#input\_node\_vm\_disk\_size) | Tamanho em GB do disco de SO do Node | `number` | `30` | no |
| <a name="input_oms_agent_enabled"></a> [oms\_agent\_enabled](#input\_oms\_agent\_enabled) | Habilita o OMS Agent no Cluster Kubernetes. | `bool` | `true` | no |
| <a name="input_only_critical_addons_enabled"></a> [only\_critical\_addons\_enabled](#input\_only\_critical\_addons\_enabled) | A ativação dessa opção irá marcar o pool de nós padrão com `CriticalAddonsOnly=true:NoSchedule` taint. | `bool` | `null` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | Especifique qual versão do Kubernetes usar para a camada de orquestração. O padrão usado é a versão mais recente do Kubernetes disponível na região | `string` | `null` | no |
| <a name="input_os_sku"></a> [os\_sku](#input\_os\_sku) | Os do sistema operional que será usado para os nós do cluster Kubernetes. Os valores possíveis são AzureLinux e AzureWindows | `string` | `"AzureLinux"` | no |
| <a name="input_password"></a> [password](#input\_password) | Application Secret da service principal que irá governar o Kubernetes Services. | `string` | `null` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Habilita que o cluster teha suas APIs dipostas somente para a rede interna | `bool` | `false` | no |
| <a name="input_rbac_aad_admin_group_object_ids"></a> [rbac\_aad\_admin\_group\_object\_ids](#input\_rbac\_aad\_admin\_group\_object\_ids) | Object ID dos grupos com acesso administrativo ao cluster Kubernetes. | `any` | `null` | no |
| <a name="input_rbac_aad_azure_rbac_enabled"></a> [rbac\_aad\_azure\_rbac\_enabled](#input\_rbac\_aad\_azure\_rbac\_enabled) | Habilita Role Based Access Control based com Azure AD | `bool` | `null` | no |
| <a name="input_rbac_aad_client_app_id"></a> [rbac\_aad\_client\_app\_id](#input\_rbac\_aad\_client\_app\_id) | Client ID da aplicação do Azure Active Directory. | `string` | `null` | no |
| <a name="input_rbac_aad_managed"></a> [rbac\_aad\_managed](#input\_rbac\_aad\_managed) | Integração com Azure Active Directory, habilitado, significa que o Azure criará/gerenciará a entidade de Serviço usada para integração. | `bool` | `false` | no |
| <a name="input_rbac_aad_server_app_id"></a> [rbac\_aad\_server\_app\_id](#input\_rbac\_aad\_server\_app\_id) | Server ID do Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_rbac_aad_server_app_secret"></a> [rbac\_aad\_server\_app\_secret](#input\_rbac\_aad\_server\_app\_secret) | Server Secret do Azure Active Directory Application. | `string` | `null` | no |
| <a name="input_rbac_aad_tenant_id"></a> [rbac\_aad\_tenant\_id](#input\_rbac\_aad\_tenant\_id) | ID do tenant usada para o aplicativo do Azure Active Directory. Se isso não for especificado, a ID do tenant da assinatura atual será utilizado. | `string` | `null` | no |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | Habilitar Role Based Access Control. | `bool` | `false` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | O nível de SKU que deve ser usado para este cluster Kubernetes. Os valores possíveis são Free e Paid | `string` | `"Free"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de caracteres identificando através de `chave = valor` quais são os rótulos dos recursos. | `map(any)` | `{}` | no |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | Usado para especificar se o UltraSSD está habilitado no pool de nós padrão. Default é false. | `bool` | `false` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size da VM do default node | `string` | `"Standard_D2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | n/a |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | n/a |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_cluster_password"></a> [cluster\_password](#output\_cluster\_password) | n/a |
| <a name="output_cluster_username"></a> [cluster\_username](#output\_cluster\_username) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
| <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config) | n/a |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | n/a |

## Deseja contribuir?

Para contruibuir com este repositório você deve instalar o [**Terraform-docs**](https://terraform-docs.io/user-guide/installation/).
Etapas: 
  * Clone este repositório;
  * Crie uma branch;
  * Realize todas as modificações que deseja;
  * Faça o commit e crie uma tag (v1.1.0, v1.2.3, etc);
  * Documente o código usando `make all`;
  * Faça o push da sua branch seguido de um Pull Request.

<sub>Para dúvidas mande um contato: [asilva@unicast.com.br](mailto:asilva@unicast.com.br)</sub>
