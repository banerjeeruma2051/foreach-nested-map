x = {
  x1 = {
    name     = "a1"
    location = "centralindia"
  }
}

vnet = {
  v1 = {
    name   = "vnet1"
    rg_key = "x1"
    address_space = ["10.0.0.0/16"]
  }
  v2 = {
    name   = "vnet2"
    rg_key = "x1"
    address_space = ["10.1.0.0/16"]
  }
}
subnet = {
  s1 = {
    name   = "subnet1"
    rg_key = "x1"
    vnet_key = "v1"
    address_prefixes = ["10.0.1.0/24"]
  }
  s2 = {
    name   = "subnet2"
    rg_key = "x1"
    vnet_key = "v2"
    address_prefixes = ["10.1.1.0/24"]
  }

  bastion_subnet = {
    name   = "AzureBastionSubnet"
    rg_key = "x1"
    vnet_key = "v1"
    address_prefixes = ["10.0.3.0/24"]
  }
}

bastion = {
  b1 = {
    name   = "bastion1"
    rg_key = "x1"
    subnet_key = "bastion_subnet"
    public_ip_key = "p1"
  }
}

linux-machine = {
  m1 = {
    name   = "vm1"
    rg_key = "x1"
    subnet_key = "s1"
  }
}

windows-vm = {
  w1 = {
    name   = "winvm1"
    rg_key = "x1"
    subnet_key = "s2"
  }
}

public_ips = {
  p1 = {
    name   = "pip1"
    rg_key = "x1"
  }
} 

win_admin_password = "Rdarh@764530"