variable "ubuntuVMName" {
  type        = string
  default     = "Ubuntu"
  description = "Default Ubuntu VM server name."
}

variable "ubuntusku" {
  type        = string
  default     = "18.04-LTS"
  description = "Default VM SKU to be used in the VM."
}
