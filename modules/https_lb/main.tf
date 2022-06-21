# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Despliegue de HTTPS LOAD BALANCER
# Este módulo contiene todos los recursos para desplegar un HTTP(S) Cloud Load Balancer
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

locals {

  health_checked_backends = { for backend_index, backend_value in var.backends : backend_index => backend_value if backend_value["health_check"] != null }

}

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

resource "google_compute_global_forwarding_rule" "frontend" {
  project               = var.project
  name                  = "${var.name}-frontend"

  ip_address            = google_compute_global_address.lb_ip.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443-443"
  target                = google_compute_target_https_proxy.lb_target_proxy.id
}

resource "google_compute_global_forwarding_rule" "frontend_forwarding_rule" {
  project               = var.project
  name                  = "${var.name}-frontend-forwarding-rule"

  ip_address            = google_compute_global_address.lb_ip.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80-80"
  target                = google_compute_target_http_proxy.frontend_target_proxy.id
}

# ------------------------------------------------------------------------------
# Crea los TARGET PROXIES
# ------------------------------------------------------------------------------

resource "google_compute_target_https_proxy" "lb_target_proxy" {
  project = var.project
  name    = "${var.name}-${var.env}-lb-target-proxy"

  url_map = [google_compute_url_map.lb[0].self_link]
  ssl_certificates = [google_compute_managed_ssl_certificate.default[*].self_link]
}

resource "google_compute_target_http_proxy" "frontend_target_proxy" {
  project = var.project
  name    = "${var.name}-frontend-target-proxy"

  url_map = [google_compute_url_map.frontend_redirect[0].self_link]
}

# ------------------------------------------------------------------------------
# Crea Managed SSL Certificates
# ------------------------------------------------------------------------------

resource "google_compute_managed_ssl_certificate" "default" {
  for_each = var.ssl_cert
  project  = var.project
  name     = "${each.key}-cert"

  managed {
    domains = each.value
  }
}

# ------------------------------------------------------------------------------
# Crea URL Maps
# ------------------------------------------------------------------------------
#################
## DEFAULT LB ###
#################
resource "google_compute_url_map" "lb" {
  project = var.project
  name            = "${var.name}-${var.env}-lb"

  default_service = var.backend_bucket
  
  dynamic "host_rule" {
    for_each = var.hostnames
    content {
      hosts        = [host_rule.value]
      path_matcher = "path-matcher-${host_rule.key}"
    }
  }

  dynamic "path_matcher" {
    for_each = var.hostnames
    content {
      name            = "path-matcher-${path_matcher.key}"
      default_service = [google_compute_backend_service.default[path_matcher.key].id] ##Revisar
    }
  }

}
########################
## FRONTEND REDIRECT ###
########################

resource "google_compute_url_map" "frontend_redirect" {
  project     = var.project
  description = "Automatically generated HTTP to HTTPS redirect for the ${var.name}-frontend forwarding rule"
  name        = "${var.name}-frontend-redirect"

  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }

}

# ------------------------------------------------------------------------------
# Crea Backends
# ------------------------------------------------------------------------------

#######################
## BACKEND SERVICES ###
#######################

resource "google_compute_backend_service" "default" {
  for_each                        = var.backends

  project                         = var.project
  name                            = "${var.name}-${var.env}-backend"

  connection_draining_timeout_sec = 300
  health_checks                   = lookup(each.value, "health_check", null) == null ? null : [google_compute_health_check.default[each.key].self_link]
  load_balancing_scheme           = "EXTERNAL"
  port_name                       = each.value.port_name
  protocol                        = "HTTP"
  session_affinity                = "CLIENT_IP"
  timeout_sec                     = each.value.timeout_sec

  dynamic "backend" {
    for_each = toset(each.value["groups"])
    content {                                
      group = lookup(backend.value, "group") # google_compute_instance_group_manager.xxx.instance_group
    }
  }
  
  depends_on = [
    google_compute_health_check.default
  ]

}

#####################
## BUCKET SERVICE ###
#####################

resource "google_compute_backend_bucket" "empty" {
  project     = "gbc-cosmos-${var.env}"
  name        = "empty-bucket"
  
  bucket_name = "empty-bucket-${var.env}"
}

# ------------------------------------------------------------------------------
# Crea Health Checks
# ------------------------------------------------------------------------------

resource "google_compute_health_check" "default" {

  for_each = local.health_checked_backends
  project  = var.project
  name     = "${var.name}-hc"

  check_interval_sec  = lookup(each.value["health_check"], "check_interval_sec", 15)
  timeout_sec         = lookup(each.value["health_check"], "timeout_sec", 5)
  healthy_threshold   = lookup(each.value["health_check"], "healthy_threshold", 2)
  unhealthy_threshold = lookup(each.value["health_check"], "unhealthy_threshold", 2)

  tcp_health_check {
    port         = lookup(each.value["health_check"], "port", 1330)
    proxy_header = "NONE"
  }

}