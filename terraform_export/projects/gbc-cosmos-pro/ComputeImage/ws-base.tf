resource "google_compute_image" "ws_base" {
  disk_size_gb = 50
  family       = "windows-2019"

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

  licenses    = ["https://www.googleapis.com/compute/v1/projects/windows-cloud/global/licenses/windows-server-2019-dc"]
  name        = "ws-base"
  project     = "gbc-cosmos-pro"
  source_disk = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cosmos"
}
# terraform import google_compute_image.ws_base projects/gbc-cosmos-pro/global/images/ws-base
