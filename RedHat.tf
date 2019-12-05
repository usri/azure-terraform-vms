resource "azurerm_public_ip" "redhatpublicip" {
  name                = "${var.suffix}RedHat${var.VMName}${var.publicIPName}"
  location            = azurerm_resource_group.genericRG.location
  resource_group_name = azurerm_resource_group.genericRG.name
  allocation_method   = var.publicIPAllocation

  tags = var.tags
}

resource "azurerm_network_interface" "redhatNI" {
  name                      = "${var.suffix}RedHat${var.VMName}${var.networkInterfaceName}"
  location                  = azurerm_resource_group.genericRG.location
  resource_group_name       = azurerm_resource_group.genericRG.name
  network_security_group_id = azurerm_network_security_group.genericNSG.id

  ip_configuration {
    name                          = "${var.suffix}RedHat${var.VMName}IPConf"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.redhatpublicip.id
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "redhatVM" {
  name                  = "${var.suffix}RedHat${var.VMName}"
  location              = azurerm_resource_group.genericRG.location
  resource_group_name   = azurerm_resource_group.genericRG.name
  network_interface_ids = ["${azurerm_network_interface.redhatNI.id}"]
  vm_size               = var.vmSize

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7-RAW-CI"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.suffix}RedHat${var.VMName}OSdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "RedHat${var.VMName}"
    admin_username = "demouser"
    custom_data    = <<-EOF
    #cloud-config
    package_upgrade: true
    packages:
      - httpd
      - java-1.8.0-openjdk-devel
      - tmux
      - git
    write_files:
      - content: <!doctype html><html><body><h1>Hello RedHat 2019 from Azure!</h1></body></html>
        path: /var/www/html/index.html
    runcmd:
      - [ systemctl, enable, httpd.service ]
      - [ systemctl, start, httpd.service ]
      - [ firewall-cmd, --add-service, http ]
    EOF

  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/demouser/.ssh/authorized_keys"
      key_data = file(var.sshKeyPath)
    }
  }
  tags = var.tags
}
