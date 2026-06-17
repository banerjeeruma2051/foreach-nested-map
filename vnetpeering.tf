resource "azurerm_virtual_network_peering" "vnet1" {
  depends_on = [azurerm_resource_group.rg, azurerm_virtual_network.vnet]

  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.rg[var.vnet["v1"].rg_key].name
  virtual_network_name      = azurerm_virtual_network.vnet["v1"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["v2"].id
}

resource "azurerm_virtual_network_peering" "vnet2" {
  depends_on = [azurerm_resource_group.rg, azurerm_virtual_network.vnet]

  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.rg[var.vnet["v2"].rg_key].name
  virtual_network_name      = azurerm_virtual_network.vnet["v2"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["v1"].id
}
