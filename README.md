## Step 1 Install

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
