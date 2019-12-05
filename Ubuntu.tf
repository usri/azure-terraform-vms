resource "azurerm_public_ip" "ubuntupublicip" {
  name                = "${var.suffix}Ubuntu${var.VMName}${var.publicIPName}"
  location            = azurerm_resource_group.genericRG.location
  resource_group_name = azurerm_resource_group.genericRG.name
  allocation_method   = var.publicIPAllocation

  tags = var.tags
}

resource "azurerm_network_interface" "ubuntuNI" {
  name                      = "${var.suffix}Ubuntu${var.VMName}${var.networkInterfaceName}"
  location                  = azurerm_resource_group.genericRG.location
  resource_group_name       = azurerm_resource_group.genericRG.name
  network_security_group_id = azurerm_network_security_group.genericNSG.id

  ip_configuration {
    name                          = "${var.suffix}Ubuntu${var.VMName}IPConf"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntupublicip.id
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "ubuntuVM" {
  name                  = "${var.suffix}Ubuntu${var.VMName}"
  location              = azurerm_resource_group.genericRG.location
  resource_group_name   = azurerm_resource_group.genericRG.name
  network_interface_ids = ["${azurerm_network_interface.ubuntuNI.id}"]
  vm_size               = var.vmSize


  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.suffix}Ubuntu${var.VMName}OSdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Ubuntu${var.VMName}"
    admin_username = "demouser"
    custom_data    = <<-EOF
    #!/bin/bash
    sudo apt-get -y update
    sudo apt-get -y install nginx
    sudo ufw allow 'Nginx HTTP'
    echo '<!doctype html><html><body><h1>Hello Ubuntu 2019 from Azure!</h1></body></html>' | sudo tee /var/www/html/index.nginx-debian.html > /dev/null
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
