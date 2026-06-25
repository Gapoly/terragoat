resource "azurerm_mssql_server" "mssql1" {
  name                         = "tgsql${var.environment}${random_integer.rnd_int.result}"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = var.sql_admin_password

  minimum_tls_version = "1.2"

  tags = {
    environment = var.environment
    terragoat   = true
  }
}

resource "azurerm_mssql_database" "mssql_db" {
  name      = "terragoat-db-${var.environment}"
  server_id = azurerm_mssql_server.mssql1.id

  sku_name    = "Basic"
  max_size_gb = 2

  tags = {
    environment = var.environment
    terragoat   = true
  }
}