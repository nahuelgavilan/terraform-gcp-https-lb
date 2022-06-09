resource "google_compute_image" "sql_image" {
  disk_size_gb = 168

  guest_os_features {
    type = "MULTI_IP_SUBNET"
  }

  guest_os_features {
    type = "UEFI_COMPATIBLE"
  }

  guest_os_features {
    type = "VIRTIO_SCSI_MULTIQUEUE"
  }

  guest_os_features {
    type = "WINDOWS"
  }

  licenses     = ["https://www.googleapis.com/compute/v1/projects/windows-cloud/global/licenses/windows-server-2019-dc"]
  name         = "sql-image"
  project      = "gbc-cosmos-pro"
  source_image = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-dev/global/images/sql-image"
}
# terraform import google_compute_image.sql_image projects/gbc-cosmos-pro/global/images/sql-image
