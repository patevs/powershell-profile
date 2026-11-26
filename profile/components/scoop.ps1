# components/scoop.ps1
# --------------------

# Write-Output "components/scoop.ps1"

# Enable scoop completion in current shell.
# Use absolute path because PowerShell Core not respect $ENV:PSModulePath
try {
  # Import-Module scoop-completion
  Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion" # -ErrorAction Stop
} catch {
  Write-Output "Error Importing Scoop Completion Module" # -ForegroundColor DarkRed
}

# Hook for scoop-search
# . ([ScriptBlock]::Create((& scoop-search --hook | Out-String)))

# EOF #
