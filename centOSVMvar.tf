variable "centosVMName" {
  type        = string
  default     = "CentOS"
  description = "Default CentOS VM server name."
}

variable "centossku" {
  type        = string
  default     = "7_7-gen2"
  description = "Default VM SKU to be used in the VM."
}
