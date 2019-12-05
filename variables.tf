variable "location" {
  type        = string
  default     = "eastus2"
  description = "Location where the resoruces are going to be created."
}

variable "suffix" {
  type        = string
  default     = "usri"
  description = "To be added at the beginning of each resource."
}

variable "rgName" {
  type        = string
  default     = "VMsRG"
  description = "Resource Group Name."
}

variable "tags" {
  type = map
  default = {
    "Environment" = "Dev"
    "Project"     = "Demo"
    "BillingCode" = "Internal"
    "Customer"    = "USRI"
  }
}

## Networking variables
variable "vnetName" {
  type        = string
  default     = "Main"
  description = "VNet name."
}

## Security variables
variable "sgName" {
  type        = string
  default     = "defaultSG"
  description = "Default Security Group Name to be applied by default to VMs and subnets."
}

variable "sourceIPs" {
  type        = list
  default     = ["173.66.39.236"]
  description = "Public IPs to allow inboud communications."
}

## compute variables
variable "VMName" {
  type        = string
  default     = "Server"
  description = "Default Windows VM server name."
}

variable "vmSize" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "Default VM size."
}

variable "publicIPName" {
  type        = string
  default     = "PublicIP"
  description = "Default Public IP name."
}

variable "publicIPAllocation" {
  type        = string
  default     = "Static"
  description = "Default Public IP allocation. Could be Static or Dynamic."
}

variable "networkInterfaceName" {
  type        = string
  default     = "NIC"
  description = "Default Windows Network Interface Name."
}

variable "sshKeyPath" {
  type        = string
  default     = "~/.ssh/vm_ssh.pub"
  description = "SSH Key to use when creating the VM."
}

variable "windowsPassword" {
  type        = string
  default     = "DoNotStorePasswordsHere!!"
  description = "Windows password to use when creating the VM. It is not recommend to store these values here."
}


