### Update and upgrade

```bash
sudo pacman -Syu
```

### Optional add nice color to pacman output

The final touch is to add some color to the package manager

    grep “Color” /etc/pacman.conf && \
    sudo sed -i -e ‘s/#Color/Color/g’ /etc/pacman.conf && \
    grep “Color” /etc/pacman.conf

### Installing YAY

    mkdir Sources && \
    cd Sources && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si && \

### Installing Xorg packages, i3 and video drivers

Note: your video card may be different and you may need to install different video drivers, please consult Archlinux Wiki for correct video drivers installation

Find your video card

    lspci | grep -e VGA -e 3D

The first step is to disable Intel Integrated Graphics Controller

    echo “install i915 /bin/false” | sudo tee --append /etc/modprobe.d/blacklist.conf && \
    cat /etc/modprobe.d/blacklist.conf


    sudo pacman -S nvidia nvidia-utils nvidia-settings xorg-server xorg-apps xorg-xinit i3 numlockx -noconfirm -needed

Note: Nvidia non open source drivers may conflict with nouveau OS drivers and in below case to make drivers work I needed to blacklist nouveau drivers

    cat /usr/lib/modprobe.d/nvidia.conf
    blacklist nouveau

### Install Display manager

I am using lightdm as is very light and fast display manager but you can install any other Display Manager you are familiar with. Ex. GDM, LXDM, XDM etc.

    sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed

Enable Start lightdm

    sudo systemctl enable lightdm && \
    sudo systemctl start lightdm

### Configure lightdm

    grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#autologin-user=/autologin-user=$USER/g' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#autologin-session=/autologin-session=i3/g' /etc/lightdm/lightdm.conf && \
    sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
    grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf

### Installing sound drivers and tools

    sudo pacman -S alsa-utils alsa-plugins alsa-lib pavucontrol pipewire pipewire-pulse --noconfirm --needed

### Install packages

    # Install i3, lxappearance ...
    sudo pacman -Sy i3 rofi dunst picom lxappearance dmenu conky ranger alacritty vlc gnome-screenshot

### Installing X Window applications (Optional)

    sudo pacman -S chromium vlc -noconfirm -needed

Few more optional tools that are recommended we can find in AUR

    yay -S google-chrome visual-studio-code-bin

### Clone .dotfiles and setup

    # Clone .dotfiles
    cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git
    # Config git credential
    git config --global credential.helper "store --file ~/.git-credentials"
    git config --global user.email "example@domain.com"
    git config --global user.name "username"

    # Run install.sh
    cd ~/.dotfiles
    sh install.sh

### Keyring and polkit

    sudo pacman -S gnome-keyring polkit-gnome

### File manager

    sudo pacman -S nemo nemo-fileroller

### Run

Log out of your system and log in again. While logging in, be sure to select i3 session as your login screen.
