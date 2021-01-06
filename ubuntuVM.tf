resource "azurerm_public_ip" "ubuntuPublicIP" {
  name                = "${var.suffix}${var.ubuntuVMName}"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name
  allocation_method   = var.publicIPAllocation

  tags = var.tags
}

resource "azurerm_network_interface" "ubuntuNI" {
  name                = "${var.suffix}${var.ubuntuVMName}"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  ip_configuration {
    name                          = "ubuntuconfiguration"
    subnet_id                     = azurerm_subnet.subnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntuPublicIP.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "ubuntuSG" {
  network_interface_id      = azurerm_network_interface.ubuntuNI.id
  network_security_group_id = azurerm_network_security_group.sshNSG.id
}

resource "azurerm_linux_virtual_machine" "ubuntuVM" {
  name                  = "${var.suffix}${var.ubuntuVMName}"
  resource_group_name   = azurerm_resource_group.mainRG.name
  location              = azurerm_resource_group.mainRG.location
  size                  = var.vmDetails["ubuntu"].size
  admin_username        = var.vmUserName
  network_interface_ids = [azurerm_network_interface.ubuntuNI.id, ]

  admin_ssh_key {
    username   = var.vmUserName
    public_key = file(var.sshKeyPath)
  }

  os_disk {
    name                 = "${var.suffix}${var.ubuntuVMName}OSDisk"
    caching              = "ReadWrite"
    storage_account_type = var.osDisk
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.vmDetails["ubuntu"].sku
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mainSA.primary_blob_endpoint
  }

  # from file
  custom_data = filebase64("cloud-init-jenkins.yaml")

  tags = var.tags
}
