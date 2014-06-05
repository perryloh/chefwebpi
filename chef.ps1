$Offline = 'C:\wfm-install'
$Pfx = "c:\cert.pfx"
$Wc = New-Object Net.Webclient
$PwdRaw = "Windows.2000"


$wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$wmi.SetDNSServerSearchOrder("8.8.8.8")


md $Offline -ErrorAction SilentlyContinue


# Step 1 - Download offline 
$WPIFile = "wpi.msi"
$Wc.DownloadFile('http://download.microsoft.com/download/7/0/4/704CEB4C-9F42-4962-A2B0-5C84B0682C7A/WebPlatformInstaller_amd64_en-US.msi', "$Offline\$WPIFile")
Start-Process msiexec -ArgumentList "/i $Offline\$WPIFile" -Wait 

# Step 2 - Download & install offline 
Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/offline /products:ServiceBus_1_1 /path:$Offline" -Wait
Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/offline /products:WorkflowManagerRefresh /path:$Offline" -Wait
Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/install /products:ServiceBus_1_1 /xml:$Offline\feeds\latest\webproductlist.xml /AcceptEULA" -Wait
Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/install /products:WorkflowManagerRefresh /xml:$Offline\feeds\latest\webproductlist.xml /AcceptEULA" -Wait


Start-Process certutil -ArgumentList "-importpfx  -p $PwdRaw $Pfx AT_KEYEXCHANGE"






