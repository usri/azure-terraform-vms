output "generic_RG" {
  value = "${azurerm_resource_group.genericRG.name}"
}

output "WindowsPublicIP" {
  value = "${azurerm_public_ip.winpublicip.ip_address}"
}

output "windowsPrivateIP" {
  value = "${azurerm_network_interface.winNI.private_ip_address}"
}

output "CentOSPublicIP" {
  value = "${azurerm_public_ip.centospublicip.ip_address}"
}

output "CentOSPrivateIP" {
  value = "${azurerm_network_interface.centosNI.private_ip_address}"
}

output "RedHatPublicIP" {
  value = "${azurerm_public_ip.redhatpublicip.ip_address}"
}

output "RedHatPrivateIP" {
  value = "${azurerm_network_interface.redhatNI.private_ip_address}"
}

output "UbuntuPublicIP" {
  value = "${azurerm_public_ip.ubuntupublicip.ip_address}"
}

output "UbuntuPrivateIP" {
  value = "${azurerm_network_interface.ubuntuNI.private_ip_address}"
}
