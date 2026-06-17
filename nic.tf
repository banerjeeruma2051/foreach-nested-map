resource "azurerm_network_interface" "linux_nic" {
  for_each = var.linux-machine
  depends_on          = [azurerm_subnet.subnet]

  name                = "${each.value.name}-nic"
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "win_nic" {
  for_each = var.windows-vm
  depends_on          = [azurerm_subnet.subnet]

  name                = "${each.value.name}-nic"
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}
