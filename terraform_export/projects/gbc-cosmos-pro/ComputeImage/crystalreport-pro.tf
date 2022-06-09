resource "google_compute_image" "crystalreport_pro" {
  disk_size_gb = 50

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
  name        = "crystalreport-pro"
  project     = "gbc-cosmos-pro"
  source_disk = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-b/disks/crystalreport"
}
# terraform import google_compute_image.crystalreport_pro projects/gbc-cosmos-pro/global/images/crystalreport-pro
