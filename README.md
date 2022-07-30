![Dotfiles Image](./dotfiles.png)

## Step 1 Install

#### Install Hack Nerd Font for terminal

[Dowload Hack Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip)

#### Update and upgrade

```
sudo apt update
sudo apt upgrade
```

#### Insatll zsh, make, tig, neofetch, tree and ripgrep

```
sudo apt install zsh make tig neofetch tree ripgrep
```

#### Set zsh as default shell

```
chsh -s $(which zsh)
```

#### Installing Node.js and npm from NodeSource

Download and execute the NodeSource installation script:

```
cd ~
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
```

View APT sources list for Nodesource Nodejs 16 repo

```
cat /etc/apt/sources.list.d/nodesource.list
```

Install Node.js and npm

```
sudo apt install nodejs
```

Verify the version of Node.js

```
node -v
```

#### Install fzf with Git

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Insatll lsd with dpkg

```
cd ~
wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
sudo dpkg -i lsd_0.23.1_amd64.deb
```

## Step 2 .dotfiles

#### Clone .dotfiles

```
cd ~
git clone https://github.com/HoNamDuong/.dotfiles.git
# Config git
git config --global credential.helper "store --file ~/.git-credentials"
```

#### Run install.sh

```
cd ~/.dotfiles
sh install.sh
```

#### Install [colorscript](./colorscript/README.md)

```
# Install
cd ~/.dotfiles/colorscript
sudo make install

# Removal
sudo make uninstall
```
