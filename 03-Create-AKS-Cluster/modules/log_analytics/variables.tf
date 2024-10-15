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

variable "log_analytics_workspace_location" {
  default     = "eastus2"
  description = "A região do datacenter onde seu workspace será criado."
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Nome do workspace do Log Analytics. É obrigatório caso `enable_log_analytics_workspace` for marcado como `true`"
}

variable "log_analytics_workspace_sku" {
  type        = string
  default     = "PerGB2018"
  description = "Define a SKU utilizada pelo Log Analytics Workspace."
}

variable "log_retention_in_days" {
  type        = number
  default     = 30
  description = "Define o número de dias em que os logs serão armazenados no Workspace."
}
