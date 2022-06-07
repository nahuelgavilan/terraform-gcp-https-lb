# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Despliegue de HTTPS LOAD BALANCER
# Este módulo contiene todos los artefactos para desplegar un HTTP(S) Cloud Load Balancer
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# Crea un PUBLIC IP ADDRESS
# ------------------------------------------------------------------------------

resource "google_compute_global_address" "lb_ip" {
  project      = var.project_id 
  name         = "${var.ip_name}-${env}-ip"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}


# ------------------------------------------------------------------------------
# Crea las FORWARDING RULES
# ------------------------------------------------------------------------------

resource "google_compute_global_forwarding_rule" "cosmos_frontend" {
  ip_address            = var.ip_address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmos-frontend"
  port_range            = "443-443"
  project               = var.project
  target                = google_compute_target_https_proxy.cosmos-lb-target-proxy[0].self_link
}

resource "google_compute_global_forwarding_rule" "cosmos_frontend_forwarding_rule" {
  ip_address            = var.ip_address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmos-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = var.project
  target                = google_compute_target_https_proxy.cosmos_frontend_target_proxy[0].self_link
}

# ------------------------------------------------------------------------------
# Crea los TARGET PROXIES
# ------------------------------------------------------------------------------

resource "google_compute_target_https_proxy" "cosmos_lb_target_proxy" {
  project = var.project
  name    = "cosmos-${var.env}-lb-target-proxy"
  url_map = var.url_map

  ssl_certificates = var.ssl_certificates
}

resource "google_compute_target_https_proxy" "cosmos_frontend_target_proxy" {
  project = var.project
  name    = "cosmos-frontend-target-proxy"
  url_map = var.url_map

  ssl_certificates = var.ssl_certificates
}

# ------------------------------------------------------------------------------
# Crea Managed SSL Certificates
# ------------------------------------------------------------------------------

resource "google_compute_managed_ssl_certificate" "cosmos" {
  name = "cosmos-cert"

  managed {
    domains = var.cosmos_domains  ## CHECK
  }
}

# ------------------------------------------------------------------------------
# Crea Managed Instance Group
# ------------------------------------------------------------------------------

resource "google_compute_instance_group" "cosmos" {
    name= "cosmos"
    
  
}

