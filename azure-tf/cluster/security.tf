#Network security group
resource "azurerm_network_security_group" "eks_node_shared_nsg" {
  name                = "eks-node-shared-nsg"
  location            = var.azure_region
  resource_group_name = "rg-cjot-kcl-eastus-001"
}
#Allowing https
resource "azurerm_network_security_rule" "allow_https" {
  name                        = "allow-https"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-cjot-kcl-eastus-001"
  network_security_group_name = azurerm_network_security_group.eks_node_shared_nsg.name
}
#Allowing kubelet
resource "azurerm_network_security_rule" "allow_kubelet" {
  name                        = "allow-kubelet"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "10250"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-cjot-kcl-eastus-001"
  network_security_group_name = azurerm_network_security_group.eks_node_shared_nsg.name
}
#Allowing all
resource "azurerm_network_security_rule" "allow_all" {
  name                        = "allow-all"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = "rg-cjot-kcl-eastus-001"
  network_security_group_name = azurerm_network_security_group.eks_node_shared_nsg.name
}
#Allow all outbound
resource "azurerm_network_security_rule" "allow_all_outbound" {
  name                        = "allow-all-outbound"
  priority                    = 1001
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = "rg-cjot-kcl-eastus-001"
  network_security_group_name = azurerm_network_security_group.eks_node_shared_nsg.name
}
#Allow postgres
resource "azurerm_network_security_rule" "allow_postgresql" {
  name                        = "allow-postgresql"
  priority                    = 1002
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  resource_group_name         = "rg-cjot-kcl-eastus-001"
  source_address_prefix       = "VirtualNetwork" 
  destination_address_prefix  = "Internet"  
  network_security_group_name = azurerm_network_security_group.eks_node_shared_nsg.name
}