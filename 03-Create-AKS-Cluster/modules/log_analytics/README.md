

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_solution.wks_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.wks_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [random_id.log_analytics_workspace_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_string.aks](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_resource_group.wks_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | A região do datacenter onde seus recursos serão criados. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Nome do workspace do Log Analytics. É obrigatório caso `enable_log_analytics_workspace` for marcado como `true` | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_location"></a> [log\_analytics\_workspace\_location](#input\_log\_analytics\_workspace\_location) | A região do datacenter onde seu workspace será criado. | `string` | `"eastus2"` | no |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | Define a SKU utilizada pelo Log Analytics Workspace. | `string` | `"PerGB2018"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | Define o número de dias em que os logs serão armazenados no Workspace. | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Mapa de caracteres identificando através de `chave = valor` quais são os rótulos dos recursos. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_analytics_id"></a> [analytics\_id](#output\_analytics\_id) | n/a |

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
