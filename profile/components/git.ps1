# components/git.ps1
# ------------------

# Write-Output "components/git.ps1"

# Import Posh-Git module (if installed) to enable git tab completion.
if ((Get-Command git -ErrorAction SilentlyContinue) -and (Get-Module -ListAvailable Posh-Git -ErrorAction SilentlyContinue)) {
  Import-Module -Name posh-git
}

# EOF #
