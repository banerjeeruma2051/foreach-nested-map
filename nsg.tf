




resource "azurerm_network_security_group" "example2" {
  for_each            = var.vnet
  depends_on          = [azurerm_resource_group.rg]
  name                = "nsg-${each.key}"
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name
}

resource "azurerm_network_security_rule" "allow_bastion_inbound" {
  for_each                    = var.vnet
  name                        = "AllowBastionInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "3389"]
  source_address_prefix       = "10.0.3.0/24" # AzureBastionSubnet range
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg[each.value.rg_key].name
  network_security_group_name = azurerm_network_security_group.example2[each.key].name
}

resource "azurerm_network_security_rule" "allow_vnet_inbound" {
  for_each                    = var.vnet
  name                        = "AllowVnetInbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.rg[each.value.rg_key].name
  network_security_group_name = azurerm_network_security_group.example2[each.key].name
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = {
    for k, v in var.subnet : k => v if k != "bastion_subnet"
  }
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.example2[each.value.vnet_key].id
}