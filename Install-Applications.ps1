# Software install Script
#
# Applications to install:
#
# Foxit Reader Enterprise Packaging (requires registration)
# https://kb.foxitsoftware.com/hc/en-us/articles/360040658811-Where-to-download-Foxit-Reader-with-Enterprise-Packaging-MSI-
# 
# Notepad++
# https://notepad-plus-plus.org/downloads/v7.8.8/
# See comments on creating a custom setting to disable auto update message
# https://community.notepad-plus-plus.org/post/38160



#region Set logging 
$logFile = "c:\temp\" + (get-date -format 'yyyyMMdd') + '_softwareinstall.log'
function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion

#region 7zip
try {
    Start-Process -filepath msiexec.exe -Wait -ErrorAction Stop -ArgumentList '/i', 'c:\temp\7z1900-x64.msi', '/qn'
    if (Test-Path "C:\Program Files\7-Zip\7zFM.exe") {
        Write-Log "7-Zip has been installed"
        Write-Host "7-Zip has been installed"
    }
    else {
        write-log "Error locating the 7-Zip executable"
        write-host "Error locating the 7-Zip executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing 7-Zip: $ErrorMessage"
    write-host "Error installing 7-Zip: $ErrorMessage"
}
#endregion

#region Notepad++
try {
    Start-Process -filepath 'c:\temp\npp.8.1.2.Installer.x64.exe' -Wait -ErrorAction Stop -ArgumentList '/S'
    if (Test-Path "C:\Program Files\Notepad++\notepad++.exe") {
        Write-Log "Notepad++ has been installed"
        Write-host "Notepad++ has been installed"
    }
    else {
        write-log "Error locating the Notepad++ executable"
        write-host "Error locating the Notepad++ executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Notepad++: $ErrorMessage"
    write-host "Error installing Notepad++: $ErrorMessage"
}
#endregion

#region Acrobat Reader
try {
    Start-Process -filepath 'c:\temp\AcroRdrDC2100520058_en_US.exe' -Wait -ErrorAction Stop -ArgumentList '/sAll /rs /rps /msi /norestart /quiet EULA_ACCEPT=YES'
    if (Test-Path "C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe") {
        Write-Log "Acrobat Reader has been installed"
        Write-host "Acrobat Reader has been installed"
    }
    else {
        write-log "Error locating the Acrobat Reader executable"
        write-host "Error locating the Acrobat Reader executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Acrobat Reader: $ErrorMessage"
    write-host "Error installing Acrobat Reader: $ErrorMessage"
}
#endregion


#region Time Zone Redirection
$Name = "fEnableTimeZoneRedirection"
$value = "1"
# Add Registry value
try {
    New-ItemProperty -ErrorAction Stop -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name $name -Value $value -PropertyType DWORD -Force
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services").PSObject.Properties.Name -contains $name) {
        Write-log "Added time zone redirection registry key"
        Write-host "Added time zone redirection registry key"
    }
    else {
        write-log "Error locating the Teams registry key"
        write-host "Error locating the Teams registry key"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error adding teams registry KEY: $ErrorMessage"
    write-host "Error adding teams registry KEY: $ErrorMessage"
}
#endregion