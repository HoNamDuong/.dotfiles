### Update and upgrade

```bash
sudo apt update
sudo apt upgrade
```

### Install packages

```bash
# Install zsh and ...
sudo apt install zsh make tig neofetch tree ripgrep
# Set zsh as default shell
chsh -s $(which zsh)
```

### Clone .dotfiles and setup

```bash
# Clone .dotfiles
cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git
# Config git credential
git config --global credential.helper "store --file ~/.git-credentials"

# Run install.sh
cd ~/.dotfiles
sh install.sh
```

### Installing Node.js and npm from [NodeSource](https://github.com/nodesource/distributions)

```bash
# Download and execute the NodeSource installation script:
cd ~ && curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
# View APT sources list for NodeSource Nodejs 16 repo
cat /etc/apt/sources.list.d/nodesource.list
# Install Node.js and npm
sudo apt install nodejs
# Install yarn
sudo npm install --global yarn

# Verify the version of Node.js , npm and yarn
node -v
npm -v
yarn -v
```

### Install Neovim with [Building Neovim](https://github.com/neovim/neovim/wiki/Building-Neovim)

```bash
# 1. Install build prerequisites on your system
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
# 2. Clone neovim
git clone https://github.com/neovim/neovim
# 3. Set build type determines
cd neovim
make distclean && make CMAKE_BUILD_TYPE=Release
# 4. Install Neovim
git checkout v0.8.0
sudo make install

# Check version of Neovim
nvim -v
```

```bash
# Install dependencies for Neovim
sudo npm install --global neovim tree-sitter-cli
```

Uninstall Neovim

```bash
# To uninstall after make install, just delete the CMAKE_INSTALL_PREFIX artifacts
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```

### Install [fzf](https://github.com/junegunn/fzf) with Git

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Install [lsd](https://github.com/Peltoche/lsd) with dpkg

```bash
cd ~ && wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
sudo dpkg -i lsd_0.23.1_amd64.deb
```

### Install [fd](https://github.com/sharkdp/fd) with dpkg

```bash
cd ~ && wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd_8.4.0_amd64.deb
sudo dpkg -i fd_8.4.0_amd64.deb
```

### Install [colorscript](./colorscript/README.md)

```bash
# Install
cd ~/.dotfiles/colorscript
sudo make install

# Removal
sudo make uninstall
```
