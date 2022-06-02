# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Despliegue de HTTPS LOAD BALANCER
# Este módulo contiene todos los artefactos para desplegar un HTTP(S) Cloud Load Balancer
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# Crea un PUBLIC IP ADDRESS
# ------------------------------------------------------------------------------

resource "google_compute_global_address" "default" {
  project      = var.project_id 
  name         = "${var.ip_name}-${env}-ip"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

# ------------------------------------------------------------------------------
# Crea Managed Instance Group
# ------------------------------------------------------------------------------


