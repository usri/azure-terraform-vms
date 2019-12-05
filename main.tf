terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "usri-AllVMs"
    }
  }
  required_version = ">= 0.12.12"
}

provider "azurerm" {
  version = "=1.37.0"
}
resource "azurerm_resource_group" "genericRG" {
  name     = "${var.suffix}${var.rgName}"
  location = var.location
  tags     = var.tags
}
