resource "google_compute_instance" "sql_witness" {
  boot_disk {
    auto_delete = true
    device_name = "sql-witness"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/ws-base"
      size  = 50
      type  = "pd-balanced"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-c/disks/sql-witness"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  machine_type = "e2-medium"

  metadata = {
    windows-startup-script-ps1    = "# Locale\nSet-TimeZone -Id \"Romance Standard Time\"\nSet-Culture -CultureInfo es-ES\nSet-WinDefaultInputMethodOverride -InputTip \"0c0a:0000040a\"\nSet-WinHomeLocation -GeoId 217\nSet-WinSystemLocale -SystemLocale es-ES\nSet-WinUILanguageOverride -Language es-ES\nSet-WinUserLanguageList es-ES -Force\n\n# Join AD domain\nif ((gwmi win32_computersystem).partofdomain -eq $false) {\n    Install-WindowsFeature -Name \"RSAT-AD-Tools\" -IncludeAllSubFeature -IncludeManagementTools -Restart\n    $domain = \"COSMOSCLOUD.local\"\n    $username = \"$domain\\setupadmin\"\n    $password = \"&%na^|1<mZU+G[e\" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters\n    $credential = New-Object System.Management.Automation.PSCredential($username,$password)\n    Add-Computer -DomainName $domain -Credential $credential -Force -Restart\n} else {\n    # Force the update of GPOs\n    gpupdate /force\n\n    # Add domain users to local administrator group\n    try {\n        Add-LocalGroupMember -Group \"Administrators\" -Member \"COSMOSCLOUD\\cosmoswebdev\", \"COSMOSCLOUD\\cosmoswebpro\" -ErrorAction Stop\n    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {\n        Write-Warning \"User already in Administrator group\"\n    }\n}"
    sysprep-specialize-script-ps1 = "add-windowsfeature FS-FileServer"
  }

  name = "sql-witness"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    network_ip         = "192.168.110.44"
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

  tags = ["rdp", "wsfc", "wsfc-node"]
  zone = "europe-west1-c"
}
# terraform import google_compute_instance.sql_witness projects/gbc-cosmos-pro/zones/europe-west1-c/instances/sql-witness
