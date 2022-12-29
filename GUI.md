### Update and upgrade

```bash
sudo apt update
sudo apt upgrade
```

### Install packages

```bash
# Install i3, lxappearance ...
sudo apt i3, rofi, lxappearance
```

### Install picom with [Build picom](https://github.com/yshui/picom#build)

```bash
# 1. Install the needed packages are
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
# 2. Clone neovim
git clone https://github.com/yshui/picom.git
# 3. To build
cd picom
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
# 4. To install
sudo ninja -C build install

# Check version of picom
picom --version
```

### Clone .dotfiles and setup

```bash
# Clone .dotfiles
cd ~ && git clone https://github.com/HoNamDuong/.dotfiles.git

# Run install.sh
cd ~/.dotfiles
sh install.sh
```

### Run

Log out of your system and log in again. While logging in, be sure to select i3 session as your login screen.
