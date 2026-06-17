resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  depends_on           = [azurerm_virtual_network.vnet]
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg[each.value.rg_key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes
}