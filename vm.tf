resource "azurerm_linux_virtual_machine" "lin-vm" {
  for_each                        = var.linux-machine
  depends_on                      = [azurerm_network_interface.linux_nic]
  name                            = each.value.name
  resource_group_name             = azurerm_resource_group.rg[each.value.rg_key].name
  location                        = azurerm_resource_group.rg[each.value.rg_key].location
  size                            = "Standard_D2s_v3"
  admin_username                  = "adminuser"
  admin_password                  = azurerm_key_vault_secret.win_password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "win-vm" {
  for_each            = var.windows-vm
  depends_on          = [azurerm_network_interface.win_nic, azurerm_key_vault_secret.win_password]
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = azurerm_key_vault_secret.win_password.value
  network_interface_ids = [
    azurerm_network_interface.win_nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
