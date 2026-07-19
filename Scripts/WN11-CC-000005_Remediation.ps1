<#
.SYNOPSIS
    This PowerShell script enables "Prevent enabling lock screen camera" by disabling the lock screen camera.

.NOTES
    Author          : Gergely Szekeres
    LinkedIn        : linkedin.com/in/gergely-szekeres/
    GitHub          : github.com/SzGregG
    Date Created    : 2026-07-18
    Last Modified   : 2026-07-18
    Version         : 1.0
    STIG-ID         : WN11-CC-000005
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000005/

.TESTED ON
    Date(s) Tested  : 2026-07-18
    Tested By       : Gergely Szekeres
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.8875

.USAGE
    NOTE: If the device does not have a camera, this finding is Not Applicable (NA).
    Verify camera hardware presence before applying if you need strict NA handling.

    Example syntax:
    PS C:\> .\WN11-CC-000005_Remediation.ps1
#>

#Requires -RunAsAdministrator

$RegPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$ValueName = "NoLockScreenCamera"
$DesiredValue = 1

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

    # Set the value to 1 (Enabled - Prevent enabling lock screen camera)
    New-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -PropertyType DWord -Force | Out-Null

    # Verify
    $newValue = (Get-ItemProperty -Path $RegPath -Name $ValueName).$ValueName
    if ($newValue -eq $DesiredValue) {
        Write-Host "SUCCESS: '$ValueName' set to $DesiredValue (Prevent enabling lock screen camera: Enabled) at $RegPath" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Value did not apply as expected. Current value: $newValue" -ForegroundColor Red
    }
}
catch {
    Write-Host "ERROR: Failed to remediate WN11-CC-000005." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Force a Group Policy refresh so the change is reflected immediately
Write-Host "`nRunning gpupdate /force to refresh policy..." -ForegroundColor Yellow
gpupdate /force | Out-Null
Write-Host "Done." -ForegroundColor Green
