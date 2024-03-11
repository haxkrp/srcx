resource "azurerm_redis_cache" "redis_cache" {
  name                      = "stocktrader-redis-cache"
  location                  = "East US" 
  resource_group_name       = "rg-cjot-kcl-eastus-001"
  capacity                  = 0  
  family                    = "C"  
  enable_non_ssl_port       = false
  minimum_tls_version       = "1.2"
  sku_name                  = "Standard"  
}

resource "azurerm_servicebus_namespace" "servicebus" {
    name                = "stocktrader-servicebus"
    location            = "East US"
    resource_group_name = "rg-cjot-kcl-eastus-001"
    sku                 = "Standard"
}
#resource "azurerm_servicebus_queue" "queue" {
 # name         = "stocktrader-servicebus-queue"
  #namespace_id = azurerm_servicebus_namespace.servicebus.id

#  enable_partitioning = true
#}
#resource "azurerm_servicebus_namespace_network_rule_set" "servicebus-network-rule" {
 # resource_group_name = "rg-cjot-kcl-eastus-001"
  #namespace_name      = azurerm_servicebus_namespace.servicebus.name

  #default_action = "Deny"

  #ip_rule {
   # ip_mask = "192.168.1.0/24"
  #}

  #virtual_network_rule {
   # subnet_id = [
    #  data.terraform_remote_state.cluster.outputs.subnet_id_sub_priv3,
     # data.terraform_remote_state.cluster.outputs.subnet_id_sub_priv4
    #]
  #}
#}

resource "azurerm_eventhub_namespace" "stocktrader-eventhub-ns" {
  name                = "eventhub-namespace"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  location            = "East US"
  sku                 = "Standard"
}
resource "azurerm_eventhub" "stocktrader-eventhub" {
  name                = "stocktrader-eventhub"
  namespace_name      = azurerm_eventhub_namespace.stocktrader-event-ns.name
  resource_group_name = "rg-cjot-kcl-eastus-001"
  partition_count     = 2
  message_retention   = 1
}
resource "azurerm_eventhub_consumer_group" "stocktrader-consumergroup" {
  name                = "stocktrader-consumergroup"
  namespace_name      = azurerm_eventhub_namespace.stocktrader-event-ns.name
  eventhub_name       = azurerm_eventhub.stocktrader-eventhub.name
  resource_group_name = "rg-cjot-kcl-eastus-001"
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "stocktrader-cosmosdb"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  location            = "East US"
  offer_type          = "Standard"
  kind                = "MongoDB"
  enable_multiple_write_locations = false

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = "East US"
    failover_priority = 0
  }

  enable_analytics = true
  enable_automatic_failover = false

  virtual_network_rule {
  id     = "/subscriptions/19a7ed62-f51f-4e53-b3ea-6ba9a63f17fe/resourceGroups/rg-cjot-kcl-eastus-001/providers/Microsoft.Network/virtualNetworks/stocktrader-vnet"
  ignore_missing_vnet_service_endpoint = false
}


  network_acl_bypass = "AzureServices"
  is_virtual_network_filter_enabled = true
}

resource "azurerm_postgresql_server" "stocktrader-sql-server" {
  name                = "stocktrader-sql-server"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  location            = "East US"
  sku_name            = "B_Gen5_1"
  storage_mb          = 51200
  version             = "11"
  administrator_login          = "stocktraderUser"
  administrator_login_password = "stocktraderPass123"
  auto_grow_enabled           = true
  ssl_enforcement_enabled     = true

  backup_retention_days = 7

  tags = {
    environment = "production"
  }
}

resource "azurerm_postgresql_database" "example" {
  name                = "your-postgres-database"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  server_name         = azurerm_postgresql_server.stocktrader-sql-server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "allow-subnet-1" {
  name                = "allow-subnet-1"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  server_name         = azurerm_postgresql_server.stocktrader-sql-server.name
  start_ip_address    = "10.0.24.0"
  end_ip_address      = "10.0.25.255"
}

resource "azurerm_postgresql_firewall_rule" "allow-subnet-2" {
  name                = "allow-subnet-2"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  server_name         = azurerm_postgresql_server.stocktrader-sql-server.name
  start_ip_address    = "10.0.26.0"
  end_ip_address      = "10.0.27.255"
}

resource "azurerm_postgresql_firewall_rule" "allow-subnet-3" {
  name                = "allow-subnet-3"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  server_name         = azurerm_postgresql_server.stocktrader-sql-server.name
  start_ip_address    = "10.0.28.0"
  end_ip_address      = "10.0.29.255"
}
