# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Despliegue de HTTPS LOAD BALANCER
# Este módulo contiene todos los recursos para desplegar un HTTP(S) Cloud Load Balancer
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# Crea un PUBLIC IP ADDRESS
# ------------------------------------------------------------------------------

resource "google_compute_global_address" "lb_ip" {
  project      = var.project
  name         = "${var.name}-${var.env}-ip"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}


# ------------------------------------------------------------------------------
# Crea las FORWARDING RULES
# ------------------------------------------------------------------------------

resource "google_compute_global_forwarding_rule" "cosmos_frontend" {
  ip_address            = google_compute_global_address.lb_ip.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "${var.name}-frontend"
  port_range            = "443-443"
  project               = var.project
  target                = google_compute_target_https_proxy.cosmos_lb_target_proxy.id
}

resource "google_compute_global_forwarding_rule" "cosmos_frontend_forwarding_rule" {
  ip_address            = google_compute_global_address.lb_ip.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "${var.name}-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = var.project
  target                = google_compute_target_http_proxy.cosmos_frontend_target_proxy.id
}

# ------------------------------------------------------------------------------
# Crea los TARGET PROXIES
# ------------------------------------------------------------------------------

resource "google_compute_target_https_proxy" "cosmos_lb_target_proxy" {
  project = var.project
  name    = "${var.name}-${var.env}-lb-target-proxy"
  url_map = google_compute_url_map.cosmos_pro_lb[0].self_link

  ssl_certificates = google_compute_managed_ssl_certificate.cosmos[0].self_link
}

resource "google_compute_target_http_proxy" "cosmos_frontend_target_proxy" {
  name    = "${var.name}-frontend-target-proxy"
  project = var.project
  url_map = google_compute_url_map.cosmos_frontend_redirect[0].self_link
}

# ------------------------------------------------------------------------------
# Crea Managed SSL Certificates
# ------------------------------------------------------------------------------

resource "google_compute_managed_ssl_certificate" "cosmos" {
  name    = "${var.name}-cert"
  project = var.project

  managed {
    domains = var.managed_domains
  }
}

# ------------------------------------------------------------------------------
# Crea URL Maps
# ------------------------------------------------------------------------------
#################
## DEFAULT LB ###
#################
resource "google_compute_url_map" "cosmos_pro_lb" {
  name            = "${var.name}-${var.env}-lb"
  default_service = var.backend_bucket

   dynamic "host_rule" {
    for_each = var.hostnames
    content {
      hosts               = [ host_rule.value ]
      path_matcher        = "path-matcher-${host_rule.key}"
    }
  }

  dynamic "path_matcher" {
    for_each = var.hostnames
    content {
      name                = "path-matcher-${path_matcher.key}"
      default_service     = google_compute_backend_service.default[path_matcher.key].id ##Revisar
    }
  }

  project = var.project
}
########################
## FRONTEND REDIRECT ###
########################

resource "google_compute_url_map" "cosmos_frontend_redirect" {
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }

  description = "Automatically generated HTTP to HTTPS redirect for the ${var.name}-frontend forwarding rule"
  name        = "${var.name}-frontend-redirect"
  project     = var.project
}

# ------------------------------------------------------------------------------
# Crea Backends
# ------------------------------------------------------------------------------

#######################
## BACKEND SERVICES ###
#######################

resource "google_compute_backend_service" "default" {
  for_each = ##
  connection_draining_timeout_sec = 300
  health_checks                   = [google_compute_health_check.cosmos_hc[0].self_link] # Check if this resource neds to be in a list.
  load_balancing_scheme           = "EXTERNAL"
  name                            = "${var.name}-${var.env}-backend"
  port_name                       = var.port_name
  project                         = var.project
  protocol                        = "HTTP"
  session_affinity                = "CLIENT_IP"
  timeout_sec                     = var.timeout_sec

  backend {
    group = var.instance_group # google_compute_instance_group_manager.xxx.instance_group
  }
}

#####################
## BUCKET SERVICE ###
#####################

resource "google_compute_backend_bucket" "empty" {
  bucket_name = "empty-bucket-${var.env}"
  name        = "empty-bucket"
  project     = "gbc-cosmos-${var.env}"
}

# ------------------------------------------------------------------------------
# Crea Health Checks
# ------------------------------------------------------------------------------

resource "google_compute_health_check" "cosmos_hc" {

for_each = var.health_checks

  check_interval_sec = 15
  healthy_threshold  = var.healthy_threshold
  name               = var.hc_name
  project            = var.project

  tcp_health_check {
    port         = var.port
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = var.unhealthy_threshold
}