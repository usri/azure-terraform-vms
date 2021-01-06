variable "location" {
  type        = string
  default     = "eastus2"
  description = "Location where the resoruces are going to be created."
}

variable "suffix" {
  default = "MZV"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Dev"
    "Project"     = "DevOps"
    "BillingCode" = "Internal"
  }
}

variable "rgName" {
  type        = string
  default     = "AllVMsDemoRG"
  description = "Resource Group Name."
}
