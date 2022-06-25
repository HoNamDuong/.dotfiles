## Step 1 Install
### Update and upgrade
~~~bash
sudo apt update
sudo apt upgrade
~~~
### Insatll ZSH, tree and ripgrep
~~~bash
sudo apt install zsh tree ripgrep
~~~
Set ZSH as default shell
~~~bash
chsh -s $(which zsh)
~~~
or open /etc/passwd:
~~~bash
sudo vi /etc/passwd
~~~
find the line with your username and  replace bash with zsh:
~~~bash
username:x:1000:1000:,,,:/home/username:/usr/bin/zsh
~~~
### Install fzf with Git
~~~bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
~~~

## Step 2 .dotfiles
Clone .dotfiles
~~~bash
cd ~
git clone https://github.com/HoNamDuong/.dotfiles.git
~~~
Run install.sh
~~~bash
cd .dotfiles
sh install.sh
~~~


