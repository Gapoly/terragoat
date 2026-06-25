resource "azurerm_key_vault" "example" {
  name                = "terragoat-key-${var.environment}${random_integer.rnd_int.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Import",
      "Decrypt",
      "Encrypt",
      "UnwrapKey",
      "WrapKey",
      "Verify",
      "Sign",
      "Purge",
      "Release",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge"
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Import",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
      "Purge"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "46c68974-c108-4182-b240-94e0d7e40493"

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Import",
      "Decrypt",
      "Encrypt",
      "UnwrapKey",
      "WrapKey",
      "Verify",
      "Sign",
      "Purge",
      "Release",
      "Rotate",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge"
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Import",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
      "Purge"
    ]
  }

  tags = merge({
    environment = var.environment
    terragoat   = true
    }, {
    git_commit           = "81738b80d571fa3034633690d13ffb460e1e7dea"
    git_file             = "terraform/azure/key_vault.tf"
    git_last_modified_at = "2020-06-19 21:14:50"
    git_last_modified_by = "Adin.Ermie@outlook.com"
    git_modifiers        = "Adin.Ermie/nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "79afeacc-248a-4015-a4fa-76a6a57f06e2"
  })
}

resource "azurerm_key_vault_key" "generated" {
  name         = "terragoat-generated-certificate-${var.environment}"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA-HSM"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey"
  ]

  depends_on = [
    azurerm_key_vault.example
  ]

  tags = {
    environment = var.environment
    terragoat   = true
  }
}

resource "azurerm_key_vault_secret" "secret" {
  name         = "terragoat-secret-${var.environment}"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.example.id

  depends_on = [
    azurerm_key_vault.example
  ]

  tags = {
    environment = var.environment
    terragoat   = true
  }
}