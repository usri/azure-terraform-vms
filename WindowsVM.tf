resource "azurerm_public_ip" "winpublicip" {
  name                = "${var.suffix}Windows${var.VMName}${var.publicIPName}"
  location            = azurerm_resource_group.genericRG.location
  resource_group_name = azurerm_resource_group.genericRG.name
  allocation_method   = var.publicIPAllocation

  tags = var.tags
}

resource "azurerm_network_interface" "winNI" {
  name                      = "${var.suffix}Windows${var.VMName}${var.networkInterfaceName}"
  location                  = azurerm_resource_group.genericRG.location
  resource_group_name       = azurerm_resource_group.genericRG.name
  network_security_group_id = azurerm_network_security_group.genericNSG.id

  ip_configuration {
    name                          = "${var.suffix}Windows${var.VMName}IPConf"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.winpublicip.id
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "winVM" {
  name                  = "${var.suffix}Windows${var.VMName}"
  location              = azurerm_resource_group.genericRG.location
  resource_group_name   = azurerm_resource_group.genericRG.name
  network_interface_ids = ["${azurerm_network_interface.winNI.id}"]
  vm_size               = var.vmSize

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2012-R2-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.suffix}Windows${var.VMName}OSdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Windows${var.VMName}"
    admin_username = "demouser"
    admin_password = var.windowsPassword
  }
  os_profile_windows_config {

  }

  tags = var.tags
}
