# My Dotfiles

![meme](meme.jpg)
---
This repo includes my configs for:
- ZSH
- Kitty
- Alacritty
- NeoVim

## How to install
My dotfiles are managed with **chezmoi**, so you just run one command to install chezmoi and apply my dotfiles

`sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply MicahBird`

## Installing Programs
Included with my dotfiles is a ansible playbook that installs some packages and downloads lf, k9s, and onefetch to your .local/bin/

After installing Ansible, run the ansible playbook with the following commands:
```
cd .setup/
ansible-playbook -K setup.yml
```
