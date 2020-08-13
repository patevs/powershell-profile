# ----------------- #
# setup/install.ps1 #
# ----------------- #

# TODO: Check OS type and ensure running on windows

$account = "patevs"
$repo    = "powershell-profile"
$branch  = "master"

$pwshProfileTempDir = Join-Path $env:TEMP "powershell-profile"
if (![System.IO.Directory]::Exists($pwshProfileTempDir)) {[System.IO.Directory]::CreateDirectory($pwshProfileTempDir)}
$sourceFile = Join-Path $pwshProfileTempDir "powershell-profile.zip"
$pwshProfileInstallDir = Join-Path $pwshProfileTempDir "$repo-$branch"


function Download-File {
    param (
        [string]$url,
        [string]$file
    )
    Write-Host "Downloading $url to $file"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $url -OutFile $file
}

function Unzip-File {
    param (
        [string]$File,
        [string]$Destination = (Get-Location).Path
    )

    $filePath = Resolve-Path $File
    $destinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)

    If (($PSVersionTable.PSVersion.Major -ge 3) -and
        (
            [version](Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue).Version -ge [version]"4.5" -or
            [version](Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Client" -ErrorAction SilentlyContinue).Version -ge [version]"4.5"
        )) {
        try {
            [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
            [System.IO.Compression.ZipFile]::ExtractToDirectory("$filePath", "$destinationPath")
        } catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    } else {
        try {
            $shell = New-Object -ComObject Shell.Application
            $shell.Namespace($destinationPath).copyhere(($shell.NameSpace($filePath)).items())
        } catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    }
}

Download-File "https://github.com/$account/$repo/archive/$branch.zip" $sourceFile
if ([System.IO.Directory]::Exists($pwshProfileInstallDir)) {[System.IO.Directory]::Delete($pwshProfileInstallDir, $true)}
Unzip-File $sourceFile $dotfilesTempDir

Push-Location "$pwshProfileInstallDir\pwsh"
& .\bootstrap.ps1
Pop-Location

$newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
$newProcess.Arguments = "-nologo";
[System.Diagnostics.Process]::Start($newProcess);
exit

# EOF #
