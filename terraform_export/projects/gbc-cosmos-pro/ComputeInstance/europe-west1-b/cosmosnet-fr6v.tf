resource "google_compute_instance" "cosmosnet_fr6v" {
  boot_disk {
    auto_delete = true
    device_name = "cosmosnet-pro-26-5-22"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/cosmosnet-pro"
      size  = 50
      type  = "pd-ssd"
    }

    mode   = "READ_WRITE"
    source = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cosmosnet-fr6v"
  }

  confidential_instance_config {
    enable_confidential_compute = false
  }

  machine_type = "n2-standard-2"

  metadata = {
    created-by                 = "projects/289207062865/zones/europe-west1-b/instanceGroupManagers/cosmosnet"
    instance-template          = "projects/289207062865/global/instanceTemplates/cosmosnet-pro-n2"
    windows-startup-script-ps1 = "# Locale\necho \"Modificar locale\"\nSet-TimeZone -Id \"Romance Standard Time\"\nSet-Culture -CultureInfo es-ES\nSet-WinDefaultInputMethodOverride -InputTip \"0c0a:0000040a\"\nSet-WinHomeLocation -GeoId 217\nSet-WinSystemLocale -SystemLocale es-ES\nSet-WinUILanguageOverride -Language es-ES\nSet-WinUserLanguageList es-ES -Force\necho \"------------------------------------------------------\"\n\n#Pequeño delay, para que de tiempo de activar las funciones de red\nStart-Sleep -Seconds 10\n\n# Join AD domain\necho \"añadir dominio, aplicar gpo y añadir al grupo administrador el user cosmoswebpro\"\nif ((gwmi win32_computersystem).partofdomain -eq $false) {\n    Install-WindowsFeature -Name \"RSAT-AD-Tools\" -IncludeAllSubFeature -IncludeManagementTools -Restart\n    $domain = \"COSMOSCLOUD.local\"\n    $username = \"$domain\\setupadmin\"\n    $password = \"&%na^|1<mZU+G[e\" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters\n    $credential = New-Object System.Management.Automation.PSCredential($username,$password)\n    Add-Computer -DomainName $domain -Credential $credential -Force -Restart\n} else {\n    # Force the update of GPOs\n    gpupdate /force\n\n# Add domain users to local administrator group\n#Comentado, ya que el user ya esta dentro del grupo Adminsitratos, en el template o IMG de las VMs. Si no comentamos esta parte, puede devovler un error de confianza con el dominio.\n#    try {\n#        $wait_time = Get-Random -Minimum 6 -Maximum 26\n#       Start-Sleep -Seconds $wait_time\n#        cmd.exe /c \"net localgroup Administrators /add COSMOSCLOUD\\cosmoswebpro\"\n#        #Add-LocalGroupMember -Group \"Administrators\" -Member \"COSMOSCLOUD\\cosmoswebpro\" -ErrorAction Stop\n#    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {\n#        Write-Warning \"User already in Administrator group\"\n#    }\n}\necho \"------------------------------------------------------\"\n\n# NFS\necho \"Mapear NFS en la D:\"\nif (-Not (Get-PSDrive D -ErrorAction SilentlyContinue)) {\n    Install-WindowsFeature -Name NFS-Client\n    Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\ClientForNFS\\CurrentVersion\\Default\" -Name \"AnonymousUid\" -Value \"0\" -Type DWord\n    Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\ClientForNFS\\CurrentVersion\\Default\" -Name \"AnonymousGid\" -Value \"0\" -Type DWord\n    # Set-ItemProperty -Path \"HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\" -Name \"ProtectionMode\" -Value \"0\"\n    nfsadmin client stop\n    nfsadmin client start\n    #Solo activar el siguiente comando, si no nso deja asignar la letra D:\n    #net use D: /delete\n    New-PSDrive -Name \"D\" -PSProvider FileSystem -Root \"\\\\10.156.97.2\\vol1\" -Persist\n}\necho \"------------------------------------------------------\"\n\n# SSH config\necho \"Copiar archivos ssh\"\nCopy-Item \"D:\\ssh\\sshd_config\" -Destination \"C:\\ProgramData\\ssh\\sshd_config\" -Force\nNew-Item -ItemType \"directory\" -Path \"C:\\Users\\jenkins\\.ssh\" -Force\nCopy-Item \"D:\\ssh\\id_rsa*\" -Destination \"C:\\Users\\jenkins\\.ssh\" -Force\nCopy-Item \"D:\\ssh\\authorized_keys\" -Destination \"C:\\Users\\jenkins\\.ssh\\\" -Force\necho \"------------------------------------------------------\"\n\n# Create CosmosLog directory\necho \"Crear Cronos Log\"\nNew-Item -ItemType \"directory\" -Path \"C:\\Cosmos\\Cosmos_Log\" -Force\necho \"------------------------------------------------------\"\n\n# IIS\n# Reset IIS\necho \"Reset IIS\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd list site /xml | %windir%\\system32\\inetsrv\\appcmd delete site /in\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd list apppool /xml | %windir%\\system32\\inetsrv\\appcmd delete apppool /in\"\niisreset\necho \"------------------------------------------------------\"\n\n# Add IIS Sites/AppPools\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd add apppool /in < D:\\xml\\cosmosnet\\apppools_cosmosnet.xml\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd add site /in < D:\\xml\\cosmosnet\\sites_cosmosnet.xml\""
  }

  name = "cosmosnet-fr6v"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    network_ip         = "192.168.110.47"
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
# terraform import google_compute_instance.cosmosnet_fr6v projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cosmosnet-fr6v
