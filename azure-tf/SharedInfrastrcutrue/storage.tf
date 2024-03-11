resource "azurerm_storage_account" "storage-account" {
  name                     = "stocktraderstorageacc"
  resource_group_name      = "rg-cjot-kcl-eastus-001"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage-container" {
  name                  = "stocktrader-storage-container"
  storage_account_name  = azurerm_storage_account.storage-account.name
  container_access_type = "private"
}