# bootstrap.ps1
# -------------

# TODO: Check current powershell version

# Core   C:\Users\xxx\Documents\PowerShell
# Legacy C:\Users\xxx\Documents\WindowsPowerShell

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
