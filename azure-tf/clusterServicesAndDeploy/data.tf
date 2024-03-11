data "terraform_remote_state" "cluster" {
  backend = "azurerm"
  config = {
    resource_group_name   = "rg-cjot-kcl-eastus-001"
    storage_account_name  = "stocktraderstorageacc"  
    container_name        = "stocktrader-storage-container" 
    key                   = "cluster.tfstate"
  }
}
