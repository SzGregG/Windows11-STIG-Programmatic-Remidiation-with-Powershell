<#
.SYNOPSIS
    This PowerShell script disables Internet Explorer 11 as a standalone browser (option: Never).

.NOTES
    Author          : Gergely Szekeres
    LinkedIn        : linkedin.com/in/gergely-szekeres/
    GitHub          : github.com/SzGregG
    Date Created    : 2026-07-18
    Last Modified   : 2026-07-18
    Version         : 1.0
    STIG-ID         : WN11-CC-000391
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000391/

.TESTED ON
    Date(s) Tested  : 2026-07-18
    Tested By       : Gergely Szekeres
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.8875

.USAGE
    Example syntax:
    PS C:\> .\WN11-CC-000391_Remediation.ps1
#>

#Requires -RunAsAdministrator

$RegPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
$ValueName = "NotifyDisableIEOptions"
$DesiredValue = 0   # 0 = Never (IE11 disabled as standalone browser)

try {
    # Create the registry path if it doesn't exist
    if (-not (Test-Path $RegPath)) {
        Write-Host "Registry path not found. Creating: $RegPath" -ForegroundColor Yellow
        New-Item -Path $RegPath -Force | Out-Null
    }

    # Get current value (if any) for reporting
    $currentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

    if ($null -ne $currentValue) {
        Write-Host "Current value of '$ValueName': $currentValue" -ForegroundColor Cyan
    } else {
        Write-Host "'$ValueName' is not currently defined." -ForegroundColor Cyan
    }

    # Set the value to 0 (Never - Disable IE11 as a standalone browser)
    New-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -PropertyType DWord -Force | Out-Null

    # Verify
    $newValue = (Get-ItemProperty -Path $RegPath -Name $ValueName).$ValueName
    if ($newValue -eq $DesiredValue) {
        Write-Host "SUCCESS: '$ValueName' set to $DesiredValue (Disable IE11 as standalone browser: Enabled, option = Never) at $RegPath" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Value did not apply as expected. Current value: $newValue" -ForegroundColor Red
    }
}
catch {
    Write-Host "ERROR: Failed to remediate WN11-CC-000391." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Force a Group Policy refresh so the change is reflected immediately
Write-Host "`nRunning gpupdate /force to refresh policy..." -ForegroundColor Yellow
gpupdate /force | Out-Null
Write-Host "Done." -ForegroundColor Green
