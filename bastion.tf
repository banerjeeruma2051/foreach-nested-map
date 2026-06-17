resource "azurerm_bastion_host" "bhost" {
  for_each            = var.bastion
  depends_on          = [azurerm_subnet.subnet, azurerm_public_ip.pip]
  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet[each.value.subnet_key].id
    public_ip_address_id = azurerm_public_ip.pip[each.value.public_ip_key].id
  }
}
