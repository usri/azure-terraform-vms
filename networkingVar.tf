## Networking variables
variable "vnetName" {
  type        = string
  default     = "Main"
  description = "VNet name."
}

locals {
  base_cidr_block = "10.2.0.0/20"
}

variable "subnetNames" {
  type        = list(string)
  default     = ["frontend", "middleware", "backend"]
  description = "Subnets to be created in the VNet with same size."
}

variable "subnetSize" {
  type        = number
  default     = 9
  description = "Subnet size within the virtual network, a.k.a. newbits."

}

variable "subnetDetails" {
  type = map(map(string))
  default = {
    main = {
      name  = "main2"
      value = "10.2.0.80/28"
    },
    dev = {
      name  = "dev2"
      value = "10.2.1.0/28"
    },
    databrickspublic = {
      name  = "dbpublic"
      value = "10.2.0.128/26"
    },
    databricksprivate = {
      name  = "dbprivate"
      value = "10.2.0.192/26"
    },
    netapp = {
      name  = "netapp"
      value = "10.2.0.96/27"
    },

  }
  description = "Multiple subnets with different sizes."
}
