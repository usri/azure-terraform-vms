resource "azurerm_public_ip" "redhatPublicIP" {
  name                = "${var.suffix}${var.redhatVMName}"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name
  allocation_method   = var.publicIPAllocation

  tags = var.tags
}

resource "azurerm_network_interface" "redhatNI" {
  name                = "${var.suffix}${var.redhatVMName}"
  location            = azurerm_resource_group.mainRG.location
  resource_group_name = azurerm_resource_group.mainRG.name

  ip_configuration {
    name                          = "redhatconfiguration"
    subnet_id                     = azurerm_subnet.subnets[2].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.redhatPublicIP.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "redhatSG" {
  network_interface_id      = azurerm_network_interface.redhatNI.id
  network_security_group_id = azurerm_network_security_group.sshNSG.id
}

resource "azurerm_linux_virtual_machine" "redhatVM" {
  name                = "${var.suffix}${var.redhatVMName}"
  resource_group_name = azurerm_resource_group.mainRG.name
  location            = azurerm_resource_group.mainRG.location
  size                = var.vmSize
  admin_username      = var.vmUserName
  #  encryption_at_host_enabled = true
  network_interface_ids = [azurerm_network_interface.redhatNI.id, ]

  admin_ssh_key {
    username   = var.vmUserName
    public_key = file(var.sshKeyPath)
  }

  os_disk {
    name                 = "${var.suffix}${var.redhatVMName}OSDisk"
    caching              = "ReadWrite"
    storage_account_type = var.osDisk
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = var.redhatsku
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.mainSA.primary_blob_endpoint
  }

  # from file
  custom_data = filebase64("cloud-init.yaml")

  # from variable
  #custom_data = base64encode(local.custom_data)

  # in-line
  /* custom_data = base64encode(<<CUSTOM_DATA
  #cloud-config
  package_upgrade: true
  packages:
    - httpd
    - java-1.8.0-openjdk-devel
    - git 
  write_files:
    - content: <!doctype html><html><body><h1>Hello RedHat 2019 from Azure!</h1></body></html>
      path: /var/www/html/index.html
  runcmd:
    - [ systemctl, enable, httpd.service ]
    - [ systemctl, start, httpd.service ]

  CUSTOM_DATA
  )
*/
  tags = var.tags
}
