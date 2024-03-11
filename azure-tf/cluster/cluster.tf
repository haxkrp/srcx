#Creating AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = "stocktrader-aks"
  location                = var.azure_region
  resource_group_name     = "rg-cjot-kcl-eastus-001"
  dns_prefix              = "myaksdns"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    node_count = 1 
    vm_size    = "Standard_DS2_v2"
  }

  network_profile {
    network_plugin = "kubenet"  # Change this to "azure" if we decide to use Azure CNI

    service_cidr     = "10.0.0.0/16"
    dns_service_ip   = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }
}

#Creating AKS Node groups
resource "azurerm_kubernetes_cluster_node_pool" "stocktrader-node-pool-public1" {
  name                = "nodepub1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size             = "Standard_DS2_v2"
  node_count          = 1
  orchestrator_version = "1.26.6"
  pod_subnet_id           = azurerm_subnet.public1.id
}

resource "azurerm_kubernetes_cluster_node_pool" "stocktrader-node-pool-public2" {
  name                = "nodepub2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size             = "Standard_DS2_v2"
  node_count          = 1
  orchestrator_version = "1.26.6"
  pod_subnet_id           = azurerm_subnet.public2.id
}

resource "azurerm_kubernetes_cluster_node_pool" "stocktrader-node-pool-public3" {
  name                = "nodepub3"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size             = "Standard_DS2_v2"
  node_count          = 1
  orchestrator_version = "1.26.6"
  pod_subnet_id           = azurerm_subnet.public3.id
}