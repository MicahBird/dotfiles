# My Dotfiles

![meme](assets/images/meme.jpg)
---
This repo includes my configs for:
- zsh
- Kitty
- Neovim
- Sway
- Alacritty
- lf
- cmus

### Custom Functions/Aliases

#### lfcd
Pressing `CTRL + O` in a zsh session launches lf and changes directories . Look at `lfcd()`in `~/.config/zsh/custom.zsh` for more details

#### wvim
A Neovim config that is built for writing:
Notable features: 
 - `CTRL + S`: Replaces the highlighted word with the first spelling suggestion
 - `zs`: Provides a synonym suggestions menu courtesy of [ron89/thesaurus_query.vim](https://github.com/ron89/thesaurus_query.vim)
![wvim demo gif](assets/images/wvim.gif)

#### mvim
A minimal neovim configuration with bare essentials and sensible defaults.

#### gvim
An alias to quickly launch git fugitive in the current directory

## Installing My Dotfiles
My dotfiles are managed with **chezmoi**, so you just run one command to install chezmoi and apply my dotfiles:

`sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin -- init --apply MicahBird`

## Using the Setup Playbook (UNIX Systems)
Included with my dotfiles is a ansible playbook that installs some packages and downloads lf, k9s, and onefetch to your .local/bin/

After installing Ansible, run the ansible playbook with the following commands:
```
cd .setup/
ansible-playbook -K setup.yml
```

## Running the Setup Playbook (Windows Systems)
_The windows setup playbook currently doesn't set up a development environment, it just installs programs that I install with a fresh install._

To run the Windows setup playbook, WinRM must be enabled. To enable it, open a Administrator Powershell and run the following commands to enable WinRM with HTTPS, using a self-signed certificate.

```
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file
```

### Writing the Hosts File
Before running the playbook, you need to replace the IP address, user, and password in the `windows-hosts.ini` to suit your setup.

### Running the Playbook
To run the Windows setup playbook, run the following command:

`ansible-playbook -i windows-hosts.ini windows-setup.yml`

#### Disabling WinRM
To disable WinRM after running the playbook, run the following commands in an Administrator Powershell. 
```
Stop-Service winrm
Set-Service -Name winrm -StartupType Disabled
winrm delete winrm/config/Listener?Address=*+Transport=HTTP
winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
```

## Credits

Thanks to [charmbracelet/vhs](https://github.com/charmbracelet/vhs) for VHS to create the GIFs on this README!
