resource "google_compute_instance" "cosmosnet" {
  boot_disk {
    auto_delete = true
    device_name = "cosmosnet"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/ws-base"
      size  = 50
      type  = "pd-ssd"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cosmosnet"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  deletion_protection = true
  machine_type        = "e2-standard-2"

  metadata = {
    windows-keys               = "{\"userName\":\"mbravom\",\"email\":\"mbravom\",\"expireOn\":\"2022-05-20T08:11:35.2905133Z\",\"modulus\":\"wbKHXeSSClWAAK0HSJlB/OxhfAZucRv1s6acbmUBgaT16qOtoTS8/vQALmFG6D7iyEcDHpJSUga3zVyHaxcQHAsBjhUI1iJiOqzuivVU9WGFW2siZJNqXhak9mlkO7+vRKPZp4xHUbXPyuNLFM81gkunCkjA+xfFW+yLzaZ+OkziTaZKlO2f3wsYC6vT9sOboIEqHIhq6Glfjknms4wmvcCnOSuGj1+jE7QAC0yK1bXUNtCE5VqQgnExgwJZM7sQteG8cXQBuwSWljqsfoqhUH9cGnQJGdUn/lNR/mHf56ddxyLdPUmrdekYhh/ybgzNxF4OrEUmGrh2nOrIbk/+7Q==\",\"exponent\":\"AQAB\",\"addToAdministrators\":true}"
    windows-startup-script-ps1 = "# Locale\nSet-TimeZone -Id \"Romance Standard Time\"\nSet-Culture -CultureInfo es-ES\nSet-WinDefaultInputMethodOverride -InputTip \"0c0a:0000040a\"\nSet-WinHomeLocation -GeoId 217\nSet-WinSystemLocale -SystemLocale es-ES\nSet-WinUILanguageOverride -Language es-ES\nSet-WinUserLanguageList es-ES -Force\n\n# Join AD domain\nif ((gwmi win32_computersystem).partofdomain -eq $false) {\n    Install-WindowsFeature -Name \"RSAT-AD-Tools\" -IncludeAllSubFeature -IncludeManagementTools -Restart\n    $domain = \"COSMOSCLOUD.local\"\n    $username = \"$domain\\setupadmin\"\n    $password = \"&%na^|1<mZU+G[e\" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters\n    $credential = New-Object System.Management.Automation.PSCredential($username,$password)\n    Add-Computer -DomainName $domain -Credential $credential -Force -Restart\n} else {\n    # Force the update of GPOs\n    gpupdate /force\n\n    # Add domain users to local administrator group\n    try {\n        Add-LocalGroupMember -Group \"Administrators\" -Member \"COSMOSCLOUD\\cosmoswebpro\" -ErrorAction Stop\n    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {\n        Write-Warning \"User already in Administrator group\"\n    }\n}\n\n# NFS\nif (-Not (Get-PSDrive D -ErrorAction SilentlyContinue)) {\n    Install-WindowsFeature -Name NFS-Client\n    Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\ClientForNFS\\CurrentVersion\\Default\" -Name \"AnonymousUid\" -Value \"0\" -Type DWord\n    Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\ClientForNFS\\CurrentVersion\\Default\" -Name \"AnonymousGid\" -Value \"0\" -Type DWord\n    nfsadmin client stop\n    nfsadmin client start\n    #net use D: /delete\n    New-PSDrive -Name \"D\" -PSProvider FileSystem -Root \"\\\\10.156.97.2\\vol1\" -Persist\n}\n\n# SSH config\nRename-Item -Path \"C:\\ProgramData\\ssh\\sshd_config\" -NewName \"C:\\ProgramData\\ssh\\sshd_config_old\"\nCopy-Item \"D:\\ssh\\sshd_config\" -Destination \"C:\\ProgramData\\ssh\\sshd_config\"\nmkdir C:\\Users\\jenkins\\.ssh\nCopy-Item \"D:\\ssh\\id*\" -Destination \"C:\\Users\\jenkins\\.ssh\\\"\nCopy-Item \"D:\\ssh\\authorized_keys\" -Destination \"C:\\Users\\jenkins\\.ssh\\\"\n\n# Create CosmosLog directory\nmkdir C:\\Cosmos\\Cosmos_Log\n\n# IIS\n# Reset IIS\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd list site /xml | %windir%\\system32\\inetsrv\\appcmd delete site /in\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd list apppool /xml | %windir%\\system32\\inetsrv\\appcmd delete apppool /in\"\niisreset\n\n# Add IIS Sites/AppPools\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd add apppool /in < D:\\xml\\cosmosnet\\apppools_cosmosnet.xml\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd add site /in < D:\\xml\\cosmosnet\\sites_cosmosnet.xml\""
  }

  name = "cosmosnet"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    network_ip         = "192.168.110.15"
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

  tags = ["cosmosnet", "hc", "rdp"]
  zone = "europe-west1-b"
}
# terraform import google_compute_instance.cosmosnet projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cosmosnet
