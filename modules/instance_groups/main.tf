# ------------------------------------------------------------------------------
# Crea Managed Instance Group
# ------------------------------------------------------------------------------

resource "google_compute_instance_group_manager" "cosmos" {
  project = var.project
  name    = var.name

  zone               = var.zone
  base_instance_name = var.name

  dynamic "named_port" {
    for_each = var.named_port
    content {
      name = each.key
      port = each.value
    }
  }

  target_size {
    fixed = 2
  }

  auto_healing_policies {
    health_check = google_compute_health_check.autohealing.self_link
  }

  version {
    instance_template = google_compute_instance_template.cosmos.id
  }

}

resource "google_compute_health_check" "autohealing" {

  for_each = local.health_check
  project  = var.project
  name     = "${var.name}-autohealing"

  check_interval_sec  = each.value.check_interval_sec
  timeout_sec         = each.value.timeout_sec
  healthy_threshold   = each.value.healthy_threshold
  unhealthy_threshold = each.value.unhealthy_threshold

  tcp_health_check {
    port         = each.value.port
    proxy_header = "NONE"
  }

} 