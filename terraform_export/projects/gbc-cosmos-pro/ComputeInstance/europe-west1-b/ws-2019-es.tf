resource "google_compute_instance" "ws_2019_es" {
  boot_disk {
    auto_delete = true
    device_name = "ws-2019-es"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/windows-cloud/global/images/windows-server-2019-dc-v20220314"
      size  = 50
      type  = "pd-ssd"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-b/disks/ws-2019-es"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  machine_type = "e2-medium"

  metadata = {
    windows-keys = "{\"expireOn\":\"2022-04-25T13:25:59.842532Z\",\"userName\":\"devoteam\",\"email\":\"nahuel.gavilan@devoteam.com\",\"modulus\":\"ii1APYiXcWxfvZDnh4NUajLxgEx0P1899LAkRCOIA50gCC9fgww0j797i+KXPd/yrEK6Yti4W3K9q3ojDNSAFleV1U37MWmpChVdpWbMQpEH7lU1CcrzEpixD6N3hFBb3MBPz48plhA4vq2kFTnXdUCjaBJsVhTfeOpDVivP3IBuQ3iQ4gU8Evx6oo+ho4vURwEsmPF8HHqCccIW4JZlCjMi/tIlbN34EHeaCIG1YSPkQ/0j1CorRVlJFp0HjCW8Ak/a2tQsqT1kUb4ikThG/tiuaWODPHBDIsIHjLtqkf53ki1Y43X5PxUFg8jG+eJOYi84n+nqstKQ0ghk76+n3Q==\",\"exponent\":\"AQAB\"}"
  }

  name = "ws-2019-es"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    network_ip         = "192.168.110.3"
    stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
    subnetwork_project = "grupobc-sharedvpc"
  }

  project = "gbc-cosmos-pro"

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  service_account {
    email  = "289207062865-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  tags = ["test"]
  zone = "europe-west1-b"
}
# terraform import google_compute_instance.ws_2019_es projects/gbc-cosmos-pro/zones/europe-west1-b/instances/ws-2019-es
