## compute variables
variable "publicIPAllocation" {
  type        = string
  default     = "Static"
  description = "Default Public IP allocation. Could be Static or Dynamic."
}

variable "vmSize" {
  type        = string
  default     = "Standard_E2s_v3"
  description = "VM size."
}

variable "osDisk" {
  type        = string
  default     = "StandardSSD_LRS"
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS"
}

variable "vmUserName" {
  type        = string
  default     = "marcelo"
  description = "Username to be added to the VM."
  sensitive   = true
}

variable "sshKeyPath" {
  type        = string
  default     = "~/.ssh/vm_ssh.pub"
  description = "SSH Key to use when creating the VM."
  sensitive   = true
}

variable "password" {
  type        = string
  default     = "DoNotStorePasswordsHere!!"
  description = "Windows password to use when creating the VM. It is not recommend to store these values here."
  sensitive   = true
}

locals {
  custom_data = <<CUSTOM_DATA
  #cloud-config
  package_upgrade: true
  packages:
    - httpd
    - java-1.8.0-openjdk-devel
    - git 
  write_files:
    - content: <!doctype html><html><body><h1>Hello CentOS 2019 from Azure!</h1></body></html>
      path: /var/www/html/index.html
  runcmd:
    - [ systemctl, enable, httpd.service ]
    - [ systemctl, start, httpd.service ]
CUSTOM_DATA
}

variable "vmDetails" {
  type = map(map(string))
  default = {
    windows = {
      name = "Windows"
      sku  = "2019-Datacenter"
      size = "Standard_E2s_v3"
    }
    centos = {
      name = "CentOS"
      sku  = "7_7-gen2"
      size = "Standard_E2s_v3"
    }
    redhat = {
      name = "RedHat"
      sku  = "77-gen2"
      size = "Standard_E2s_v3"
    }
    ubuntu = {
      name = "Ubuntu"
      sku  = "18.04-LTS"
      size = "Standard_E2s_v3"
    }
  }
  description = "VM details. You can add more items to the map in order to customize anything related to the VM."
}
