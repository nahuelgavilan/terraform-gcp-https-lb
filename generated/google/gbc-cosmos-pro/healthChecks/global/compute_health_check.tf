resource "google_compute_health_check" "tfer--cosmos-hc" {
  check_interval_sec = "15"
  healthy_threshold  = "2"

  log_config {
    enable = "false"
  }

  name    = "cosmos-hc"
  project = "gbc-cosmos-pro"

  tcp_health_check {
    port         = "1330"
    proxy_header = "NONE"
  }

  timeout_sec         = "5"
  unhealthy_threshold = "3"
}

resource "google_compute_health_check" "tfer--cosmosnet-hc" {
  check_interval_sec = "15"
  healthy_threshold  = "2"

  log_config {
    enable = "false"
  }

  name    = "cosmosnet-hc"
  project = "gbc-cosmos-pro"

  tcp_health_check {
    port         = "1331"
    proxy_header = "NONE"
  }

  timeout_sec         = "5"
  unhealthy_threshold = "3"
}

resource "google_compute_health_check" "tfer--cosmosnet-hc-1332" {
  check_interval_sec = "15"
  healthy_threshold  = "3"

  log_config {
    enable = "false"
  }

  name    = "cosmosnet-hc-1332"
  project = "gbc-cosmos-pro"

  tcp_health_check {
    port         = "1332"
    proxy_header = "NONE"
  }

  timeout_sec         = "5"
  unhealthy_threshold = "1"
}

resource "google_compute_health_check" "tfer--crystalreport-hc" {
  check_interval_sec = "15"
  healthy_threshold  = "1"

  log_config {
    enable = "false"
  }

  name    = "crystalreport-hc"
  project = "gbc-cosmos-pro"

  tcp_health_check {
    port         = "1333"
    proxy_header = "NONE"
  }

  timeout_sec         = "5"
  unhealthy_threshold = "3"
}

resource "google_compute_health_check" "tfer--interop-hc" {
  check_interval_sec = "15"
  healthy_threshold  = "1"

  log_config {
    enable = "false"
  }

  name    = "interop-hc"
  project = "gbc-cosmos-pro"

  tcp_health_check {
    port         = "1334"
    proxy_header = "NONE"
  }

  timeout_sec         = "5"
  unhealthy_threshold = "3"
}

resource "google_compute_health_check" "tfer--wsfc-healthcheck" {
  check_interval_sec = "2"
  healthy_threshold  = "1"

  log_config {
    enable = "false"
  }

  name    = "wsfc-healthcheck"
  project = "gbc-cosmos-pro"

  tcp_health_check {
    port               = "59997"
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
  }

  timeout_sec         = "1"
  unhealthy_threshold = "2"
}
