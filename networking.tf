resource "azurerm_virtual_network" "mainVNet" {
  name                = "${var.suffix}${var.vnetName}"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name
  address_space       = [local.base_cidr_block]

  tags = var.tags
}

# Multiple subnets with same size
resource "azurerm_subnet" "subnets" {
  count = length(var.subnetNames)

  name                 = var.subnetNames[count.index]
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [cidrsubnet(local.base_cidr_block, var.subnetSize, count.index)]
}

# Static subnets multiple sizes
resource "azurerm_subnet" "frontend2" {
  #name                 = var.subnetNames[0]
  name                 = "frontend2"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [cidrsubnet(local.base_cidr_block, 9, 3)]
}

resource "azurerm_subnet" "middleware2" {
  # name                 = var.subnetNames[1]
  name                 = "middleware2"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [cidrsubnet(local.base_cidr_block, 9, 6)]
}

resource "azurerm_subnet" "backend2" {
  # name                 = var.subnetNames[2]
  name                 = "backend2"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [cidrsubnet(local.base_cidr_block, 9, 7)]
}

resource "azurerm_subnet" "main" {
  name                 = "main"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [cidrsubnet(local.base_cidr_block, 8, 2)]
}
resource "azurerm_subnet" "dev" {
  name                 = "dev"
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [cidrsubnet(local.base_cidr_block, 8, 4)]
}

# Multiple subnets with multiple sizes
resource "azurerm_subnet" "dynamicSubnets" {
  for_each = var.subnetDetails

  name                 = each.value["name"]
  resource_group_name  = azurerm_resource_group.mainRG.name
  virtual_network_name = azurerm_virtual_network.mainVNet.name
  address_prefixes     = [each.value["value"]]
}
