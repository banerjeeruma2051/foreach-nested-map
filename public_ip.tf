resource "azurerm_public_ip" "pip" {
  for_each            = var.public_ips
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  allocation_method   = "Static"
  sku                 = "Standard"
}
