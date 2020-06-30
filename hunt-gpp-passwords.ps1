#cleary you need to mod this a bit

Set-Location -Path Env:\
$dc = Get-ChildItem -Path LOGONSERVER
$sysvol = $dc.value.ToString() + "\sysvol\pwndefend.local\Policies\"
$sysvol

robocopy $sysvol 'C:\users\mrr3b00t.PWNDEFEND\Desktop\gpp\' /MIR

#find all the files
$folder = Get-ChildItem "C:\Users\mrr3b00t.PWNDEFEND\Desktop\gpp" -Filter *.xml -Recurse
#check xml files size and line count to avoid Solar's evil blue team goodness :P
foreach($file in $folder)
{

write-host $file
write-host $file.Attributes
write-host $file.Attributes

$content = Get-Content $file.FullName

#count the number of lines
$lines = Get-Content $file.FullName | Measure-Object

write-host $lines.Count
#check its file size
write-host  $file.Length


#if its lots of lines and a large file its probably a honeypot/canary
# thanks to https://twitter.com/S0lari1
# now if they are monitoring file access then you will get an alert so you could enumerate ur aplied gpos and only hunt for very specific xml files

if(($lines.Count -ge 50) -or ($file.Length -ge 2000)){
write-host "Blue Team Fucker Detected, likely honeypot/canary"
}
else
{
write-host $content -ForegroundColor Cyan
$detectcpass = $content | Select-String "cpassword="
if($detectcpass.LineNumber -ge 0){
write-host "POTENTIAL GPP PASSWORD DETECTED" -ForegroundColor Red
}

}

#close major file loop
}



