output "rgName" {
  value       = azurerm_resource_group.mainRG.name
  description = "Main Resource Group."
  sensitive   = false
}

# VM Information
# CentOS
output "centOSPublicIP" {
  value       = azurerm_public_ip.centosPublicIP.ip_address
  description = "The public IP address of the CentOS server instance."
  sensitive   = false
}

output "centOSPrivateIP" {
  value       = azurerm_network_interface.centosNI.private_ip_address
  description = "The private IP address of the CentOS server instance."
  sensitive   = false
}

output "centosSSHAccess" {
  description = "Command to ssh into the VM."
  value       = <<SSHCONFIG
  ssh ${var.vmUserName}@${azurerm_public_ip.centosPublicIP.ip_address} -i ${trimsuffix(var.sshKeyPath, ".pub")}
  SSHCONFIG
  sensitive   = true
}

# Ubuntu
output "ubuntuPublicIP" {
  value       = azurerm_public_ip.ubuntuPublicIP.ip_address
  description = "The public IP address of the Ubuntu server instance."
  sensitive   = false
}

output "ubuntuPrivateIP" {
  value       = azurerm_network_interface.ubuntuNI.private_ip_address
  description = "The private IP address of the Ubuntu server instance."
  sensitive   = false
}

output "ubuntuSSHAccess" {
  description = "Command to ssh into the VM."
  value       = <<SSHCONFIG
  ssh ${var.vmUserName}@${azurerm_public_ip.ubuntuPublicIP.ip_address} -i ${trimsuffix(var.sshKeyPath, ".pub")}
  SSHCONFIG
  sensitive   = true
}

# Windows
output "windowsPublicIP" {
  value = azurerm_public_ip.winPublicIP.ip_address
}

output "windowsPrivateIP" {
  value = azurerm_network_interface.winNI.private_ip_address
}

# RedHat
output "redHatPublicIP" {
  value       = azurerm_public_ip.redhatPublicIP.ip_address
  description = "The public IP address of the RedHat server instance."
  sensitive   = false
}

output "redHatPrivateIP" {
  value       = azurerm_network_interface.redhatNI.private_ip_address
  description = "The private IP address of the RedHat server instance."
  sensitive   = false
}

output "redHatSSHAccess" {
  description = "Command to ssh into the VM."
  value       = <<SSHCONFIG
  ssh ${var.vmUserName}@${azurerm_public_ip.redhatPublicIP.ip_address} -i ${trimsuffix(var.sshKeyPath, ".pub")}
  SSHCONFIG
  sensitive   = true
}
