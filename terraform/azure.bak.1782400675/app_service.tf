resource "azurerm_service_plan" "example" {
  name                = "terragoat-app-service-plan-${var.environment}${random_integer.rnd_int.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  os_type  = "Linux"
  sku_name = "B1"

  worker_count = 1

  tags = {
    environment = var.environment
    terragoat   = true
  }
}

resource "azurerm_linux_web_app" "app_service1" {
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  https_only                 = true
  client_certificate_enabled = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    minimum_tls_version = "1.2"
    http2_enabled       = true
    ftps_state          = "Disabled"
    health_check_path   = "/"
  }

  auth_settings {
    enabled = true
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }

    failed_request_tracing  = true
    detailed_error_messages = true
  }

  tags = {
    environment = var.environment
    terragoat   = true
  }
}

resource "azurerm_linux_web_app" "app_service2" {
  name                = "terragoat-app-service-auth-${var.environment}${random_integer.rnd_int.result}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  https_only                 = true
  client_certificate_enabled = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    minimum_tls_version = "1.2"
    http2_enabled       = true
    ftps_state          = "Disabled"
    health_check_path   = "/"
  }

  auth_settings {
    enabled = true
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }

    failed_request_tracing  = true
    detailed_error_messages = true
  }

  tags = {
    environment = var.environment
    terragoat   = true
  }
}