resource "azurerm_key_vault" "kv" {
  name                        = "kv-devops-001-${lower(replace(var.x["x1"].name, "-", ""))}"
  location                    = azurerm_resource_group.rg["x1"].location
  resource_group_name         = azurerm_resource_group.rg["x1"].name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "win_password" {

  name         = "win-admin-password"
  value        = var.win_admin_password
  # In a real scenario, this would be generated or passed via a secret variable
  key_vault_id = azurerm_key_vault.kv.id
}


data "azurerm_client_config" "current" {}
