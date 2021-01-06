variable "redhatVMName" {
  type        = string
  default     = "RedHat"
  description = "Default RedHat VM server name."
}

variable "redhatsku" {
  type        = string
  default     = "77-gen2"
  description = "Default VM SKU to be used in the VM."
}
