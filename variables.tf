variable "x" {
  type = map(any)
}

variable "vnet" {
  type = map(any)
}

variable "subnet" {
  type = map(any)
}

variable "bastion" {
  type = map(any)
}

variable "linux-machine" {
  type = map(any)
}

variable "windows-vm" {
  type = map(any)
}

variable "public_ips" {
  type = map(any)
}

variable "win_admin_password" {
  type      = string
  sensitive = true
}
