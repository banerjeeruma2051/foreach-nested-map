



resource "azurerm_resource_group" "rg" {
  for_each = var.x

  name     = each.value.name
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  depends_on          = [azurerm_resource_group.rg]
  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name
  address_space       = each.value.address_space
}



