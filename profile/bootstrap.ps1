# bootstrap.ps1
# -------------

# Core   C:\Users\xxx\Documents\PowerShell
# Legacy C:\Users\xxx\Documents\WindowsPowerShell

# TODO: Check current powershell version
# Check PowerShell version
# if (($PSVersionTable.PSVersion.Major) -lt 5) {
#   Write-Output 'PowerShell 5 or later is required.' -ForegroundColor DarkRed
#   Write-Output 'Go to https://microsoft.com/powershell to get the latest version of PowerShell.' -ForegroundColor DarkRed
#   exit 1
# }

$profileDir = Split-Path -parent $profile
$componentDir = Join-Path $profileDir "components"

New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue
New-Item $componentDir -ItemType Directory -Force -ErrorAction SilentlyContinue

# ? TODO: Exclude windows.ps1
Copy-Item -Path ./*.ps1 -Destination $profileDir -Exclude "bootstrap.ps1"
Copy-Item -Path ./components/** -Destination $componentDir -Include **

Remove-Variable componentDir
Remove-Variable profileDir

# Open a New Shell
# Invoke-Expression "powershell -NoLogo"
Invoke-Expression "Pop-Location; pwsh"

exit

# EOF #
