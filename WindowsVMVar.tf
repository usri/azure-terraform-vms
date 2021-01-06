variable "winVMName" {
  type        = string
  default     = "Windows"
  description = "Default Windows VM server name."
}

variable "windowsSKU" {
  type        = string
  default     = "2019-Datacenter"
  description = "Default VM SKU to be used in the VM."
}
