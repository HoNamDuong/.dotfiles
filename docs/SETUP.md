### Update and upgrade

    sudo pacman -Syu
    sudo pacman -S htop git tmux wget

    sudo timedatectl set-ntp
    timedatectl status

### Installing YAY

    mkdir Downloads && \
    cd Downloads && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si

### Installing Xorg packages, i3 and video drivers

Note: your video card may be different and you may need to install different video drivers, please consult Archlinux Wiki for correct video drivers installation

Find your video card

    lspci | grep -e VGA -e 3D

The first step is to disable Intel Integrated Graphics Controller

    echo "install i915 /bin/false" | sudo tee --append /etc/modprobe.d/blacklist.conf && \
    cat /etc/modprobe.d/blacklist.conf

    sudo pacman -S nvidia nvidia-settings xorg xorg-xinit vdpauinfo
    sudo pacman -S libva-utils libva-vdpau-driver

Remove `kms` from the HOOKS array in `/etc/mkinitcpio.conf` and regenerate the initramfs. This will prevent the initramfs from containing the nouveau module making sure the kernel cannot load it during early boot.

    sudo mkinitcpio -P

Note: Nvidia non open source drivers may conflict with `nouveau` OS drivers and in below case to make drivers work I needed to blacklist nouveau drivers

    cat /usr/lib/modprobe.d/nvidia-utils.conf
    blacklist nouveau

Install i3

    sudo pacman -S i3 perl-anyevent-i3 alacritty rofi dunst picom dmenu numlockx

### Install Display manager and config

I am using `lightdm` as is very light and fast display manager but you can install any other Display Manager you are familiar with. Ex. GDM, LXDM, XDM etc.

    sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

Change file lightdm.conf

    grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#autologin-user=/autologin-user=$USER/g' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#autologin-session=/autologin-session=i3/g' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
    grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf

Change theme and background color in file:

    /etc/lightdm/lightdm-gtk-greeter.conf

    # Copy config for lightdm-gtk-greeter
    sudo cp .dotfiles/.config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/

Start lightdm

    sudo systemctl enable lightdm && \
    sudo systemctl start lightdm

### Run

Log out of your system and log in again. While logging in, be sure to select i3 session as your login screen.

### Clone .dotfiles and setup

    # Clone .dotfiles
    cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git

    # Run install.sh
    cd ~/.dotfiles
    ./install

    # Config git
    mkdir -p .config/git
    touch ~/.config/git/config
    git config --global credential.helper "store --file ~/.config/git/.git-credentials"
    git config --global core.autocrlf false
    git config --global user.email "example@domain.com"
    git config --global user.name "username"

### Install font and packages

    sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    sudo pacman -S ttf-hack-nerd ttf-roboto-mono

    sudo pacman -S tig tree ripgrep fzf fd lsd ranger w3m bat neofetch imagemagick xclip

    # Install zsh
    sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions
    yay -S zsh-autopair zsh-z-git

    # Set zsh as default shell
    chsh -s $(which zsh)

### Keyring, polkit and screenshot

    sudo pacman -S gnome-keyring polkit-gnome gnome-screenshot

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

    # Application for Qt and Gtk
    sudo pacman -S lxappearance qt5ct

    yay -S  skeuos-gtk papirus-icon-theme vimix-cursors

### Installing sound drivers and tools

    sudo pacman -S alsa-utils alsa-plugins pavucontrol pipewire-pulse
    systemctl --user enable pipewire-pulse.service

### Installing applications (Optional)

    sudo pacman -S viewnior nitrogen conky dbeaver
    sudo pacman -S mpv yt-dlp mpd ncmpcpp
    sudo pacman -S discord spotify-launcher telegram-desktop thunderbird cmatrix

Few more optional tools that are recommended we can find in AUR

    yay -S google-chrome visual-studio-code-bin postman-bin cava pipes.sh

Install [iBus](https://github.com/BambooEngine/ibus-bamboo) - Input framework for Linux OS.

### File manager

    sudo pacman -S nemo nemo-fileroller ntfs-3g

Set Nemo as default file browser

    xdg-mime default nemo.desktop inode/directory

Change the default terminal emulator for Nemo

    gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

    gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg -e

Fix open file in a terminal

    # Make symbolic links
    ln -s $(which alacritty) ~/.local/bin/xterm

    # Remove
    rm ~/.local/bin/xterm

### Mount disk example

    # To identify existing file systems
    lsblk -f

    # Change file fstab
    sudo nvim /etc/fstab

    # Example add line
    echo '# /dev/sda3
    UUID=1CC5-1EA1 /run/media/dat/Storage auto defaults,uid=1000,gid=1000 0 0
    ' | sudo tee -a /etc/fstab

### Setup printer and scanner

#### Printer

    sudo pacman -S cups system-config-printer

After installing these `enable` and `start` the cups.service in systemd.

    sudo systemctl enable cups.service
    sudo systemctl start cups.service

Add user to the group `lg`:

    sudo usermod -aG lp $USER

Search and install driver for your printer [here](https://wiki.archlinux.org/title/CUPS/Printer-specific_problems)

#### Scanner

    sudo pacman -S sane simple-scan

Check if the scanner is detected with correct driver installed.

    scanimage -L

### Install docker

    sudo pacman -S docker docker-compose

    # Start its Daemon using the systemctl command as shown below
    sudo systemctl start docker.service

    # Verify that Docker is running using the status option
    sudo systemctl status docker.service

    # Enable docker service
    sudo systemctl enable docker.service

    # Add the current user account to the Docker group using the following command
    sudo usermod -aG docker $USER

### Enable dark mode for google-chrome

    touch ~/.config/chrome-flags.conf
    # Add into file
    --force-dark-mode
    --enable-features=WebUIDarkMode

    # Or command
    sudo sed -i '/^Exec=/s/$/ --force-dark-mode --enable-features=WebUIDarkMode/' /usr/share/applications/google-chrome.desktop

### Optional add nice color to pacman output

The final touch is to add some color to the package manager

    sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf && \
    sudo sed -i -e 's/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf && \
    grep "Color" /etc/pacman.conf
    grep "VerbosePkgLists" /etc/pacman.conf

### Install [colorscript](../.config/colorscript/README.md)

    # Install
    cd ~/.dotfiles/.config/colorscript
    sudo make install

    # Removal
    sudo make uninstall
