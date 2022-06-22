# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Creación del Insantace Template para los MIG(s)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# COSMOS
# ------------------------------------------------------------------------------

resource "google_compute_instance_template" "cosmos" {
  project = var.project
  name    = "${var.name}-${var.env}"
  region  = var.region

  machine_type   = "n2-standard-2"
  can_ip_forward = "false"
  tags           = ["cosmos", "hc", "rdp"]

  confidential_instance_config {
    enable_confidential_compute = "false"
  }

  disk {
    auto_delete  = "true"
    boot         = "true"
    device_name  = "${var.name}-${var.env}"
    disk_size_gb = "50"
    disk_type    = "pd-ssd"
    mode         = "READ_WRITE"
    source_image = "projects/gbc-cosmos-pro/global/images/cosmos-v3"
    type         = "PERSISTENT"
  }


  metadata = {
    windows-startup-script-ps1 = data.template_file.cosmos_startup.rendered
  }


  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    queue_count        = "0"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
    subnetwork_project = "grupobc-sharedvpc"
  }


  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "289207062865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

}

# ------------------------------------------------------------------------------
# COSMOSNET
# ------------------------------------------------------------------------------

resource "google_compute_instance_template" "cosmosnet" {
  project = "gbc-cosmos-pro"
  name    = "cosmosnet-pro-n2"
  region  = "europe-west1"

  machine_type   = "n2-standard-2"
  can_ip_forward = "false"

  confidential_instance_config {
    enable_confidential_compute = "false"
  }

  disk {
    auto_delete  = "true"
    boot         = "true"
    device_name  = "${var.name}-${var.env}"
    disk_size_gb = "50"
    disk_type    = "pd-ssd"
    mode         = "READ_WRITE"
    source_image = "projects/gbc-cosmos-pro/global/images/cosmosnet-pro"
    type         = "PERSISTENT"
  }


  metadata = {
    windows-startup-script-ps1 = data.template_file.cosmosnet_startup.rendered
  }


  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    queue_count        = "0"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
    subnetwork_project = "grupobc-sharedvpc"
  }


  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = "true"
    min_node_cpus       = "0"
    on_host_maintenance = "MIGRATE"
    preemptible         = "false"
  }

  service_account {
    email  = "289207062865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = "true"
    enable_secure_boot          = "false"
    enable_vtpm                 = "true"
  }

  tags = ["cosmosnet", "hc", "rdp"]
}
