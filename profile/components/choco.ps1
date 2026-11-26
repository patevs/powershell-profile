# components/choco.ps1
# --------------------

# Write-Output "components/choco.ps1"

# Import the Chocolatey Profile that contains the necessary
# code to enable tab-completions to function for `choco`.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$ENV:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile" # -Force
}

# EOF #
