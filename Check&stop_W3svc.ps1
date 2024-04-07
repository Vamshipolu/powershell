cls
$selection = Read-Host "`nThis script by default searches for W3SVC service, to continue with W3SVC select [Yes] | if you want to search for any other service select [No]"

$W3SVC = Get-Service -ComputerName IIS-Test1 -Name W3SVC -ErrorAction SilentlyContinue

if ($W3SVC -ne $null -and $W3SVC.Status -eq "Running") {
    $status = $W3SVC.Status
    Write-Host "`n[$W3SVC] found [$status] on IIS-Test1" -ForegroundColor Yellow

    $Status_decision = Read-Host "`nWould you like to stop the service ? [Yes | No]"

    if ($Status_decision -eq "Yes") {
        $W3SVC | Stop-Service
        #Set-Service -Name $W3SVC.name -ComputerName IIS-Test1 -StartupType Disabled #setting it to "Disabled" means the service will not start automatically when the computer starts
        Write-Host "`n[$W3SVC] found [$status] on IIS-Test1" -ForegroundColor red
    }
    elseif ($Status_decision -eq 'No') {
        $null
    }
    else {
        Write-Host "`nEnter a valid input."
    }
}
elseif ($W3SVC -ne $null -and $W3SVC.status -eq 'Stopped') {
    $status = $W3SVC.status
    Write-Host "`n[$W3SVC] found [$status] on IIS-Test1" -ForegroundColor Yellow
}
else {
    Write-Host "`n[W3SVC] not found on IIS-Test1" -ForegroundColor Red
}
