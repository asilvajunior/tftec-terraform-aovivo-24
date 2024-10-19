terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.5.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.33.0"
    }
  }
}