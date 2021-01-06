## Security variables
variable "sgName" {
  type        = string
  default     = "default_RDPSSH_SG"
  description = "Default Security Group Name to be applied by default to VMs and subnets."
}

variable "sourceIPs" {
  type        = list(string)
  default     = ["173.66.39.236"]
  description = "Public IPs to allow inboud communications."
}

# Using Lists
variable "nsgDetailsList" {
  type = list(map(string))
  default = [
    {
      "name"  = "SSH"
      "value" = "22"
    },
    {
      "name"  = "RDP"
      "value" = "3389"
    },
    {
      "name"  = "HTTP"
      "value" = "80"
    },
    {
      "name"  = "HTTPS"
      "value" = "443"
    }
    ,
    {
      "name"  = "FileShare"
      "value" = "445"
    }
  ]
  description = "List of rules to be created."
}

# Using Maps
variable "nsgDetails" {
  type = map(map(string))
  default = {
    ssh = {
      name = "SSH"
      port = "22"
    }
    rdp = {
      name = "RDP"
      port = "3389"
    }
    http = {
      name = "HTTP"
      port = "8080"
    }
    https = {
      name = "HTTPS"
      port = "443"
    }
    fileshare = {
      name = "FileShare"
      port = "445"
    }
    vault = {
      name = "Vault"
      port = "8200"
    }
  }
  description = "Map of rules to be created."
}
