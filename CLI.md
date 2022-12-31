### Update and upgrade

```bash
sudo pacman -Syu
```

### Install packages

```bash
# Install zsh and ...
sudo pacman -Sy zsh git tmux tig wget neofetch tree ripgrep fzf fd lsd ranger
# Set zsh as default shell
chsh -s $(which zsh)
```

### Clone .dotfiles and setup

```bash
# Clone .dotfiles
cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git
# Config git credential
git config --global credential.helper "store --file ~/.git-credentials"
git config --global user.email "example@domain.com"
git config --global user.name "username"

# Run install.sh
cd ~/.dotfiles
sh install.sh
```

### Installing Node.js, npm and yarn

```bash
# Install Node.js and npm
sudo pacman -Sy nodejs
# Install yarn
sudo npm install --global yarn

# Verify the version of Node.js , npm and yarn
node -v
npm -v
yarn -v
```

### Install Neovim

```bash
# 4. Install Neovim
sudo pacman -Sy neovim

# Check version of Neovim
nvim -v

# Deployment and management system for Lua modules
sudo pacman -Sy luarocks
```

### Install [colorscript](./colorscript/README.md)

```bash
# Install
cd ~/.dotfiles/colorscript
sudo make install

# Removal
sudo make uninstall
```
