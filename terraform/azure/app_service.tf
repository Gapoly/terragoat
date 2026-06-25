resource "azurerm_app_service_plan" "example" {
  name                = "terragoat-app-service-plan-${var.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Dynamic"
    size = "S1"
  }
  tags = {
    git_commit           = "898d5beaec7ffdef6df0d7abecff407362e2a74e"
    git_file             = "terraform/azure/app_service.tf"
    git_last_modified_at = "2020-06-17 12:59:55"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "6611bf45-fd5b-467e-b119-d533cd7539b8"
  }
}

resource "azurerm_app_service" "app-service1" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name

  https_only = true

  site_config {
    min_tls_version = "1.2"
  }

  auth_settings {
    enabled = true
  }

  tags = {
    environment = var.environment
    terragoat   = true
  }
}

resource "azurerm_app_service" "app-service2" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-auth-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name

  https_only = true

  auth_settings {
    enabled = true
  }

  tags = {
    environment = var.environment
    terragoat   = true
  }
}
