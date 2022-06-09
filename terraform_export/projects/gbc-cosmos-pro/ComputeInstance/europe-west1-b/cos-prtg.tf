resource "google_compute_instance" "cos_prtg" {
  boot_disk {
    auto_delete = true
    device_name = "cos-prtg"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/ws-base"
      size  = 80
      type  = "pd-balanced"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cos-prtg"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  machine_type = "n2-custom-6-6144"

  metadata = {
    windows-keys               = "{\"userName\":\"msanchoh\",\"email\":\"msanchoh\",\"expireOn\":\"2022-06-06T12:29:19.2119758Z\",\"modulus\":\"n/4U+JdDNJx6kXm9BIwoTx74HTh88uc9DepQfrdWwTGr05fs/hLW0U3/satxFCO2zaxttnKP1XUAs6d2Hy3EpB7d2wfWevMC/hUZ0v9XFfx2nyhE38PmM0c/AdB8AtzZcq8+543qFlKWUR17mlRMCwr5asNGYvRrkt+FH8iFzvkc831pV0swdGCsa7GPSYskm/HkR/Qrvhhy0NSGMLS7SFXHsxLyPqyKcwG775mVTbYP81epNC00HGS9qCIlIeDRoYIdhSFKGrGKrWk++ou5huvn4lp7UX3l8RIjhBR/JJxvs7eqOdZl9Uau7YbbZRl9CtWfkPxyBvuF/xR3KuiPNQ==\",\"exponent\":\"AQAB\",\"addToAdministrators\":true}"
    windows-startup-script-ps1 = "# Join AD domain\nif ((gwmi win32_computersystem).partofdomain -eq $false) {\n    Install-WindowsFeature -Name \"RSAT-AD-Tools\" -IncludeAllSubFeature -IncludeManagementTools -Restart\n    $domain = \"COSMOSCLOUD.local\"\n    $username = \"$domain\\setupadmin\"\n    $password = \"&%na^|1<mZU+G[e\" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters\n    $credential = New-Object System.Management.Automation.PSCredential($username,$password)\n    Add-Computer -DomainName $domain -Credential $credential -Force -Restart\n} else {\n    # Force the update of GPOs\n    gpupdate /force\n\n    # Add domain users to local administrator group\n    try {\n        Add-LocalGroupMember -Group \"Administrators\" -Member \"COSMOSCLOUD\\prtgmonitor\" -ErrorAction Stop\n    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {\n        Write-Warning \"User already in Administrator group\"\n    }\n}"
  }

  name = "cos-prtg"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    network_ip         = "192.168.110.22"
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

  tags = ["prtg", "rdp"]
  zone = "europe-west1-b"
}
# terraform import google_compute_instance.cos_prtg projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cos-prtg
