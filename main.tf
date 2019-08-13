terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = ">= 1.32.0"
  }
}

resource "azurerm_resource_group" "acr" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                     = format("%sregistry", lower(replace(var.name, "/[[:^alnum:]]/", "")))
  resource_group_name      = azurerm_resource_group.acr.name
  location                 = azurerm_resource_group.acr.location
  sku                      = var.sku
  admin_enabled            = false
  georeplication_locations = var.georeplication_locations

  tags = var.tags
}
