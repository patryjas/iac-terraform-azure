resource "azurerm_resource_group" "patryjas" {
  name     = var.name_resource_group
  location = var.location
}

resource "azurerm_storage_account" "patryjas" {
  name                     = var.name_storage_account
  resource_group_name      = azurerm_resource_group.patryjas.name
  location                 = azurerm_resource_group.patryjas.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_app_service_plan" "patryjas" {
  name                = var.name_app_service_plan
  location            = azurerm_resource_group.patryjas.location
  resource_group_name = azurerm_resource_group.patryjas.name

  sku {
    tier = var.tier_sku
    size = var.size_sku
  }
}

resource "azurerm_linux_function_app" "patryjas" {
  name                = var.name_linux_function_app
  resource_group_name = azurerm_resource_group.patryjas.name
  location            = azurerm_resource_group.patryjas.location

  storage_account_name = azurerm_storage_account.patryjas.name
  service_plan_id      = azurerm_service_plan.patryjas.id

  site_config {}
}

resource "azurerm_function_app_function" "patryjas" {
  name                       = var.name_test_azure_functions
  id                         = var.id_function_app_function
  location                   = azurerm_resource_group.patryjas.location
  resource_group_name        = azurerm_resource_group.patryjas.name
  app_service_plan_id        = azurerm_app_service_plan.patryjas.id
  storage_account_name       = azurerm_storage_account.patryjas.name
  storage_account_access_key = azurerm_storage_account.patryjas.primary_access_key
}