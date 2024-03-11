

# Create a public IP address for NAT Gateway
resource "azurerm_public_ip" "nat_gateway_public_ip" {
  name                = "nat-gateway-ip"
  location            = var.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  zones                = ["1"]
}
resource "azurerm_public_ip" "nat_gateway_public_ip2" {
  name                = "nat-gateway-ip2"
  location            = var.azure_region
  allocation_method   = "Static"
  sku                 = "Standard"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  zones                = ["1"]
}
#Creating nat gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "nat-Gateway"
  location                = var.azure_region
  resource_group_name     = "rg-cjot-kcl-eastus-001"
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}
#Associating public ip, with nat gateway
resource "azurerm_nat_gateway_public_ip_association" "example" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_public_ip2.id
}
output "virtual-network" {
  value = azurerm_virtual_network.Vnet.id
}
#Creating Virtual network
resource "azurerm_virtual_network" "Vnet" {
  name                = "stocktrader-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.azure_region
  resource_group_name = "rg-cjot-kcl-eastus-001"
}

# Create a route table
resource "azurerm_route_table" "private_rt" {
  name                = "private-rt"
  location            = var.azure_region
  resource_group_name = "rg-cjot-kcl-eastus-001"
}


#Public subnets
resource "azurerm_subnet" "public1" {
  name                 = "PublicSubnet1"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.24.0/23"]
}
resource "azurerm_subnet" "public2" {
  name                 = "PublicSubnet2"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.26.0/23"]
}
resource "azurerm_subnet" "public3" {
  name                 = "PublicSubnet3"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.28.0/23"]
}

output "subnet_id_sub_priv1" {
  value = azurerm_subnet.private1.id
}
#Private Subnets
resource "azurerm_subnet" "private1" {
  name                 = "PrivateSubnet1"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.2.0/23"]
}
output "subnet_id_sub_priv2" {
  value = azurerm_subnet.private2.id
}
resource "azurerm_subnet" "private2" {
  name                 = "PrivateSubnet2"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.4.0/23"]
}
output "subnet_id_sub_priv3" {
  value = azurerm_subnet.private3.id
}
resource "azurerm_subnet" "private3" {
  name                 = "PrivateSubnet3"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.6.0/23"]
}
output "subnet_id_sub_priv4" {
  value = azurerm_subnet.private4.id
}
resource "azurerm_subnet" "private4" {
  name                 = "PrivateSubnet4"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.8.0/23"]
}
output "subnet_id_sub_priv5" {
  value = azurerm_subnet.private5.id
}
resource "azurerm_subnet" "private5" {
  name                 = "PrivateSubnet5"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.10.0/23"]
}
output "subnet_id_sub_priv6" {
  value = azurerm_subnet.private6.id
}
resource "azurerm_subnet" "private6" {
  name                 = "PrivateSubnet6"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.12.0/23"]
}
output "subnet_id_sub_priv7" {
  value = azurerm_subnet.private7.id
}
resource "azurerm_subnet" "private7" {
  name                 = "PrivateSubnet7"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.14.0/23"]
}
output "subnet_id_sub_priv8" {
  value = azurerm_subnet.private8.id
}
resource "azurerm_subnet" "private8" {
  name                 = "PrivateSubnet8"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.16.0/23"]
}
output "subnet_id_sub_priv9" {
  value = azurerm_subnet.private9.id
}
resource "azurerm_subnet" "private9" {
  name                 = "PrivateSubnet9"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.18.0/23"]
}
output "subnet_id_sub_priv10" {
  value = azurerm_subnet.private10.id
}
resource "azurerm_subnet" "private10" {
  name                 = "PrivateSubnet10"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.20.0/23"]
}
output "subnet_id_sub_priv11" {
  value = azurerm_subnet.private11.id
}
resource "azurerm_subnet" "private11" {
  name                 = "PrivateSubnet11"
  resource_group_name  = "rg-cjot-kcl-eastus-001"
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.22.0/23"]
}
#resource "azurerm_route" "private_route" {
 # count          = 11
  #route_table_id = azurerm_route_table.private_rt.id
  #name           = "default-route"
  #address_prefix = "0.0.0.0/0"
  #next_hop_type  = "VirtualAppliance"
  #next_hop_in_ip_address = azurerm_nat_gateway.nat_gateway.private_ip_address
#}


#Private route table association
resource "azurerm_subnet_route_table_association" "private_subnet_association1" {
  subnet_id           = azurerm_subnet.private1.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association2" {
  subnet_id           = azurerm_subnet.private2.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association3" {
  subnet_id           = azurerm_subnet.private3.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association4" {
  subnet_id           = azurerm_subnet.private4.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association5" {
  subnet_id           = azurerm_subnet.private5.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association6" {
  subnet_id           = azurerm_subnet.private6.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association7" {
  subnet_id           = azurerm_subnet.private7.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association8" {
  subnet_id           = azurerm_subnet.private8.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association9" {
  subnet_id           = azurerm_subnet.private9.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association10" {
  subnet_id           = azurerm_subnet.private10.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet_route_table_association" "private_subnet_association11" {
  subnet_id           = azurerm_subnet.private11.id
  route_table_id      = azurerm_route_table.private_rt.id
}
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = "rg-cjot-kcl-eastus-001"  
  virtual_network_name = azurerm_virtual_network.Vnet.name  
  address_prefixes     = ["10.0.0.0/27"]  
}
resource "azurerm_virtual_network_gateway" "internet_gateway" {
  name                = "internet-gateway"
  resource_group_name = "rg-cjot-kcl-eastus-001"
  location            = var.azure_region
  type                = "Vpn"
  sku                 = "VpnGw1AZ"  # Choose the appropriate SKU
  vpn_type            = "RouteBased"
  active_active       = false
  bgp_settings {
    asn = 65515
  }
  ip_configuration {
    name               = "config1"
    subnet_id          = azurerm_subnet.gateway_subnet.id 
    public_ip_address_id = azurerm_public_ip.nat_gateway_public_ip.id 
  }
  vpn_client_configuration {
    address_space = ["10.1.0.0/24"] 
  }
}