# ------------------ #
# components/git.ps1 #
# ------------------ #

# Write-Output "components/git.ps1"

if ((Get-Command git -ErrorAction SilentlyContinue) -and (Get-Module -ListAvailable Posh-Git -ErrorAction SilentlyContinue)) {
  Import-Module -Name posh-git

  # Posh-Git Configuration

  # Remove 'posh~git' prefix from terminal title
  # https://github.com/dahlbyk/posh-git/issues/424#issue-208094847
  # TODO: Ensure posh-git is installed
  $Global:GitPromptSettings.EnableWindowTitle = $true

  # Dracula Prompt Configuration
  # $GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
  # $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
  # $GitPromptSettings.DefaultPromptPath.ForegroundColor =[ConsoleColor]::Cyan
  # $GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
  # $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta
  # $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n > '
  # Dracula Git Status Configuration
  # $GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
  # $GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
  # $GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue
}

# EOF #
