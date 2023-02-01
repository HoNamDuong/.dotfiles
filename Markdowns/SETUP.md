### Update and upgrade

    sudo pacman -Syu

    sudo timedatectl set-ntp
    timedatectl status

### Optional add nice color to pacman output

The final touch is to add some color to the package manager

    grep "Color" /etc/pacman.conf && \
    sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf && \
    grep "Color" /etc/pacman.conf

### Installing YAY

    mkdir Downloads && \
    cd Downloads && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si && \
    yay --editmenu --nodiffmenu --save

### Installing Xorg packages, i3 and video drivers

Note: your video card may be different and you may need to install different video drivers, please consult Archlinux Wiki for correct video drivers installation

Find your video card

    lspci | grep -e VGA -e 3D

The first step is to disable Intel Integrated Graphics Controller

    echo "install i915 /bin/false" | sudo tee --append /etc/modprobe.d/blacklist.conf && \
    cat /etc/modprobe.d/blacklist.conf

    sudo pacman -S nvidia nvidia-settings xorg-server xorg-apps xorg-xinit --noconfirm --needed
    sudo pacman -S vulkan-icd-loader
    sudo mkinitcpio -P

Note: Nvidia non open source drivers may conflict with nouveau OS drivers and in below case to make drivers work I needed to blacklist nouveau drivers

    cat /usr/lib/modprobe.d/nvidia.conf
    blacklist nouveau

Install i3

    sudo pacman -S i3 perl-anyevent-i3 alacritty --noconfirm --needed

### Install packages

    # Install rofi, lxappearance ...
    sudo pacman -S rofi dunst picom lxappearance dmenu conky ranger vlc numlockx feh
    sudo pacman -S neofetch w3m imagemagick nitrogen
    sudo pacman -S zsh tig tree ripgrep fzf fd lsd ranger

    # Set zsh as default shell
    chsh -s $(which zsh)

### Install font

    sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    sudo pacman -S ttf-hack-nerd

### Keyring, polkit and screenshot

    sudo pacman -S gnome-keyring polkit-gnome gnome-screenshot

### File manager

    sudo pacman -S nemo nemo-fileroller ntfs-3g

Change the default terminal emulator for Nemo

    gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

    gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg -e

### Creating default directories

    sudo pacman -S xdg-user-dirs

    xdg-user-dirs-update

### Installing Node.js, npm and yarn

    # Install Node.js and npm
    sudo pacman -S nodejs npm

    # Install yarn
    sudo npm install --global yarn

    # Verify the version of Node.js , npm and yarn
    node -v
    npm -v
    yarn -v

### Install Neovim

    # Deployment and management system for Lua modules
    sudo pacman -S luarocks

    # Install Neovim
    sudo pacman -S neovim

    # Install yarn
    sudo npm install --global neovim

    # Check version of Neovim
    nvim -v

### Install theme, icon and cursor

[Skeuos theme](https://aur.archlinux.org/packages/skeuos-gtk)

[Papirus icon theme](https://archlinux.org/packages/community/any/papirus-icon-theme)

[Vimix cursors](https://aur.archlinux.org/packages/vimix-cursors)

    yay -S skeuos-gtk papirus-icon-theme vimix-cursors

### Installing sound drivers and tools

    sudo pacman -S alsa-utils alsa-plugins alsa-lib pavucontrol pipewire pipewire-pulse --noconfirm --needed
    systemctl --user enable pipewire.service
    systemctl --user enable pipewire-pulse.service

### Install Display manager and config

I am using lightdm as is very light and fast display manager but you can install any other Display Manager you are familiar with. Ex. GDM, LXDM, XDM etc.

    sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed

Change file lightdm.conf

    grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#autologin-user=/autologin-user=$USER/g' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#autologin-session=/autologin-session=i3/g' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
    grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf

Change theme and background color in file:

    /etc/lightdm/lightdm-gtk-greeter.conf

    # Copy config for lightdm-gtk-greeter
    sudo cp .dotfiles/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/

Start lightdm

    sudo systemctl enable lightdm && \
    sudo systemctl start lightdm

### Run

Log out of your system and log in again. While logging in, be sure to select i3 session as your login screen.

### Clone .dotfiles and setup

    # Clone .dotfiles
    cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git
    # Config git credential
    mkdir -p .config/git
    git config --global credential.helper "store --file ~/.config/git/.git-credentials"
    git config --global user.email "example@domain.com"
    git config --global user.name "username"

    # Run install.sh
    cd ~/.dotfiles
    sh install.sh

### Installing applications (Optional)

    sudo pacman -S discord spotify-launcher telegram-desktop

Few more optional tools that are recommended we can find in AUR

    yay -S google-chrome visual-studio-code-bin cava

Install [iBus](https://github.com/BambooEngine/ibus-bamboo) - Input framework for Linux OS.

### Setup printer and scanner

Printer:

    sudo pacman -S cups system-config-printer

Search and install driver for your printer [here](https://wiki.archlinux.org/title/CUPS/Printer-specific_problems)

Scanner:

    sudo pacman -S sane simple-scan

### Enable dark mode for google-chrome

Find line include "Exec=" and add:

     --force-dark-mode --enable-features=WebUIDarkMode

    # Command
    sudo sed -i '/^Exec=/s/$/ --force-dark-mode --enable-features=WebUIDarkMode/' /usr/share/applications/google-chrome.desktop

### Install [colorscript](../colorscript/README.md)

    # Install
    cd ~/.dotfiles/colorscript
    sudo make install

    # Removal
    sudo make uninstall
