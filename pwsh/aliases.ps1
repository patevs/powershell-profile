# aliases.ps1
# -----------

# Write-Output "aliases.ps1"

# Navigation Aliases
# ==================

# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Navigation Shortcuts
${function:bin} = { Set-Location C:\bin }
${function:dev} = { Set-Location ~\code }
${function:doc} = { Set-Location ~\Documents }
${function:dl} = { Set-Location ~\Downloads }
${function:dt} = { Set-Location ~\Desktop }
${function:wk} = { Set-Location ~\work }

Set-Alias -Name desk -Value dt
Set-Alias -Name desktop -Value dt

Set-Alias -Name wrk -Value wk
Set-Alias -Name work -Value wk

# Oddly, Powershell doesn't have an inbuilt variable for the documents directory. So let's make one:
# From: https://stackoverflow.com/a/12949659
# $env:DOCUMENTS = [Environment]::GetFolderPath("mydocuments")

# ------------------------------------------------------------------------------------------------------- #

# PowerShell Utility Aliases
# ==========================

# Clear and reload the console
${function:cls} = { Reset-Console }

# Reload the shell
Set-Alias -Name reload -Value Invoke-Powershell

# Get current PowerShell version
${function:version} = { Get-Version }

# Get installed PowerShell modules
${function:modules} = { Get-Module -ListAvailable }

# ------------------------------------------------------------------------------------------------------- #

# System Utility Aliases
# ======================

# System Information
${function:neofetch} = { bash C:\bin\neofetch\neofetch }

# Shutdown System
${function:shutdown} = { Stop-Computer -ComputerName localhost }
Set-Alias -Name shut -Value shutdown
Set-Alias -Name sd -Value shutdown

# Restart System
${function:restart} = { Restart-Computer }
Set-Alias -Name reboot -Value restart
Set-Alias -Name rb -Value restart
Set-Alias -Name rs -Value restart

# Logout current user
${function:logout} = { logoff }
Set-Alias -Name lo -Value logout

# Create a new directory and enter it
Set-Alias -Name mkd -Value CreateAndSetDirectory

# Open a given file
Set-Alias -Name o -Value open

# Remove a given item
Set-Alias -Name del -Value RemoveItem -option AllScope -Force

# Send an item to the Recycle Bin
Set-Alias -Name trash -Value Remove-ItemSafely

# Empty the Recycle Bin on all drives
Set-Alias -Name emptytrash -Value EmptyRecycleBin

# Cleanup old files all drives
Set-Alias -Name cleandisks -Value CleanDisks

# Update installed Ruby Gems, NPM, and their installed packages.
# Set-Alias -Name update -Value SystemUpdate

# In PowerShell, `where` is an alias of `Where-Object` command, so use `where.exe` instead
Set-Alias -Name wh -Value where.exe

# Set neovim as default vim
Set-Alias -Name vim -Value nvim

# Ensure `thefuck` is installed
if (which thefuck){
  # Correct the previous command using `thefuck`
  $env:PYTHONIOENCODING="utf-8"
  Invoke-Expression "$(thefuck --alias)"
  # Unset PYTHONIOENCODING environment variable
  Remove-Item env:PYTHONIOENCODING
}

# ------------------------------------------------------------------------------------------------------- #

# Unix-like Aliases
# =================

# Git-bash shell
Set-Alias -Name bash -Value "C:\Program Files\Git\bin\bash.exe"

# Directory Listing: Use `lsd.exe` if available
if (which lsd) {
  # List directory contents in short format
  ${function:l} = { Write-Host ""; lsd --color always --icon always @args }
  # List directory contents
  ${function:ll} = { Write-Host ""; lsd -A1 --color always --icon always @args }
  # List directory contents in long format
  ${function:lll} = { Write-Host ""; lsd -al --color always --icon always @args }
  # List directory tree
  ${function:lst} = { Write-Host ""; lsd --tree --color always --icon always --ignore-glob "node_modules"  @args }
} else {
  ${function:l} = { Get-ChildItem }
  ${function:ll} = { Get-ChildItem | Format-Wide }
  ${function:lll} = { Get-ChildItem | Format-List }
  ${function:lst} = { tree }
}
Set-Alias -Name ls -Value ll -option AllScope -Force

# Favour ripgrep over grep if installed
if (Get-Command rg -ErrorAction SilentlyContinue) { Set-Alias -Name grep -Value rg }

# Measure the time taken for a command to execute
Set-Alias -Name time -Value Measure-Command

# --------------------------------------------------------------------------------------------- #

# Git & GitHub Aliases
# ====================

# Print Git status
${function:gs} = { Get-GitStatus }

# Git clone and cd
Set-Alias -Name gcd -Value Invoke-GitClone

# ls with git status
${function:lsg} = { Write-Host ""; bash C:\bin\ls-with-git-status\lsg @args }
# Set-Alias -Name ls -Value lsg -option AllScope -Force

# Git branch status
${function:gbs} = { Write-Host ""; bash C:\bin\git-branch-status\git-branch-status @args }

# Git Multi Status
${function:mgs} = { bash C:\bin\multi-git-status\mgitstatus --depth=0 @args }

# Favour GitHub's hub client over vanilla git
if (Get-Command hub -ErrorAction SilentlyContinue) { Set-Alias -Name git -Value hub }

# --------------------------------------------------------------------------------------------- #

# Scoop Aliases
# =============

# Check `scoop-search` is installed
if ([String] $(which scoop-search).length -gt 0){
  # Alias `scoop-search` to `scoop search`
  Invoke-Expression (&scoop-search --hook)
}

${function:ss} = { scoop search @args }

# EOF #
