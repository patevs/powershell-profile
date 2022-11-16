# PowerShell Profile

> PatEvs' `PowerShell` 5.x and `pwsh` 7.x profile.

---

## Installation and Usage Instructions

### Using Git and the bootstrap script

```sh
# Clone the repository
git clone https://github.com/patevs/powershell-profile.git
cd powershell-profile
# Install the profile:
.\bootstrap.ps1
```

### Git-free install

> **Note:** You must have your execution policy set to unrestricted (or at least in bypass) for this to work. To set this, run `Set-ExecutionPolicy Unrestricted` from a PowerShell running as Administrator.

To install these dotfiles from `PowerShell` without Git:

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

## Links & Resources

* **[`jayharris/dotfiles-windows`](https://github.com/jayharris/dotfiles-windows)**

[](.)

* [`mikemaccana/powershell-profile`](https://github.com/mikemaccana/powershell-profile)
* [`felixriesebery/windows-development-environment`](https://github.com/felixrieseberg/windows-development-environment)

[](.)

* [`oh-my-posh`](https://github.com/JanDeDobbeleer/oh-my-posh) A prompt theme engine for any shell.
* [PowerShell Prompts](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts?view=powershell-7)

---

## Project Structure

```md
.
├── .husky              # Husky configuration
├── pwsh                # PowerShell profile
├── setup
│   └── install.ps1     # Git-free install script
├── .commitlintrc       # Commitlint configuration
├── .editorconfig       # Editor configuration
├── .gitignore          # Git ignore rules
├── .np-config.json     # NPM publish (np) configuration
├── LICENSE             # Project license
├── package.json        # NPM package configuration
├── bootstrap.ps1       # Installation script
└── README.md           # Project README
```

---
