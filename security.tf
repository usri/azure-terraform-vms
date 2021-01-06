resource "azurerm_network_security_group" "sshNSG" {
  name                = "${var.suffix}sshNSG"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  # Using Lists
  /*security_rule {
    name                    = var.nsgDetailsList[0].name
    priority                = 100
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "TCP"
    source_port_range       = "*"
    destination_port_range  = var.nsgDetailsList[0].value
    source_address_prefixes = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }
  */

  # Using Maps
  security_rule {
    name                       = var.nsgDetails["ssh"].name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["ssh"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = var.nsgDetails["http"].name
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["http"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = var.nsgDetails["vault"].name
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["vault"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "rdpNSG" {
  name                = "${var.suffix}rdpNSG"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  security_rule {
    name                       = var.nsgDetails["rdp"].name
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["rdp"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "httpNSG" {
  name                = "${var.suffix}httpNSG"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  security_rule {
    name                       = var.nsgDetails["http"].name
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["http"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

# All in one
/*resource "azurerm_network_security_group" "allNSG" {
  name                = "${var.suffix}All"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  security_rule {
    name                       = var.nsgDetails["ssh"].name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["ssh"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = var.nsgDetails["rdp"].name
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["rdp"].port
    source_address_prefixes    = var.sourceIPs
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = var.nsgDetails["http"].name
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["http"].port
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = var.nsgDetails["https"].name
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["https"].port
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = var.nsgDetails["fileshare"].name
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.nsgDetails["fileshare"].port
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}
*/
