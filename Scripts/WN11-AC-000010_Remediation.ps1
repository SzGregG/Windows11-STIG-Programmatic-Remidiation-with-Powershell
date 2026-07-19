<#
.SYNOPSIS
    This PowerShell script configures the Account lockout threshold to 3 invalid logon attempts.

.NOTES
    Author          : Gergely Szekeres
    LinkedIn        : linkedin.com/in/gergely-szekeres/
    GitHub          : github.com/SzGregG
    Date Created    : 2026-07-18
    Last Modified   : 2026-07-18
    Version         : 1.0
    STIG-ID         : WN11-AC-000010
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AC-000010/

.TESTED ON
    Date(s) Tested  : 2026-07-18
    Tested By       : Gergely Szekeres
    Systems Tested  : Windows 11
    PowerShell Ver. : 5.1.26100.8875

.USAGE
    Example syntax:
    PS C:\> .\WN11-AC-000010_Remediation.ps1
#>

#Requires -RunAsAdministrator

$DesiredThreshold = 3

try {
    # Get current value for reporting
    $currentSetting = net accounts | Select-String "Lockout threshold"
    Write-Host "Current setting: $currentSetting" -ForegroundColor Cyan

    # Set the account lockout threshold
    net accounts /lockoutthreshold:$DesiredThreshold | Out-Null

    # Verify
    $newSetting = net accounts | Select-String "Lockout threshold"
    Write-Host "New setting: $newSetting" -ForegroundColor Cyan

    if ($newSetting -match "\b$DesiredThreshold\b") {
        Write-Host "SUCCESS: Account lockout threshold set to $DesiredThreshold invalid logon attempts." -ForegroundColor Green
    } else {
        Write-Host "WARNING: Value did not apply as expected. Please verify manually with 'net accounts'." -ForegroundColor Red
    }
}
catch {
    Write-Host "ERROR: Failed to remediate WN11-AC-000010." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Force a Group Policy refresh so the change is reflected immediately
Write-Host "`nRunning gpupdate /force to refresh policy..." -ForegroundColor Yellow
gpupdate /force | Out-Null
Write-Host "Done." -ForegroundColor Green
