## Setup pacman wrapper

| Package                             | Description                                       |
| ----------------------------------- | ------------------------------------------------- |
| [yay](https://github.com/Jguer/yay) | Yet Another Yogurt - An AUR Helper Written in Go. |

    # Install git
    sudo pacman -S git

    # Download and install yay
    git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si

## Setup window manager

| Package                                             | Description                                                                                   |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| [Xorg](https://www.x.org/wiki/)                     | Xorg (commonly referred to as simply X) is the most popular display server among Linux users. |
| [Alacritty](https://github.com/alacritty/alacritty) | A cross-platform, GPU-accelerated terminal emulator.                                          |
| [Picom](https://github.com/yshui/picom)             | A lightweight compositor for X11.                                                             |
| [Slock](https://tools.suckless.org/slock)           | A simple screen locker for X.                                                                 |
| [Xss-lock](https://tools.suckless.org/slock)        | Use external locker as X screen saver.                                                        |
| [Awesomewm](https://awesomewm.org/)                 | A highly configurable, next generation framework window manager for X.                        |

    # X system, compositor, terminal, screen locker, and window manager
    yay -S xorg picom alacritty slock xss-lock awesome-git

## Setup display manager

| Package                               | Description                               |
| ------------------------------------- | ----------------------------------------- |
| [SDDM](https://github.com/sddm/sddm/) | QML based X11 and Wayland display manager |

    # Install sddm and sddm theme
    yay -S sddm qt5-declarative archlinux-themes-sddm

    # Enable and start sddm service
    sudo systemctl enable --now sddm.service

## Setup video driver

Identify the graphics card (the Subsystem output shows the specific model).

    lspci -v | grep -A1 -e VGA -e 3D

Consult [Archlinux Wiki](https://wiki.archlinux.org/title/xorg#Driver_installation) for correct video drivers installation.

## Setup sound driver

| Package                                                                 | Description                                                                                                                                                                                        |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [PipeWire](https://gitlab.freedesktop.org/pipewire/pipewire)            | A new low-level multimedia framework. It aims to offer capture and playback for both audio and video with minimal latency and support for PulseAudio, JACK, ALSA and GStreamer-based applications. |
| [pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/) | PulseAudio Volume Control.                                                                                                                                                                         |

    # Install pipewire
    yay -S pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack pavucontrol

    # Enable and start pipewire’s services
    systemctl enable --user --now pipewire pipewire-pulse

## Clone .dotfiles repository and setup

    # Clone dotfiles and setup
    cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git && cd ~/.dotfiles && ./setup

## Install theme, icon, cursor, font and tools

| Package                                                                            | Description                                                                   |
| ---------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [LXAppearance](https://github.com/lxde/lxappearance)                               | Feature-rich GTK+ theme switcher of the LXDE Desktop.                         |
| [Qt5ct](https://sourceforge.net/projects/qt5ct/)                                   | Qt5 Configuration Utility.                                                    |
| [Qt6ct](https://www.opencode.net/trialuser/qt6ct)                                  | Qt 6 Configuration Utility.                                                   |
| [Orchis theme](https://github.com/vinceliuice/orchis-theme)                        | A Material Design theme for GNOME/GTK based desktop environments.             |
| [Papirus icon theme](https://archlinux.org/packages/extra/any/papirus-icon-theme/) | A free and open source SVG icon theme for Linux.                              |
| [Vimix cursor theme](https://aur.archlinux.org/packages/vimix-cursors)             | An X Cursor theme inspired by Material design and based on capitaine-cursors. |

    # Application for Qt and Gtk
    yay -S lxappearance qt5ct qt6ct

    # Install theme, icon, cursors
    yay -S  orchis-theme papirus-icon-theme vimix-cursors

    # Install font
    yay -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    yay -S ttf-hack-nerd ttf-roboto-mono-nerd

## Install package and applications

| Package (GUI)                                                                   | Description                                                                                   |
| ------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| [ARandR](https://github.com/haad/arandr)                                        | ARandR is designed to provide a simple visual front end for XRandR.                           |
| [LSHW](https://ezix.org/project/wiki/HardwareLiSter)                            | A small tool to provide detailed information on the hardware configuration of the machine.    |
| [Nitrogen](https://github.com/l3ib/nitrogen)                                    | Background browser and setter for X windows.                                                  |
| [Network Manager Applet](https://gitlab.gnome.org/GNOME/network-manager-applet) | Tray applet and an advanced network connection editor.                                        |
| [Rofi](https://github.com/davatorium/rofi)                                      | A window switcher, application launcher and dmenu replacement.                                |
| [IBus Bamboo](https://github.com/BambooEngine/ibus-bamboo)                      | Next Generation Input Bus for Linux.                                                          |
| [CopyQ](https://github.com/hluk/CopyQ)                                          | Clipboard manager with searchable and editable history                                        |
| [Viewnior](https://siyanpanayotov.com/project/viewnior)                         | Fast and elegant image viewer.                                                                |
| [Mpv](https://mpv.io/)                                                          | A free, open source, and cross-platform media player.                                         |
| [Zathura](https://pwmt.org/projects/zathura/)                                   | A highly customizable and functional document viewer.                                         |
| [Google Chrome](https://www.google.com/chrome)                                  | The popular web browser by Google (Stable Channel).                                           |
| [Qalculate](https://qalculate.github.io/)                                       | The ultimate desktop calculator.                                                              |
| [Magnifiqus](https://github.com/redtide/magnifiqus)                             | Qt based screen magnifier.                                                                    |
| [Screenkey](https://www.thregr.org/~wavexx/software/screenkey/)                 | A screencast tool to display your keys inspired by Screenflick.                               |
| [Gucharmap](https://wiki.gnome.org/Apps/Gucharmap)                              | The GNOME Character Map, based on the Unicode Character Database.                             |
| [Gpick](https://github.com/thezbyg/gpick)                                       | Advanced color picker and palette editor.                                                     |
| [Onboard](https://launchpad.net/onboard)                                        | On-screen keyboard useful on tablet PCs or for mobility impaired users                        |
| [GIMP](https://www.gimp.org/)                                                   | GNU Image Manipulation Program.                                                               |
| [Inkscape](https://inkscape.org/)                                               | Professional vector graphics editor.                                                          |
| [qBittorrent](https://github.com/qbittorrent/qBittorrent)                       | An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar |

| Package (CLI)                                                       | Description                                                                              |
| ------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| [tmux](https://github.com/tmux/tmux)                                | A terminal multiplexer.                                                                  |
| [tig](https://github.com/jonas/tig)                                 | Text-mode interface for Git.                                                             |
| [bat](https://github.com/sharkdp/bat)                               | Cat clone with syntax highlighting and git integration.                                  |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree)               | A directory listing program displaying a depth indented list of files                    |
| [ranger](https://github.com/ranger/ranger)                          | Ranger is a console file manager with VI key bindings.                                   |
| [fzf](https://github.com/junegunn/fzf)                              | A command-line fuzzy finder.                                                             |
| [playerctl](https://github.com/altdesktop/playerctl)                | For true players only: vlc, mpv, RhythmBox, web browsers, cmus, mpd, spotify and others. |
| [xclip](https://github.com/astrand/xclip)                           | Command line interface to the X11 clipboard.                                             |
| [numlockx](https://github.com/rg3/numlockx)                         | Turns on the numlock key in X11.                                                         |
| [scrot](https://github.com/resurrecting-open-source-projects/scrot) | Command line screen capture utility.                                                     |
| [exiftool](https://github.com/exiftool/exiftool)                    | Reader and rewriter of EXIF information that supports raw files                          |
| [btop](https://github.com/aristocratos/btop)                        | A monitor of system resources, bpytop ported to C++.                                     |
| [cava](https://github.com/karlstav/cava)                            | Cross-platform Audio Visualizer.                                                         |
| [cmatrix](https://github.com/abishekvashok/cmatrix)                 | Matrix like effect in your terminal.                                                     |
| [pipes.sh](https://github.com/pipeseroni/pipes.sh)                  | Animated pipes terminal screensaver.                                                     |

    yay -S \
    tmux btop tig tree fzf bat ripgrep fd wget \
    ranger-git w3m imagemagick \
    fastfetch cmatrix cava pipes.sh \
    polkit-gnome gnome-keyring \
    xclip numlockx scrot playerctl \
    rofi arandr network-manager-applet copyq \
    nitrogen qalculate-gtk magnifiqus screenkey \
    gucharmap gpick lshw onboard perl-image-exiftool \
    viewnior webp-pixbuf-loader \
    mpv yt-dlp mpv-mpris \
    zathura zathura-pdf-mupdf \
    google-chrome discord telegram-desktop \
    visual-studio-code-bin gimp inkscape qbittorrent \

## Setup shell

| Package                                         | Description                                                                              |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------- |
| [zsh](https://github.com/zsh-users/zsh)         | A shell designed for interactive use, although it is also a powerful scripting language. |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | A smarter cd command, inspired by z and autojump                                         |

    # Install
    yay -S zsh zsh-autosuggestions-git zsh-syntax-highlighting-git zsh-completions-git zsh-autopair-git
    yay -S zoxide

    # Set zsh as default shell
    chsh -s $(which zsh)

## Setup text editor

| Package                                  | Description                            |
| ---------------------------------------- | -------------------------------------- |
| [nvim](https://github.com/neovim/neovim) | Hyperextensible Vim-based text editor. |

    # Deployment and management
    yay -S nodejs npm yarn luarocks tree-sitter-cli lazygit

    # Install
    yay -S neovim

    # Check version of Neovim
    nvim -v

## Setup file manager

| Package                                   | Description               |
| ----------------------------------------- | ------------------------- |
| [Nemo](https://github.com/linuxmint/nemo) | Nemo is the file manager. |

    # Install
    yay -S nemo nemo-fileroller nemo-mediainfo-tab rar ntfs-3g gvfs-mtp gvfs-gphoto2

Change the default terminal emulator for Nemo:

    gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
    gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg -e

Fix open file in a terminal:

    # Make symbolic links
    ln -s $(which alacritty) ~/.local/bin/xterm

    # Remove
    rm ~/.local/bin/xterm

## Setup bluetooth

| Package                                               | Description                               |
| ----------------------------------------------------- | ----------------------------------------- |
| [BlueZ](https://www.bluez.org/)                       | Daemons for the bluetooth protocol stack. |
| [Blueman](https://github.com/blueman-project/blueman) | GTK+ Bluetooth Manager.                   |

    # Install bluez, blueman
    yay -S bluez bluez-utils bluez-obex blueman

    # Enable and start bluetooth services
    sudo systemctl enable --now bluetooth.service

## Setup printer and scanner

| Package                                                                        | Description                                          |
| ------------------------------------------------------------------------------ | ---------------------------------------------------- |
| [system-config-printer](https://github.com/OpenPrinting/system-config-printer) | A CUPS printer configuration tool and status applet. |
| [simple-scan](https://gitlab.gnome.org/GNOME/simple-scan)                      | Simple scanning utility.                             |

### Printer

    # Install
    yay -S cups system-config-printer

    # Enable and start
    sudo systemctl enable --now cups.service

    # Add user to the group `lg`:
    sudo usermod -aG lp $USER

Search and install driver for your printer [here](https://wiki.archlinux.org/title/CUPS/Printer-specific_problems).

### Scanner

    # Install
    yay -S sane simple-scan

    # Check if the scanner is detected with correct driver installed
    scanimage -L

