cls

Write-Host "`nListing Disk Spaces..." -ForegroundColor Yellow

$Servers = Get-content -Path "C:\provide\servers_list\location\Servers.txt"

foreach($Server in $Servers){

	Write-Host "`nChecking disk space on $Server"

	Invoke-Command -ComputerName $Server -ScriptBlock { 
		If ((Get-Volume C).SizeRemaining/1gb -ge 20){

			Write-Host "C Drive has enough free space:" -ForegroundColor Green ((Get-Volume C).SizeRemaining/1gb) GB
		}
		else{

			Write-Host "C drive does not have enough free space:" -ForegroundColor Red ((Get-Volume C).SizeRemaining/1gb) GB
		}
	}	
}

Read-Host -Prompt "`nHit Enter to exit"

