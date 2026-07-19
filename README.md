# STIG Remidiation Project
As part of this project I have run an audit scan on a Windows 11 Virtual Machine. The audit was based on the Security Technical Implementation Guides (STIGs) standard set out by the US Department of Defense's Defense Information System Agency (DISA). From the audit findings I selected 10 failed STIG findings and set out to remedy them using Powershell scripts. Using these scripts would enable a faster and streamlined way of setting multiple machines to standards in a production environment instead of clicking through manually multiple user interfaces.

[Initial Scan](Scans/GSZ-STIG-SCAN_INITIAL.pdf)  
  
## STIG Remidiation Index Table
In this table you can find each STIG ID I chose to remedy. The Powershell script used for remediation. The scans after each specific remediation has been implemented. Finally relevant accompaning screenshots of when it showed, failed, passed, and output after each script.  

| STIG ID | Remediation Powershell Script | Scan | Pass/Fail/Remediation |
| --- | --- | --- | --- |
| WN11-CC-000315 | [Powershell Script](Scripts/WN11-CC-000315_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000315_Remediation.pdf)
| WN11-CC-000110 | [Powershell Script](Scripts/WN11-CC-000110_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000110_Remediation.pdf)
| WN11-CC-000197 | [Powershell Script](Scripts/WN11-CC-000197_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000197_Remediation.pdf)
| WN11-CC-000005 | [Powershell Script](Scripts/WN11-CC-000005_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000005_Remediation.pdf)
| WN11-CC-000310 | [Powershell Script](Scripts/WN11-CC-000310_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000310_Remediation.pdf)
| WN11-CC-000252 | [Powershell Script](Scripts/WN11-CC-000252_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN10-CC-000252_Remediation.pdf)
| WN11-CC-000327 | [Powershell Script](Scripts/WN11-CC-000327_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000327_Remediation.pdf)
| WN11-AC-000010 | [Powershell Script](Scripts/WN11-AC-000010_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000327_Remediation.pdf)
| WN11-CC-000391 | [Powershell Script](Scripts/WN11-CC-000391_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000391_Remediation.pdf)
| WN11-CC-000150 | [Powershell Script](Scripts/WN11-CC-000150_Remediation.ps1) | [Scan](Scans/GSZ-STIG-SCAN_WN11-CC-000150_Remediation.pdf)
