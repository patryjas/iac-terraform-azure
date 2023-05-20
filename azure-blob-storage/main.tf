resource "azurerm_resource_group" "patryjas" {
  name     = var.name_patryjas_resources
  location = var.location
}

resource "azurerm_storage_account" "patryjas" {
  name                     = var.name_storage_account
  resource_group_name      = azurerm_resource_group.patryjas.name
  location                 = azurerm_resource_group.patryjas.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "patryjas" {
  name                  = var.name_storage_container
  storage_account_name  = azurerm_storage_account.patryjas.name
  container_access_type = var.access_container_type
}

resource "azurerm_storage_blob" "patryjas" {
  name                   = var.name_storage_blob
  url                    = var.url_storage_blob
  storage_account_name   = azurerm_storage_account.patryjas.name
  storage_container_name = azurerm_storage_container.patryjas.name
  type                   = var.type_storage_blob
  source                 = var.source_storage_blob
}