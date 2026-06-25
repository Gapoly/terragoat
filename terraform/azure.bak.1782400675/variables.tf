variable "subscription_id" {
  type        = string
  description = "The subscription ID to be scanned"
  default     = null
}

variable "location" {
  type    = string
  default = "France Central"
}

variable "environment" {
  default     = "dev"
  description = "Must be all lowercase letters or numbers"
}

variable "admin_ip_cidr" {
  description = "Adresse IP autorisée pour l'administration"
  type        = string
  default     = "203.0.113.10/32"
}

variable "admin_ssh_public_key" {
  description = "Clé publique SSH de l'administrateur"
  type        = string
}

variable "sql_admin_password" {
  description = "Mot de passe administrateur SQL"
  type        = string
  sensitive   = true
}
