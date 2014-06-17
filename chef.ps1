param([Switch] $list,[string]$cook)
$Offline = 'C:\wfm-install'
$Wc = New-Object Net.Webclient


#md $Offline -ErrorAction SilentlyContinue

$cookbook = (Get-Content cookbook.json) -join "`n" | ConvertFrom-Json
$rslist = $cookbook.recipes 

if ($list -eq $true) {
	echo $rslist.desc

	exit 
}

if ($recipe.length -gt 0) {
    $r = $rslist | Where {$_.id -eq "$cook"}
}

# Step 1 - Download offline 
$WPIFile = "wpi.msi"
#$Wc.DownloadFile('http://download.microsoft.com/download/7/0/4/704CEB4C-9F42-4962-A2B0-5C84B0682C7A/WebPlatformInstaller_amd64_en-US.msi', "$Offline\$WPIFile")
#Start-Process msiexec -ArgumentList "/i $Offline\$WPIFile" -Wait 

if ($r -ne $null) {
	# Step 2 - Download & install offline 
	foreach($rc in 	$r.recipe) {
		echo $rc
	}
}


#Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/offline /products:ServiceBus_1_1 /path:$Offline" -Wait
#Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/offline /products:WorkflowManagerRefresh /path:$Offline" -Wait
#Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/install /products:ServiceBus_1_1 /xml:$Offline\feeds\latest\webproductlist.xml /AcceptEULA" -Wait
#Start-Process "C:\Program Files\Microsoft\Web Platform Installer\webpicmd.exe" -ArgumentList "/install /products:WorkflowManagerRefresh /xml:$Offline\feeds\latest\webproductlist.xml /AcceptEULA" -Wait









