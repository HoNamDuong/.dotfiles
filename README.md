![Dotfiles Image](./dotfiles.png)

## Step 1 Install

#### Install Hack Nerd Font for terminal

[Dowload Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip)

#### Update and upgrade

```bash
sudo apt update
sudo apt upgrade
```

#### Insatll zsh, neofetch, tree and ripgrep

```bash
sudo apt install zsh neofetch tree ripgrep
```

#### Set zsh as default shell

```bash
chsh -s $(which zsh)
```

#### Install fzf with Git

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Insatll lsd with dpkg

```bash
cd ~
wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_amd64.deb
sudo dpkg -i lsd_0.22.0_amd64.deb
```

## Step 2 .dotfiles

#### Clone .dotfiles

```bash
cd ~
git clone https://github.com/HoNamDuong/.dotfiles.git
```

#### Run install.sh

```bash
cd ~/.dotfiles
sh install.sh
```
