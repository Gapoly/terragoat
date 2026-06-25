resource "azurerm_security_center_subscription_pricing" "pricing" {
  tier = "Standard"
}

resource "azurerm_security_center_contact" "contact" {
  email               = "admin-securite@example.com"
  phone               = "+33123456789"
  alert_notifications = true
  alerts_to_admins    = true
}