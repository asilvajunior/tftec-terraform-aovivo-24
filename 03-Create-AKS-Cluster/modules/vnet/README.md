

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Espaço de endereço utilizado pela vnet | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Localidade do Azure Container Registry | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Nome do Resource Group | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Nome da vnet | `string` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Os servidores DNS a serem usados com a vnet. Omitir ou deixar este campo em branco fará com que o recurso use o DNS padrão do Azure | `list(string)` | `[]` | no |
| <a name="input_nat_gateway_ids"></a> [nat\_gateway\_ids](#input\_nat\_gateway\_ids) | Mapa de NAT Gateway ids. | `map(string)` | `{}` | no |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids) | Mapa de Network Security Group IDs. | `map(string)` | `{}` | no |
| <a name="input_route_tables_ids"></a> [route\_tables\_ids](#input\_route\_tables\_ids) | Mapa de Route table ids. | `map(string)` | `{}` | no |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | Nome de sub-rede para habilitar/desabilitar políticas de rede de endpoint de link privado na sub-rede. | `map(bool)` | `{}` | no |
| <a name="input_subnet_enforce_private_link_service_network_policies"></a> [subnet\_enforce\_private\_link\_service\_network\_policies](#input\_subnet\_enforce\_private\_link\_service\_network\_policies) | Nome da sub-rede para habilitar/desabilitar as políticas de rede do serviço de link privado na sub-rede. | `map(bool)` | `{}` | no |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints) | Nome de sub-rede para pontos de extremidade de serviço para adicionar à sub-rede. | `map(any)` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Todos os detalhes sobre a sub-rede que será criada. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Todos os detalhes sobre a sub-rede que será criada. Deve usar as seguintes entradas: <table><thead><tr><th>Nome</th><th>Tipo</th><th>Padrão</th><th>Descrição</th><th> Obrigatório</th></tr></thead><tbody><tr><td>nome</td><td>`string`</td><td>n/d</td><td> Este **deve ser usado como a chave do seu mapa**</td><td>yes</td></tr><tr><td>address\_prefix</td><td>`string`</td ><td>n/d</td><td>Endereço CIDR de sub-rede</td><td>sim</td></tr><tr><td>service\_endpoints</td><td>`list( string)`</td><td>`null`</td><td>Pontos de extremidade de serviço a serem usados ​​com esta sub-rede. Os valores aceitos são: `Microsoft.AzureActiveDirectory`, `Microsoft.CosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage `, `Microsoft.Web`</td><td>não</td></tr><tr><td>enforce\_private\_link\_endpoint\_network\_policies</td><td>`bool`</td><td>`null` </td><td>Ative ou desative as políticas de rede para o endpoint de link privado na sub-rede. Definir isso como `true` **Desativa** a política e definir isso como `false` **Ativar** a política. *Observação*: Conflitos com `enforce_private_link_service_network_policies`.</td><td>não</td></tr><tr><td>enforce\_private\_link\_service\_network\_policies</td><td>`bool`</td><td> `null`</td><td>Ative ou desative as políticas de rede para o serviço de link privado na sub-rede. Definir isso como `true` **Desativa** a política e definir isso como `false` **Ativar** a política. *Observação*: Conflitos com `enforce_private_link_endpoint_network_policies`.</td><td>sem</td></tr><tr><td>delegação</td><td>`map(any)`</td> <td>`null`</td><td>deve ter os seguintes detalhes: <table><thead><tr><th>Nome</th><th>Tipo</th><th>Padrão</th> th><th>Descrição</th><th>Obrigatório</th></tr></thead><tbody><tr><td>nome</td><td>`string`</td> <td>n/d</td><td>Nome de sua delegação de sub-rede</td><td>sim</td></tr><tr><td>service\_actions</td><td>`map (qualquer)`</td><td>n/a</td><td>Deve seguir a mesma estrutura que a [documentação oficial](https://registry.terraform.io/providers/hashicorp/azurerm/latest /docs/resources/subnet#service\_delegation) para este atributo de bloco</td><td>sim</td></tr></tbody></table></td><td>não</td>< /tr></tbody></table> | `map(any)` | `{}` | no |
| <a name="input_vnet_peering_settings"></a> [vnet\_peering\_settings](#input\_vnet\_peering\_settings) | Mapa que descreve todas as configurações de emparelhamento de vnet. Aceita os seguintes valores: <table><thead><tr><th>Nome</th><th>Tipo</th><th>Padrão</th><th>Descrição</th><th>Obrigatório </th></tr></thead><tbody><tr><td>nome</td><td>`string`</td><td>n/d</td><td>Este é a chave para a variável map. Você deve digitar um nome para o emparelhamento de vnet</td><td>yes</td></tr><tr><td>remote\_vnet\_id</td><td>`string`</td><td>n /a</td><td>ID de recurso de rede virtual remota</td><td>sim</td></tr><tr><td>allow\_forwarded\_traffic</td><td>`bool`</td ><td>`true`</td><td>Isso especifica se esta vnet deve aceitar tráfego encaminhado</td><td>não</td></tr><tr><td>allow\_gateway\_transit</td> <td>`bool`</td><td>`false`</td><td>Se você tiver um Gateway VPN ou Circuito ExpressRoute, você pode habilitar esta opção. Caso contrário, deixe como está.</td><td>não</td></tr><tr><td>use\_remote\_gateways</td><td>`bool`</td><td>`false `</td><td>Se sua rede virtual peer tiver um VPN Gateway ou Circuito ExpressRoute, você pode habilitar esta opção. Caso contrário, deixe como está.</td><td>não</td></tr></tbody></table> | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | n/a |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | n/a |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
| <a name="output_vnet_subnet_ids"></a> [vnet\_subnet\_ids](#output\_vnet\_subnet\_ids) | n/a |
| <a name="output_vnet_subnet_names"></a> [vnet\_subnet\_names](#output\_vnet\_subnet\_names) | n/a |

## Examples
### Basic Virtual Network Example

``` hcl
resource "random_pet" "pet" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "rg" {
  name     = join("-", ["rg", random_pet.pet.id])
  location = var.location
  tags     = var.tags
  depends_on = [
    random_pet.pet
  ]
}

module "vnet-east" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = join("-", ["vnet", random_pet.pet.id])
  address_space       = ["10.1.0.0/16", "192.169.0.0/24"]
  subnets = {
    subnet1 = {
      address_prefix = "10.1.0.0/24"
    }
    subnet2 = {
      address_prefix = "10.1.1.0/24"
    }
    subnet3 = {
      address_prefix = "192.169.0.0/27"
    }
  }

  tags = var.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}
```

### Two Virtual Networks + VNet Peering Example
``` hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet-west" {
  source              = "../"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westus2"
  vnet_name           = "vnet-westus2"
  address_space       = ["10.0.0.0/16", "192.168.0.0/24"]
  subnets = {
    subnet1 = {
      address_prefix = "10.0.0.0/24"
    }
    subnet2 = {
      address_prefix = "10.0.1.0/24"
    }
    subnet3 = {
      address_prefix = "192.168.0.0/27"
    }
  }

  vnet_peering_settings = {
    vnet1-to-vnet2 = {
      remote_vnet_id = module.vnet-east.vnet_id
    }
    vnet2 = {
      remote_vnet_id = "/subscriptions/ff14dd7f-37f0-4ef30-b9d3-80ed9003cce5/resourceGroups/rg-minecraft/providers/Microsoft.Network/virtualNetworks/minecraft-vnet"
    }
  }

  tags = var.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "vnet-east" {
  source              = "../"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "vnet-eastus2"
  address_space       = ["10.1.0.0/16", "192.169.0.0/24"]
  subnets = {
    subnet1 = {
      address_prefix = "10.1.0.0/24"
    }
    subnet2 = {
      address_prefix = "10.1.1.0/24"
    }
    subnet3 = {
      address_prefix = "192.169.0.0/27"
    }
  }

  vnet_peering_settings = {
    "vnet2-to-vnet1" = {
      remote_vnet_id = module.vnet-west.vnet_id
    }
  }

  tags = var.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}
```

### Virtual Network with Service endpoints Example
``` hcl
resource "random_pet" "pet" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "rg" {
  name     = join("-", ["rg", random_pet.pet.id])
  location = var.location
  tags     = var.tags
  depends_on = [
    random_pet.pet
  ]
}

module "vnet-east" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
  vnet_name           = join("-", ["vnet", random_pet.pet.id])
  address_space       = ["10.1.0.0/16", "192.169.0.0/24"]

  subnets = {
    subnet1 = {
      address_prefix    = "10.1.0.0/24"
      service_endpoints = ["Microsoft.KeyVault", "Microsoft.Web"]
    }
    subnet2 = {
      address_prefix    = "10.1.1.0/24"
      service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    }
    subnet3 = {
      address_prefix = "192.169.0.0/27"
    }
  }

  depends_on = [
    azurerm_resource_group.rg
  ]
}
```

### Virtual Network with Subnet Delegation Example
``` hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "vnet-west" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westus2"
  vnet_name           = "vnet-westus2"
  address_space       = ["10.0.0.0/16", "192.168.0.0/24"]
  subnets = {
    subnet1 = {
      address_prefix = "10.0.0.0/24"
      delegation = {
        name = "delegation1"
        service_delegation = {
          name = "Microsoft.ApiManagement/service"
          actions = [
            "Microsoft.Network/networkinterfaces/*",
            "Microsoft.Network/virtualNetworks/subnets/action",
            "Microsoft.Network/virtualNetworks/subnets/join/action"
          ]
        }
      }
    }
    subnet2 = {
      address_prefix = "10.0.1.0/24"
    }
    subnet3 = {
      address_prefix = "192.168.0.0/27"
    }
  }

  tags = var.tags
  depends_on = [
    azurerm_resource_group.rg
  ]
}
```

## Deseja contribuir?

Para contruibuir com este repositório você deve instalar o [**Terraform-docs**](https://terraform-docs.io/user-guide/installation/).
Etapas:
* Clone este repositório;
* Crie uma branch;
* Realize todas as modificações que deseja;
* Faça o commit e crie uma tag (v1.1.0, v1.2.3, etc);
* Documente o código usando `make all`;
* Faça o push da sua branch seguido de um Pull Request.

<sub>Para dúvidas mande um contato: [antonio.junior@solonetwork.com.br](mailto:antonio.junior@solonetwork.com.br)</sub>

