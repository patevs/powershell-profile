# components/console.ps1
# ----------------------

# Write-Output "components/console.ps1"

# Utilities to manage PowerShell Consoles
# Based on code from ConCFG: https://github.com/lukesampson/concfg/

# Test if running as administrator
# http://serverfault.com/questions/95431
function Test-Elevated {
  # Get the ID and security principal of the current user account
  $userID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $userPrincipal = New-Object System.Security.Principal.WindowsPrincipal($userID)
  # Check to see if we are currently running "as Administrator"
  return $userPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# -----------------------------------------------------------------------------

# Import Terminal-Icons module (if installed) to show file and folder icons in the terminal.
if (Get-Module -ListAvailable Terminal-Icons -ErrorAction SilentlyContinue) {
  Import-Module -Name Terminal-Icons
}

# -----------------------------------------------------------------------------

# Enable tab completion for `bat`
# Invoke-Expression (& { (bat --completion ps1 | Out-String) })

# -----------------------------------------------------------------------------

# Enable tab completion for `gh`
# Invoke-Expression -Command $(gh completion -s powershell | Out-String)

# -----------------------------------------------------------------------------

# VS Code terminal shell integration
# https://code.visualstudio.com/docs/terminal/shell-integration
# if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }

# -----------------------------------------------------------------------------

# Produce UTF-8 by default
# https://news.ycombinator.com/item?id=12991690
# $PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

# Increase command history count
# https://technet.microsoft.com/en-us/magazine/hh241048.aspx
$MaximumHistoryCount = 10000;

# Start SSH agent redirecting output to null
# https://stackoverflow.com/a/6461021
# Start-SshAgent 2>&1 | Out-Null
# Start-SshAgent 2>&1> $null

# -----------------------------------------------------------------------------

# PSReadLine Configuration
# https://github.com/PowerShell/psreadline

# Import PSReadLine module (if installed) for Proper history, tab completion, etc
# if (Get-Module -ListAvailable PSReadLine -ErrorAction SilentlyContinue) {
#   Import-Module -Name PSReadLine
# }

# Show selection menu for tab
Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete
# Dracula readline configuration.
# Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
Set-PSReadlineOption -Color @{
  "Command" = [ConsoleColor]::Green
  "Parameter" = [ConsoleColor]::Gray
  "Operator" = [ConsoleColor]::Magenta
  "Variable" = [ConsoleColor]::White
  "String" = [ConsoleColor]::Yellow
  "Number" = [ConsoleColor]::Blue
  "Type" = [ConsoleColor]::Cyan
  "Comment" = [ConsoleColor]::DarkCyan
}

# -----------------------------------------------------------------------------

# Posh-Git Configuration
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt

# # Import Posh-Git module (if installed) to enable git tab completion.
# if (Get-Module -ListAvailable Posh-Git <# -ErrorAction SilentlyContinue #>) {
#   Import-Module -Name Posh-Git
# }

# Remove 'posh~git' prefix from terminal title
# https://github.com/dahlbyk/posh-git/issues/424#issue-208094847
# Note: This setting was removed in version 1.0 of posh-git
# $Global:GitPromptSettings.EnableWindowTitle = $true

# Dracula Prompt Configuration
# # $GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss") '
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

# Default posh-git window title:
# $GitPromptSettings.WindowTitle = {param($GitStatus, [bool]$IsAdmin) "$(if ($IsAdmin) {'Admin: '})$(if ($GitStatus) {"$($GitStatus.RepoName) [$($GitStatus.Branch)]"} else {Get-PromptPath}) - PowerShell $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor) $(if ([IntPtr]::Size -eq 4) {'32-bit '})($PID)"}
# Don't have posh-git update the window title
$GitPromptSettings.WindowTitle = $null

# Start prompt on a new line
# $GitPromptSettings.DefaultPromptPrefix.Text = "`n" # New line
$GitPromptSettings.DefaultPromptPrefix.Text = "`n$(if (Test-Elevated) {'[ADMIN] '})"
# $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::DarkCyan
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Magenta
# Make the posh-git default prompt span two lines
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = ' : `n' # ' : `n > '
# Prepend the date and time before the prompt character >
# $GitPromptSettings.DefaultPromptBeforeSuffix.Text = ' : `n$([DateTime]::now.ToString("MM-dd HH:mm:ss"))'
$GitPromptSettings.DefaultPromptBeforeSuffix.ForegroundColor = [ConsoleColor]::DarkGray
# $GitPromptSettings.DefaultPromptSuffix.Text = '$(">" * ($nestedPromptLevel + 1)) ' # Default
# $GitPromptSettings.DefaultPromptSuffix = '$((Get-History -Count 1).id + 1)$(">" * ($nestedPromptLevel + 1)) '
# Make any path under home directory abbreviated with ~
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
# If prompt timing enabled, write elapsed milliseconds
# $GitPromptSettings.DefaultPromptEnableTiming = $true

# If you want to display the error status of the last command, you can use the values stored
# in the `$global:GitPromptValues` object which includes the value of `$LastExitCode` and `$?`
# (represented by the property `DollarQuestion`).
# Here is a prompt customization that displays a Red exit code value when
# `$LastExitCode` is non-zero or a Red `!` if `$?` is `$false`:
# function global:PromptWriteErrorInfo() {
#     if ($global:GitPromptValues.DollarQuestion) { return }
#     # In Windows PowerShell 5.1, the `e escape character
#     # (introduced in PowerShell 7) is not recognized.
#     # Use $([char]27) instead to embed the ESC character.
#     $ESC = [char]27
#     if ($global:GitPromptValues.LastExitCode) {
#         # "`e[31m(" + $global:GitPromptValues.LastExitCode + ") `e[0m"
#         "${ESC}[31m(" + $global:GitPromptValues.LastExitCode + ") ${ESC}[0m"
#     }
#     else {
#         # "`e[31m! `e[0m"
#         "${ESC}[31m! ${ESC}[0m"
#     }
# }
# $global:GitPromptSettings.DefaultPromptBeforeSuffix.Text =
#   ' : `n$(PromptWriteErrorInfo)$([DateTime]::now.ToString("MM-dd HH:mm:ss"))'

# -----------------------------------------------------------------------------

# --------------------------- #
# Customize PowerShell Prompt #
# --------------------------- #

# PowerShell allows you to customize your prompt to show whatever information you want.
# In PowerShell, the "prompt" text is provided by a function named prompt.
# PowerShell provides you with a default prompt function that is defined as:
# function prompt {
#     "PS $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
# }

# $wakatime = $(which wakatime);

# Must be called 'prompt' to be used by pwsh
# https://github.com/gummesson/kapow/blob/master/themes/bashlet.ps1
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
function prompt {
  # Write new line
  Write-Host
  $origLastExitCode = $LastExitCode

  # Test if running as admin
  if (Test-Elevated) {
    # if elevated
    Write-Host "[ADMIN] " -NoNewline -ForegroundColor White
  }

  # Build current path
  $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
  if ($curPath.ToLower().StartsWith($Home.ToLower())) {
    $curPath = "~" + $curPath.SubString($Home.Length)
  }

  # Write current path
  Write-Host $curPath -NoNewline -ForegroundColor Magenta
  Write-Host " :" -NoNewline -ForegroundColor DarkGray

  # Write posh-git status
  # Write-VcsStatus
  # "`n$('>' * ($nestedPromptLevel + 1)) "

  # Wakatime Heartbeat
  # https://github.com/wakatime/wakatime/issues/126#issuecomment-442892264
  <#
  if($wakatime) {
    wakatime --entity-type app --project Powershell;
  }
  return "=]"
  #>

  # Have posh-git display its default prompt
  # & $GitPromptScriptBlock

  # $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n$([DateTime]::now.ToString("MM-dd HH:mm:ss"))'
  # $GitPromptSettings.DefaultPromptBeforeSuffix.ForegroundColor = 0x808080
  # $GitPromptSettings.DefaultPromptSuffix = ' $((Get-History -Count 1).id + 1)$(">" * ($nestedPromptLevel + 1)) '

  $prompt = ""
  # $prompt = Write-Prompt "Text before posh-git prompt " -ForegroundColor ([ConsoleColor]::Green)
  # $prompt += Write-Prompt "$($ExecutionContext.SessionState.Path.CurrentLocation)" -ForegroundColor Cyan
  $prompt += Write-VcsStatus
  # $prompt += Write-Prompt "Text after posh-git prompt" -ForegroundColor ([ConsoleColor]::Magenta)
  # $prompt += Write-Prompt "$(if ($PsDebugContext) {' [DBG]: '} else {''})" -ForegroundColor Magenta
  $prompt += "`n$('>' * ($nestedPromptLevel + 1)) "

  $LASTEXITCODE = $origLastExitCode
  if ($prompt) { "$prompt" } else { " " }
}

# --------------------------------------------------------------------------------------------- #

<#
# Print a welcome message
function Print-Welcome {
  # Write-Host
  $msg = "             _    _ _____ _     _____ ________  ___ _____
            | |  | |  ___| |   /  __ \  _  |  \/  ||  ___|
            | |  | | |__ | |   | /  \/ | | | .  . || |__
            | |/\| |  __|| |   | |   | | | | |\/| ||  __|
            \  /\  / |___| |___| \__/\ \_/ / |  | || |___
             \/  \/\____/\_____/\____/\___/\_|  |_/\____/

                      ________ _______ ________
                      ___  __ \___    |___  __/
                      __  /_/ /__  /| |__  /
                      _  ____/ _  ___ |_  /
                      /_/      /_/  |_|/_/
  "
  Write-Host $msg -ForegroundColor Green
}
Print-Welcome
#>

# EOF #
