## Setup pacman wrapper

| Package                             | Description                                       |
| ----------------------------------- | ------------------------------------------------- |
| [yay](https://github.com/Jguer/yay) | Yet Another Yogurt - An AUR Helper Written in Go. |

    # Install git
    sudo pacman -S git

    # Download and install yay
    mkdir Downloads && \
    cd Downloads && \
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si

## Setup window manager

| Package                                             | Description                                                                                  |
| --------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| [Xorg](https://www.x.org/wiki/)                     | Xorg (commonly referred to as simply X) is the most popular display server among Linux users |
| [Alacritty](https://github.com/alacritty/alacritty) | A cross-platform, GPU-accelerated terminal emulator.                                         |
| [Picom](https://github.com/yshui/picom)             | A lightweight compositor for X11.                                                            |
| [Slock](https://tools.suckless.org/slock)           | A simple screen locker for X.                                                                |
| [Xss-lock](https://tools.suckless.org/slock)        | Use external locker as X screen saver.                                                       |
| [Awesomewm](https://awesomewm.org/)                 | A highly configurable, next generation framework window manager for X.                       |
| [I3wm](https://i3wm.org/)                           | A tiling window manager, completely written from scratch.                                    |

    # X system, compositor, terminal and screen locker
    yay -S xorg picom alacritty slock xss-lock

    # Install Awesomewm
    yay -S awesome-git

    # Install I3wm
    yay -S i3 perl-anyevent-i3 dunst dmenu

## Setup display manager

| Package                                                               | Description                                     |
| --------------------------------------------------------------------- | ----------------------------------------------- |
| [LightDM](https://github.com/canonical/lightdm)                       | Very light and fast display manager.            |
| [LightDM GTK Greeter](https://github.com/Xubuntu/lightdm-gtk-greeter) | A greeter that has moderate requirements (GTK). |

    # Install lightdm
    yay -S lightdm lightdm-gtk-greeter

    # Enable lightdm
    sudo systemctl enable lightdm

    # Copy config for lightdm-gtk-greeter
    sudo cp .dotfiles/.config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/

## Setup video driver

Identify the graphics card (the Subsystem output shows the specific model).

    lspci -v | grep -A1 -e VGA -e 3D

Consult [Archlinux Wiki](https://wiki.archlinux.org/title/xorg#Driver_installation) for correct video drivers installation.

    # Example with NVIDIA
    yay -S nvidia nvidia-settings

    # (re-)generate all existing presets
    sudo mkinitcpio -P

## Setup sound driver

| Package                                                                 | Description                                                                                                                                                                                        |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [PipeWire](https://gitlab.freedesktop.org/pipewire/pipewire)            | A new low-level multimedia framework. It aims to offer capture and playback for both audio and video with minimal latency and support for PulseAudio, JACK, ALSA and GStreamer-based applications. |
| [pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/) | PulseAudio Volume Control.                                                                                                                                                                         |

    # Install pipewire
    yay -S pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack pavucontrol

    # Enable pipewire’s services
    systemctl --user enable pipewire pipewire-pulse

## Restart system and login again

## Clone .dotfiles repository and setup

    # Clone .dotfiles
    cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git

    # Run install
    cd ~/.dotfiles
    ./install

    # Create file config
    mkdir -p .config/git
    touch ~/.config/git/config

    # Optional
    git config --global credential.helper "store --file ~/.config/git/.git-credentials"
    git config --global core.autocrlf false
    git config --global user.email "example@domain.com"
    git config --global user.name "username"

## Install theme, icon, cursor, font and tools

| Package                                                                            | Description                                                                   |
| ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [LXAppearance](https://github.com/lxde/lxappearance)                               | Feature-rich GTK+ theme switcher of the LXDE Desktop.                         |
| [Qt5ct](https://sourceforge.net/projects/qt5ct/)                                   | Qt5 Configuration Utility.                                                    |
| [Skeuos theme](https://aur.archlinux.org/packages/skeuos-gtk)                      | Light and Dark window themes based on a Skeuomorphic design.                  |
| [Papirus icon theme](https://archlinux.org/packages/extra/any/papirus-icon-theme/) | Papirus icon theme.                                                           |
| [Vimix cursors](https://aur.archlinux.org/packages/vimix-cursors)                  | An X Cursor theme inspired by Material design and based on capitaine-cursors. |

    # Application for Qt and Gtk
    yay -S lxappearance qt5ct

    # Install theme, icon, cursors
    yay -S  skeuos-gtk papirus-icon-theme vimix-cursors

    # Install font
    yay -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    yay -S ttf-hack-nerd ttf-roboto-mono-nerd

## Install package and applications

| Package (GUI)                                                                   | Description                                                                                                        |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [ARandR](https://github.com/haad/arandr)                                        | ARandR is designed to provide a simple visual front end for XRandR.                                                |
| [Nitrogen](https://github.com/l3ib/nitrogen)                                    | Background browser and setter for X windows.                                                                       |
| [Network Manager Applet](https://gitlab.gnome.org/GNOME/network-manager-applet) | Tray applet and an advanced network connection editor.                                                             |
| [Rofi](https://github.com/davatorium/rofi)                                      | A window switcher, application launcher and dmenu replacement.                                                     |
| [IBus Bamboo](https://github.com/BambooEngine/ibus-bamboo)                      | Next Generation Input Bus for Linux.                                                                               |
| [Viewnior](https://siyanpanayotov.com/project/viewnior)                         | Fast and elegant image viewer.                                                                                     |
| [Mpv](https://mpv.io/)                                                          | A free, open source, and cross-platform media player.                                                              |
| [Spotify](https://www.spotify.com/)                                             | A proprietary music streaming service                                                                              |
| [Zathura](https://pwmt.org/projects/zathura/)                                   | A highly customizable and functional document viewer.                                                              |
| [Google Chrome](https://www.google.com/chrome)                                  | The popular web browser by Google (Stable Channel)                                                                 |
| [Thunderbird](https://www.thunderbird.net/)                                     | Thunderbird is a free email application that's easy to set up and customize - and it's loaded with great features. |
| [Qalculate](https://qalculate.github.io/)                                       | The ultimate desktop calculator.                                                                                   |
| [Magnifiqus](https://github.com/redtide/magnifiqus)                             | Qt based screen magnifier.                                                                                         |
| [Screenkey](https://www.thregr.org/~wavexx/software/screenkey/)                 | A screencast tool to display your keys inspired by Screenflick.                                                    |

| Package (CLI)                                                       | Description                                                                                    |
| ------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| [tmux](https://github.com/tmux/tmux)                                | A terminal multiplexer.                                                                        |
| [tig](https://github.com/jonas/tig)                                 | Text-mode interface for Git.                                                                   |
| [bat](https://github.com/sharkdp/bat)                               | Cat clone with syntax highlighting and git integration                                         |
| [lsd](https://github.com/Peltoche/lsd)                              | GNU ls with lots of added features like colors, icons, tree-view, more formatting options etc. |
| [ranger](https://github.com/ranger/ranger)                          | Ranger is a console file manager with VI key bindings.                                         |
| [fzf](https://github.com/junegunn/fzf)                              | A command-line fuzzy finder.                                                                   |
| [playerctl](https://github.com/altdesktop/playerctl)                | For true players only: vlc, mpv, RhythmBox, web browsers, cmus, mpd, spotify and others.       |
| [xclip](https://github.com/astrand/xclip)                           | Command line interface to the X11 clipboard                                                    |
| [numlockx](https://github.com/rg3/numlockx)                         | Turns on the numlock key in X11.                                                               |
| [scrot](https://github.com/resurrecting-open-source-projects/scrot) | Command line screen capture utility.                                                           |
| [btop](https://github.com/aristocratos/btop)                        | A monitor of system resources, bpytop ported to C++.                                           |
| [neofetch](https://github.com/dylanaraps/neofetch)                  | A command-line system information tool written in bash 3.2+                                    |
| [cava](https://github.com/karlstav/cava)                            | Cross-platform Audio Visualizer.                                                               |
| [cmatrix](https://github.com/abishekvashok/cmatrix)                 | Matrix like effect in your terminal.                                                           |
| [pipes.sh](https://github.com/pipeseroni/pipes.sh)                  | Animated pipes terminal screensaver.                                                           |

    yay -S \
    tmux tig lsd fzf bat ripgrep fd wget \
    ranger-git w3m imagemagick \
    btop htop cmatrix cava pipes.sh neofetch \
    xdg-user-dirs xclip numlockx scrot playerctl \
    gnome-keyring polkit-gnome \
    rofi arandr network-manager-applet \
    viewnior nitrogen qalculate-gtk magnifiqus screenkey \
    mpv yt-dlp mpv-mpris \
    spotify zenity ffmpeg4.4 \
    zathura zathura-pdf-mupdf \
    google-chrome discord telegram-desktop thunderbird \
    visual-studio-code-bin postman-bin dbeaver

## Setup shell

| Package                                 | Description                                                                              |
| --------------------------------------- | ---------------------------------------------------------------------------------------- |
| [zsh](https://github.com/zsh-users/zsh) | A shell designed for interactive use, although it is also a powerful scripting language. |

    # Install zsh
    yay -S zsh zsh-autosuggestions-git zsh-syntax-highlighting-git zsh-completions-git zsh-autopair-git

    # Set zsh as default shell
    chsh -s $(which zsh)

## Setup text editor

| Package                                  | Description                            |
| ---------------------------------------- | -------------------------------------- |
| [nvim](https://github.com/neovim/neovim) | Hyperextensible Vim-based text editor. |

    # Deployment and management
    yay -S nodejs npm yarn luarocks

    # Install
    yay -S neovim

    # Check version of Neovim
    nvim -v

## Setup file manager

| Package                                   | Description               |
| ----------------------------------------- | ------------------------- |
| [Nemo](https://github.com/linuxmint/nemo) | Nemo is the file manager. |

    # Install
    yay -S nemo nemo-fileroller nemo-mediainfo-tab ntfs-3g gvfs-mtp gvfs-gphoto2

Set Nemo as default file browser

    xdg-mime default nemo.desktop inode/directory

Fix open file in a terminal

    # Make symbolic links
    ln -s $(which alacritty) ~/.local/bin/xterm

    # Remove
    rm ~/.local/bin/xterm

## Setup printer and scanner

| Package                                                                        | Description                                          |
| ------------------------------------------------------------------------------ | ---------------------------------------------------- |
| [system-config-printer](https://github.com/OpenPrinting/system-config-printer) | A CUPS printer configuration tool and status applet. |
| [simple-scan](https://gitlab.gnome.org/GNOME/simple-scan)                      | Simple scanning utility.                             |

#### Printer

    yay -S cups system-config-printer

After installing these `enable` and `start` the cups.service in systemd.

    sudo systemctl enable cups.service
    sudo systemctl start cups.service

Add user to the group `lg`:

    sudo usermod -aG lp $USER

Search and install driver for your printer [here](https://wiki.archlinux.org/title/CUPS/Printer-specific_problems).

#### Scanner

    yay -S sane simple-scan

Check if the scanner is detected with correct driver installed.

    scanimage -L

## Setup crontab

| Package                                           | Description                                                               |
| ------------------------------------------------- | ------------------------------------------------------------------------- |
| [cronie](https://github.com/cronie-crond/cronie/) | Daemon that runs specified programs at scheduled times and related tools. |

    # Install
    yay -S cronie

    # Enable
    sudo systemctl enable --now cronie.service

    # Edit crontab
    crontab -e

    # Example of job definition
    .---------------- minute (0 - 59)
    |  .------------- hour (0 - 23)
    |  |  .---------- day of month (1 - 31)
    |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    |  |  |  |  |
    *  *  *  *  * user-name  command to be executed

    # Example job randomize wallpaper
    */10 * * * * export DISPLAY=:0.0 && /bin/date && /usr/bin/nitrogen --set-zoom-fill --random --save &> /dev/null

## Setup docker

| Package                           | Description                                                    |
| --------------------------------- | -------------------------------------------------------------- |
| [docker](https://www.docker.com/) | Pack, ship and run any application as a lightweight container. |

    # Install packages
    yay -S docker docker-compose

    # Start its Daemon using the systemctl command as shown below
    sudo systemctl start docker.service

    # Verify that Docker is running using the status option
    sudo systemctl status docker.service

    # Enable docker service
    sudo systemctl enable docker.service

    # Add the current user account to the Docker group using the following command
    sudo usermod -aG docker $USER

## Enable dark mode for google-chrome

    # Create flags file
    touch ~/.config/chrome-flags.conf

    # Add into file
    --force-dark-mode
    --enable-features=WebUIDarkMode

## Optional pacman output

    # Automatically enable colors only when pacman’s output is on a tty
    sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf

    # Displays name, version and size of target packages formatted as a table for upgrade, sync and remove operations
    sudo sed -i -e 's/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf
