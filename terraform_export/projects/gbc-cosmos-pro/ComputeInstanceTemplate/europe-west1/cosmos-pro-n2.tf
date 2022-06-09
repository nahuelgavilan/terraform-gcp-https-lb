resource "google_compute_instance_template" "cosmos_pro_n2" {
  confidential_instance_config {
    enable_confidential_compute = false
  }

  disk {
    auto_delete  = true
    boot         = true
    device_name  = "cosmos-pro-n2"
    disk_size_gb = 50
    disk_type    = "pd-ssd"
    mode         = "READ_WRITE"
    source_image = "projects/gbc-cosmos-pro/global/images/cosmos-v3"
    type         = "PERSISTENT"
  }

  labels = {
    managed-by-cnrm = "true"
  }

  machine_type = "n2-standard-2"

  metadata = {
    windows-startup-script-ps1 = "# Locale\necho \"Modificar locale\"\nSet-TimeZone -Id \"Romance Standard Time\"\nSet-Culture -CultureInfo es-ES\nSet-WinDefaultInputMethodOverride -InputTip \"0c0a:0000040a\"\nSet-WinHomeLocation -GeoId 217\nSet-WinSystemLocale -SystemLocale es-ES\nSet-WinUILanguageOverride -Language es-ES\nSet-WinUserLanguageList es-ES -Force\necho \"------------------------------------------------------\"\n\n#Pequeño delay, para que de tiempo de activar las funciones de red\nStart-Sleep -Seconds 10\n\n# Join AD domain\necho \"añadir dominio, aplicar gpo y añadir al grupo administrador el user cosmoswebpro\"\nif ((gwmi win32_computersystem).partofdomain -eq $false) {\n    Install-WindowsFeature -Name \"RSAT-AD-Tools\" -IncludeAllSubFeature -IncludeManagementTools -Restart\n    $domain = \"COSMOSCLOUD.local\"\n    $username = \"$domain\\setupadmin\"\n    $password = \"&%na^|1<mZU+G[e\" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters\n    $credential = New-Object System.Management.Automation.PSCredential($username,$password)\n    Add-Computer -DomainName $domain -Credential $credential -Force -Restart\n} else {\n    # Force the update of GPOs\n    gpupdate /force\n\n# Add domain users to local administrator group\n#Comentado, ya que el user ya esta dentro del grupo Adminsitratos, en el template o IMG de las VMs. Si no comentamos esta parte, puede devovler un error de confianza con el dominio.\n#    try {\n#        $wait_time = Get-Random -Minimum 6 -Maximum 26\n#       Start-Sleep -Seconds $wait_time\n#        cmd.exe /c \"net localgroup Administrators /add COSMOSCLOUD\\cosmoswebpro\"\n#        #Add-LocalGroupMember -Group \"Administrators\" -Member \"COSMOSCLOUD\\cosmoswebpro\" -ErrorAction Stop\n#    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {\n#        Write-Warning \"User already in Administrator group\"\n#    }\n}\necho \"------------------------------------------------------\"\n\n# NFS\necho \"Mapear NFS en la D:\"\nif (-Not (Get-PSDrive D -ErrorAction SilentlyContinue)) {\n    Install-WindowsFeature -Name NFS-Client\n    Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\ClientForNFS\\CurrentVersion\\Default\" -Name \"AnonymousUid\" -Value \"0\" -Type DWord\n    Set-ItemProperty -Path \"HKLM:\\SOFTWARE\\Microsoft\\ClientForNFS\\CurrentVersion\\Default\" -Name \"AnonymousGid\" -Value \"0\" -Type DWord\n    # Set-ItemProperty -Path \"HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\" -Name \"ProtectionMode\" -Value \"0\"\n    nfsadmin client stop\n    nfsadmin client start\n    #Solo activar el siguiente comando, si no nso deja asignar la letra D:\n    #net use D: /delete\n    New-PSDrive -Name \"D\" -PSProvider FileSystem -Root \"\\\\10.156.97.2\\vol1\" -Persist\n}\necho \"------------------------------------------------------\"\n\n# SSH config\necho \"Copiar archivos ssh\"\nCopy-Item \"D:\\ssh\\sshd_config\" -Destination \"C:\\ProgramData\\ssh\\sshd_config\" -Force\nNew-Item -ItemType \"directory\" -Path \"C:\\Users\\jenkins\\.ssh\" -Force\nCopy-Item \"D:\\ssh\\id_rsa*\" -Destination \"C:\\Users\\jenkins\\.ssh\" -Force\nCopy-Item \"D:\\ssh\\authorized_keys\" -Destination \"C:\\Users\\jenkins\\.ssh\\\" -Force\necho \"------------------------------------------------------\"\n\n# Create CosmosLog directory\necho \"Crear Cronos Log\"\nNew-Item -ItemType \"directory\" -Path \"C:\\Cosmos\\Cosmos_Log\" -Force\necho \"------------------------------------------------------\"\n\n# IIS\n# Reset IIS\necho \"Reset IIS\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd list site /xml | %windir%\\system32\\inetsrv\\appcmd delete site /in\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd list apppool /xml | %windir%\\system32\\inetsrv\\appcmd delete apppool /in\"\niisreset\necho \"------------------------------------------------------\"\n\n# Cosmos\nnetsh advfirewall firewall add rule name='TCP Port 1330' dir=in action=allow protocol=TCP localport=1330\nchoco install dotnetcore-sdk --version=2.2.104\nchoco install sql2012.nativeclient\nchoco install sqlserver-odbcdriver --version=13.1.4413.46\n\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd add apppool /in < D:\\xml\\cosmos\\apppools_cosmos.xml\"\ncmd.exe /c \"%windir%\\system32\\inetsrv\\appcmd add site /in < D:\\xml\\cosmos\\sites_cosmos.xml\"\nSet-WebConfigurationProperty -PSPath MACHINE/WEBROOT/APPHOST -Location 'Cosmos' -Filter system.webServer/asp -Name enableParentPaths -Value $true"
  }

  name = "cosmos-pro-n2"

  network_interface {
    network            = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
    subnetwork_project = "grupobc-sharedvpc"
  }

  project = "gbc-cosmos-pro"
  region  = "europe-west1"

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

  tags = ["cosmos", "hc", "rdp"]
}
# terraform import google_compute_instance_template.cosmos_pro_n2 projects/gbc-cosmos-pro/global/instanceTemplates/cosmos-pro-n2
