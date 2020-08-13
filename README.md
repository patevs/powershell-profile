# PowerShell Profile

> PatEvs' `PowerShell` profile.

---

## Installation and Usage Instructions

### Using Git and the bootstrap scripts

Clone the repository:

```powershell
git clone https://github.com/patevs/powershell-profile.git
cd powershell-profile
```

Install `PowerShell` profile:

```powershell
cd pwsh
.\bootstrap.ps1
```

### Git-free install

> **Note:** You must have your execution policy set to unrestricted (or at least in bypass) for this to work. To set this, run `Set-ExecutionPolicy Unrestricted` from a PowerShell running as Administrator.

To install these dotfiles from PowerShell without Git:

```powershell
iex ((new-object net.webclient).DownloadString('https://raw.github.com/patevs/powershell-profile/master/setup/install.ps1'))
```

To update later on, just run that command again.

---

## Sensible Windows Defaults

When setting up a new Windows PC, you may want to set some Windows defaults and features, such as showing hidden files in Windows Explorer and installing IIS. This will also set your machine name and full user name, so you may want to modify this file before executing.

```post
cd pwsh
.\windows.ps1
```

---

## Project Structure

```md
.
├── pwsh
│   ├── bootstrap.ps1
│   ├── Microsoft.PowerShell_profile.ps1
│   └── windows.ps1
├── setup
│   └── install.ps1
├── .commitlintrc.json
├── .editorconfig
├── .gitignore
├── .huskyrc
├── .np-config.json
├── LICENSE
├── package.json
└── README.md
```

---
