cls
$selection = Read-Host "`nThis script by default searches for W3SVC service, to continue with W3SVC select [Yes] | if you want to search for any other service select [No]"
$Servers_list = Get-Content -Path "C:\provide\you\servers_list\Servers.txt"

function services {
	Write-Host "Checking for W3SVC status"  
 
	foreach ($server in $Servers_list) {
		$W3SVC=Get-Service -ComputerName $server -Name W3SVC -ErrorAction SilentlyContinue

		if($W3SVC -ne $null -and $W3SVC.Status -eq "Running"){
			$status = $W3SVC.Status
			Write-Host "`n[$W3SVC] found [$status] on $Server" -ForegroundColor Yellow

			$Status_decision = Read-Host "`nWould you like to stop the service ? [Yes | No]"

			if($status_decision -eq "Yes"){
			$W3SVC | Stop-Service
			Set-Service -Name $W3SVC.name -ComputerName $Server -StartupType Disabled #setting it to "Disabled" means the service will not start automatically when the computer starts
			Write-Host "`n[$W3SVC] found [$status] on $Server" -ForegroundColor red
			}
		
			elseif($Status_decision -eq 'No'){
				$null
			}
			else {
			Write-Host "`nEnter a valid input."
			}
		}
		elseif($W3SVC -ne $null -and $W3SVC.status -eq 'Stopped'){
			$status = $W3SVC.status
			Write-Host "`n[$W3SVC] found [$status] on $Server" -ForegroundColor Yellow
		}
		else{
			Write-Host "`n[W3SVC] no found $Server" -ForegroundColor Red
		}
	}
}