resource "azurerm_log_analytics_workspace" "aks" {
  name                = "terragoat-aks-law-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 90

  tags = {
    environment = var.environment
    terragoat   = true
  }
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  dns_prefix          = "terragoat-${var.environment}"
  location            = var.location
  name                = "terragoat-aks-${var.environment}"
  resource_group_name = azurerm_resource_group.example.name

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_D2_v2"
    node_count = 2
  }

  role_based_access_control_enabled = true

  oms_agent {
    log_analytics_workspace_id      = azurerm_log_analytics_workspace.aks.id
    msi_auth_for_monitoring_enabled = true
  }

  tags = {
    environment = var.environment
    terragoat   = true
  }
}