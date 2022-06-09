# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Startups Scripts (usados en instance_templates.tf)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ------------------------------------------------------------------------------
# COSMOS
# ------------------------------------------------------------------------------

data "template_file" "cosmos_startup" {
  template = <<EOF
# Locale
echo "Modificar locale"
Set-TimeZone -Id "Romance Standard Time"
Set-Culture -CultureInfo es-ES
Set-WinDefaultInputMethodOverride -InputTip "0c0a:0000040a"
Set-WinHomeLocation -GeoId 217
Set-WinSystemLocale -SystemLocale es-ES
Set-WinUILanguageOverride -Language es-ES
Set-WinUserLanguageList es-ES -Force
echo "------------------------------------------------------"

#Pequeño delay, para que de tiempo de activar las funciones de red
Start-Sleep -Seconds 10

# Join AD domain
echo "añadir dominio, aplicar gpo y añadir al grupo administrador el user cosmoswebpro"
if ((gwmi win32_computersystem).partofdomain -eq $false) {
    Install-WindowsFeature -Name "RSAT-AD-Tools" -IncludeAllSubFeature -IncludeManagementTools -Restart
    $domain = "COSMOSCLOUD.local"
    $username = "$domain\setupadmin"
    $password = "&%na^|1<mZU+G[e" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters
    $credential = New-Object System.Management.Automation.PSCredential($username,$password)
    Add-Computer -DomainName $domain -Credential $credential -Force -Restart
} else {
    # Force the update of GPOs
    gpupdate /force

# Add domain users to local administrator group
#Comentado, ya que el user ya esta dentro del grupo Adminsitratos, en el template o IMG de las VMs. Si no comentamos esta parte, puede devovler un error de confianza con el dominio.
#    try {
#        $wait_time = Get-Random -Minimum 6 -Maximum 26
#       Start-Sleep -Seconds $wait_time
#        cmd.exe /c "net localgroup Administrators /add COSMOSCLOUD\cosmoswebpro"
#        #Add-LocalGroupMember -Group "Administrators" -Member "COSMOSCLOUD\cosmoswebpro" -ErrorAction Stop
#    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {
#        Write-Warning "User already in Administrator group"
#    }
}
echo "------------------------------------------------------"

# NFS
echo "Mapear NFS en la D:"
if (-Not (Get-PSDrive D -ErrorAction SilentlyContinue)) {
    Install-WindowsFeature -Name NFS-Client
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUid" -Value "0" -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGid" -Value "0" -Type DWord
    # Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name "ProtectionMode" -Value "0"
    nfsadmin client stop
    nfsadmin client start
    #Solo activar el siguiente comando, si no nso deja asignar la letra D:
    #net use D: /delete
    New-PSDrive -Name "D" -PSProvider FileSystem -Root "\\10.156.97.2\vol1" -Persist
}
echo "------------------------------------------------------"

# SSH config
echo "Copiar archivos ssh"
Copy-Item "D:\ssh\sshd_config" -Destination "C:\ProgramData\ssh\sshd_config" -Force
New-Item -ItemType "directory" -Path "C:\Users\jenkins\.ssh" -Force
Copy-Item "D:\ssh\id_rsa*" -Destination "C:\Users\jenkins\.ssh" -Force
Copy-Item "D:\ssh\authorized_keys" -Destination "C:\Users\jenkins\.ssh\" -Force
echo "------------------------------------------------------"

# Create CosmosLog directory
echo "Crear Cronos Log"
New-Item -ItemType "directory" -Path "C:\Cosmos\Cosmos_Log" -Force
echo "------------------------------------------------------"

# IIS
# Reset IIS
echo "Reset IIS"
cmd.exe /c "%windir%\system32\inetsrv\appcmd list site /xml | %windir%\system32\inetsrv\appcmd delete site /in"
cmd.exe /c "%windir%\system32\inetsrv\appcmd list apppool /xml | %windir%\system32\inetsrv\appcmd delete apppool /in"
iisreset
echo "------------------------------------------------------"

# Cosmos
netsh advfirewall firewall add rule name='TCP Port 1330' dir=in action=allow protocol=TCP localport=1330
choco install dotnetcore-sdk --version=2.2.104
choco install sql2012.nativeclient
choco install sqlserver-odbcdriver --version=13.1.4413.46

cmd.exe /c "%windir%\system32\inetsrv\appcmd add apppool /in < D:\xml\cosmos\apppools_cosmos.xml"
cmd.exe /c "%windir%\system32\inetsrv\appcmd add site /in < D:\xml\cosmos\sites_cosmos.xml"
Set-WebConfigurationProperty -PSPath MACHINE/WEBROOT/APPHOST -Location 'Cosmos' -Filter system.webServer/asp -Name enableParentPaths -Value $true
EOF
}

# ------------------------------------------------------------------------------
# COSMOSNET
# ------------------------------------------------------------------------------

data "template_file" "cosmosnet_startup" {
  template = <<EOF
# Locale
echo "Modificar locale"
Set-TimeZone -Id "Romance Standard Time"
Set-Culture -CultureInfo es-ES
Set-WinDefaultInputMethodOverride -InputTip "0c0a:0000040a"
Set-WinHomeLocation -GeoId 217
Set-WinSystemLocale -SystemLocale es-ES
Set-WinUILanguageOverride -Language es-ES
Set-WinUserLanguageList es-ES -Force
echo "------------------------------------------------------"

#Pequeño delay, para que de tiempo de activar las funciones de red
Start-Sleep -Seconds 10

# Join AD domain
echo "añadir dominio, aplicar gpo y añadir al grupo administrador el user cosmoswebpro"
if ((gwmi win32_computersystem).partofdomain -eq $false) {
    Install-WindowsFeature -Name "RSAT-AD-Tools" -IncludeAllSubFeature -IncludeManagementTools -Restart
    $domain = "COSMOSCLOUD.local"
    $username = "$domain\setupadmin"
    $password = "&%na^|1<mZU+G[e" | ConvertTo-SecureString -asPlainText -Force # escape '$' characters
    $credential = New-Object System.Management.Automation.PSCredential($username,$password)
    Add-Computer -DomainName $domain -Credential $credential -Force -Restart
} else {
    # Force the update of GPOs
    gpupdate /force

# Add domain users to local administrator group
#Comentado, ya que el user ya esta dentro del grupo Adminsitratos, en el template o IMG de las VMs. Si no comentamos esta parte, puede devovler un error de confianza con el dominio.
#    try {
#        $wait_time = Get-Random -Minimum 6 -Maximum 26
#       Start-Sleep -Seconds $wait_time
#        cmd.exe /c "net localgroup Administrators /add COSMOSCLOUD\cosmoswebpro"
#        #Add-LocalGroupMember -Group "Administrators" -Member "COSMOSCLOUD\cosmoswebpro" -ErrorAction Stop
#    } catch [Microsoft.PowerShell.Commands.MemberExistsException] {
#        Write-Warning "User already in Administrator group"
#    }
}
echo "------------------------------------------------------"

# NFS
echo "Mapear NFS en la D:"
if (-Not (Get-PSDrive D -ErrorAction SilentlyContinue)) {
    Install-WindowsFeature -Name NFS-Client
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUid" -Value "0" -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGid" -Value "0" -Type DWord
    # Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name "ProtectionMode" -Value "0"
    nfsadmin client stop
    nfsadmin client start
    #Solo activar el siguiente comando, si no nso deja asignar la letra D:
    #net use D: /delete
    New-PSDrive -Name "D" -PSProvider FileSystem -Root "\\10.156.97.2\vol1" -Persist
}
echo "------------------------------------------------------"

# SSH config
echo "Copiar archivos ssh"
Copy-Item "D:\ssh\sshd_config" -Destination "C:\ProgramData\ssh\sshd_config" -Force
New-Item -ItemType "directory" -Path "C:\Users\jenkins\.ssh" -Force
Copy-Item "D:\ssh\id_rsa*" -Destination "C:\Users\jenkins\.ssh" -Force
Copy-Item "D:\ssh\authorized_keys" -Destination "C:\Users\jenkins\.ssh\" -Force
echo "------------------------------------------------------"

# Create CosmosLog directory
echo "Crear Cronos Log"
New-Item -ItemType "directory" -Path "C:\Cosmos\Cosmos_Log" -Force
echo "------------------------------------------------------"

# IIS
# Reset IIS
echo "Reset IIS"
cmd.exe /c "%windir%\system32\inetsrv\appcmd list site /xml | %windir%\system32\inetsrv\appcmd delete site /in"
cmd.exe /c "%windir%\system32\inetsrv\appcmd list apppool /xml | %windir%\system32\inetsrv\appcmd delete apppool /in"
iisreset
echo "------------------------------------------------------"

# Add IIS Sites/AppPools
cmd.exe /c "%windir%\system32\inetsrv\appcmd add apppool /in < D:\xml\cosmosnet\apppools_cosmosnet.xml"
cmd.exe /c "%windir%\system32\inetsrv\appcmd add site /in < D:\xml\cosmosnet\sites_cosmosnet.xml"
EOF
}