#!/bin/sh

## Directories ----------------------------
DIR=$(pwd)

## Directories ----------------------------
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White


[ ! -d $HOME/.config ] && mkdir -v $HOME/.config
[ ! -d $HOME/.config/git ] && mkdir -v $HOME/.config/git
[ ! -f ~/.config/git/config ] &&  touch ~/.config/git/config && echo "Create file config for git" 
[ ! -f ~/.xprofile ] && ln -sfv $DIR/x/.xprofile $HOME/.xprofile && echo "Add file .xprofile"
[ ! -f ~/.Xresources ] && ln -sfv $DIR/x/.Xresources $HOME/.Xresources && echo "Add file .Xresources"

while :
do
    echo
    echo "0 Quit"
    echo "1 Zsh"
    echo "2 Tmux"
    echo "3 Lsd"
    echo "4 Dircolors"
    echo "5 Tig"
    echo "6 Htop"
    echo "7 Vim"
    echo "8 Nvim"
    echo "9 Snippets"
    echo "10 Ripgrep"
    echo "11 Conky"
    echo "12 I3"
    echo "13 Alacritty"
    echo "14 Rofi"
    echo "15 Dunst"
    echo "16 Picom"
    echo "17 Feh"
    echo "18 Awesome"
    echo "19 Neofetch"
    echo "20 Cava"
    echo "21 Mpd and Ncmpcpp"
    
    read -p "Enter your choice: " choice
    case $choice in
    0)
        break
        ;;
    1)
        ### Zsh
        # .config/zsh
        [ ! -d $HOME/.config/zsh ] && mkdir -v $HOME/.config/zsh
        [ ! -d $HOME/.cache/zsh ] && mkdir -v $HOME/.cache/zsh
        ln -sfv $DIR/zsh/.zshrc $HOME/.config/zsh/.zshrc
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.local/share/zsh/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.local/share/zsh/zsh-syntax-highlighting
        git clone https://github.com/hlissner/zsh-autopair.git ~/.local/share/zsh/zsh-autopair
        git clone https://github.com/rupa/z.git  ~/.local/share/zsh/z
        ;;
    2)
        ### Tmux
        # .config/tmux
        [ ! -d $HOME/.config/tmux ] && mkdir -v $HOME/.config/tmux
        ln -sfv $DIR/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
        ;;
    3)
        ### Lsd
        # .config
        # .config/lsd
        [ ! -d $HOME/.config/lsd ] && mkdir -v $HOME/.config/lsd
        ln -sfv $DIR/lsd/config.yaml $HOME/.config/lsd/config.yaml
        # .config/lsd/themes
        [ ! -d $HOME/.config/lsd/themes ] && mkdir -v $HOME/.config/lsd/themes
        ln -sfv $DIR/lsd/themes/theme.yaml $HOME/.config/lsd/themes/theme.yaml
        ;;
    4)
        # Dircolors
        ln -sfv $DIR/dircolors/.dircolors $HOME/.dircolors
        ;;
    5)
        ### Tig
        # .config/tig
        [ ! -d $HOME/.config/tig ] && mkdir -v $HOME/.config/tig
        ln -sfv $DIR/tig/config $HOME/.config/tig/config
        ;;
    6)
        ### Htop
        # .config/htop
        [ ! -d $HOME/.config/htop ] && mkdir -v $HOME/.config/htop
        ln -sfv $DIR/htop/htoprc $HOME/.config/htop/htoprc
        ;;
    7)
        ### Vim
        ln -sfv $DIR//vim/.vimrc $HOME/.vimrc
        [ ! -d $HOME/.vim ] && mkdir -v $HOME/.vim
        ln -sfv $DIR/vim/mappings.vim $HOME/.vim/mappings.vim
        ln -sfv $DIR/vim/settings.vim $HOME/.vim/settings.vim
        ln -sfv $DIR/vim/statusline.vim $HOME/.vim/statusline.vim
        ln -sfv $DIR/vim/plugins.vim $HOME/.vim/plugins.vim
        # .vim/plug-config
        [ ! -d $HOME/vim/plug-config ] && mkdir -v $HOME/.vim/plug-config
        ln -sfv $DIR/vim/plug-config/fzf.vim $HOME/.vim/plug-config/fzf.vim
        ln -sfv $DIR/vim/plug-config/nerdcommenter.vim $HOME/.vim/plug-config/nerdcommenter.vim
        ln -sfv $DIR/vim/plug-config/nerdtree.vim $HOME/.vim/plug-config/nerdtree.vim
        ln -sfv $DIR/vim/plug-config/onedark.vim $HOME/.vim/plug-config/onedark.vim
        ln -sfv $DIR/vim/plug-config/buftabline.vim $HOME/.vim/plug-config/buftabline.vim
        ;;
    8)
        ### Nvim
        # .config/nvim
        [ ! -d $HOME/.config/nvim ] && mkdir -v $HOME/.config/nvim
        ln -sfv $DIR/nvim/init.lua $HOME/.config/nvim/init.lua
        # .config/nvim/lua
        [ ! -d $HOME/.config/nvim/lua ] && mkdir -v $HOME/.config/nvim/lua
        # .config/nvim/lua/core
        [ ! -d $HOME/.config/nvim/lua/core ] && mkdir -v $HOME/.config/nvim/lua/core
        ln -sfv $DIR/nvim/lua/core/options.lua $HOME/.config/nvim/lua/core/options.lua
        ln -sfv $DIR/nvim/lua/core/keymaps.lua $HOME/.config/nvim/lua/core/keymaps.lua
        ln -sfv $DIR/nvim/lua/core/plugins.lua $HOME/.config/nvim/lua/core/plugins.lua
        ln -sfv $DIR/nvim/lua/core/autocommands.lua $HOME/.config/nvim/lua/core/autocommands.lua
        ln -sfv $DIR/nvim/lua/core/startscreen.lua $HOME/.config/nvim/lua/core/startscreen.lua
        # .config/nvim/lua/plugins
        [ ! -d $HOME/.config/nvim/lua/plugins ] && mkdir -v $HOME/.config/nvim/lua/plugins
        ln -sfv $DIR/nvim/lua/plugins/colorscheme.lua $HOME/.config/nvim/lua/plugins/colorscheme.lua
        ln -sfv $DIR/nvim/lua/plugins/lualine.lua $HOME/.config/nvim/lua/plugins/lualine.lua
        ln -sfv $DIR/nvim/lua/plugins/bufferline.lua $HOME/.config/nvim/lua/plugins/bufferline.lua
        ln -sfv $DIR/nvim/lua/plugins/nvimtree.lua $HOME/.config/nvim/lua/plugins/nvimtree.lua
        ln -sfv $DIR/nvim/lua/plugins/telescope.lua $HOME/.config/nvim/lua/plugins/telescope.lua
        ln -sfv $DIR/nvim/lua/plugins/treesitter.lua $HOME/.config/nvim/lua/plugins/treesitter.lua
        ln -sfv $DIR/nvim/lua/plugins/gitsigns.lua $HOME/.config/nvim/lua/plugins/gitsigns.lua
        ln -sfv $DIR/nvim/lua/plugins/colorizer.lua $HOME/.config/nvim/lua/plugins/colorizer.lua
        ln -sfv $DIR/nvim/lua/plugins/illuminate.lua $HOME/.config/nvim/lua/plugins/illuminate.lua
        ln -sfv $DIR/nvim/lua/plugins/autopairs.lua $HOME/.config/nvim/lua/plugins/autopairs.lua
        ln -sfv $DIR/nvim/lua/plugins/comment.lua $HOME/.config/nvim/lua/plugins/comment.lua
        ln -sfv $DIR/nvim/lua/plugins/lsp.lua $HOME/.config/nvim/lua/plugins/lsp.lua
        ln -sfv $DIR/nvim/lua/plugins/cmp.lua $HOME/.config/nvim/lua/plugins/cmp.lua
        ln -sfv $DIR/nvim/lua/plugins/whichkey.lua $HOME/.config/nvim/lua/plugins/whichkey.lua
        ln -sfv $DIR/nvim/lua/plugins/dressing.lua $HOME/.config/nvim/lua/plugins/dressing.lua
        ln -sfv $DIR/nvim/lua/plugins/breadcrumbs.lua $HOME/.config/nvim/lua/plugins/breadcrumbs.lua
        ln -sfv $DIR/nvim/lua/plugins/scrollbar.lua $HOME/.config/nvim/lua/plugins/scrollbar.lua
        # .config/nvim/lua/lsp
        [ ! -d $HOME/.config/nvim/lua/lsp ] && mkdir -v $HOME/.config/nvim/lua/lsp
        ln -sfv $DIR/nvim/lua/lsp/init.lua $HOME/.config/nvim/lua/lsp/init.lua
        ln -sfv $DIR/nvim/lua/lsp/mason.lua $HOME/.config/nvim/lua/lsp/mason.lua
        ln -sfv $DIR/nvim/lua/lsp/handlers.lua $HOME/.config/nvim/lua/lsp/handlers.lua
        ln -sfv $DIR/nvim/lua/lsp/nullls.lua $HOME/.config/nvim/lua/lsp/nullls.lua
        # .config/nvim/lua/lsp/settings
        [ ! -d $HOME/.config/nvim/lua/lsp/settings ] && mkdir -v $HOME/.config/nvim/lua/lsp/settings
        ln -sfv $DIR/nvim/lua/lsp/settings/sumneko_lua.lua $HOME/.config/nvim/lua/lsp/settings/sumneko_lua.lua
        ln -sfv $DIR/nvim/lua/lsp/settings/emmet_ls.lua $HOME/.config/nvim/lua/lsp/settings/emmet_ls.lua
        ln -sfv $DIR/nvim/lua/lsp/settings/tsserver.lua $HOME/.config/nvim/lua/lsp/settings/tsserver.lua
        ln -sfv $DIR/nvim/lua/lsp/settings/jsonls.lua $HOME/.config/nvim/lua/lsp/settings/jsonls.lua
        ;;
    9)
        ### Snippets 
        # .config/snippets
        [ ! -d $HOME/.config/snippets ] && mkdir -v $HOME/.config/snippets
        ln -sfv $DIR/snippets/javascript.json $HOME/.config/snippets/javascript.json
        ln -sfv $DIR/snippets/package.json $HOME/.config/snippets/package.json
        ;;
    10)
        ### Ripgrep
        # .config/ripgrep
        [ ! -d $HOME/.config/ripgrep ] && mkdir -v $HOME/.config/ripgrep
        ln -sfv $DIR/ripgrep/.ripgreprc $HOME/.config/ripgrep/.ripgreprc
        ;;
    11)
        ### Conky
        # .config/conky
        [ ! -d $HOME/.config/conky ] && mkdir -v $HOME/.config/conky
        ln -sfv $DIR/conky/conky.conf $HOME/.config/conky/conky.conf
        ;;
    12)
        ### I3 
        # .config/i3
        [ ! -d $HOME/.config/i3 ] && mkdir -v $HOME/.config/i3
        ln -sfv $DIR/i3/config $HOME/.config/i3/config
        # .config/i3status
        [ ! -d $HOME/.config/i3status ] && mkdir -v $HOME/.config/i3status
        ln -sfv $DIR/i3status/config $HOME/.config/i3status/config
        ;;
    13)
        ### Alacritty 
        # .config/alacritty
        [ ! -d $HOME/.config/alacritty ] && mkdir -v $HOME/.config/alacritty
        ln -sfv $DIR/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
        ;;
    14)
        ### Rofi 
        # .fonts
        [ ! -d $HOME/.fonts ] && mkdir -v $HOME/.fonts
        ln -sfv $DIR/rofi/fonts/feather.ttf $HOME/.fonts/feather.ttf
        # .config/rofi
        [ ! -d $HOME/.config/rofi ] && mkdir -v $HOME/.config/rofi
        ln -sfv $DIR/rofi/config.rasi $HOME/.config/rofi/config.rasi
        # .config/rofi/bin
        [ ! -d $HOME/.config/rofi/bin ] && mkdir -v $HOME/.config/rofi/bin
        ln -sfv $DIR/rofi/bin/powermenu $HOME/.config/rofi/bin/powermenu
        chmod +x ~/.config/rofi/bin/powermenu
        ln -sfv $DIR/rofi/bin/launcher $HOME/.config/rofi/bin/launcher
        chmod +x ~/.config/rofi/bin/launcher
        ln -sfv $DIR/rofi/bin/apps $HOME/.config/rofi/bin/apps
        chmod +x ~/.config/rofi/bin/apps
        ln -sfv $DIR/rofi/bin/windows $HOME/.config/rofi/bin/windows
        chmod +x ~/.config/rofi/bin/windows
        # .config/rofi/themes
        [ ! -d $HOME/.config/rofi/themes ] && mkdir -v $HOME/.config/rofi/themes
        ln -sfv $DIR/rofi/themes/powermenu.rasi $HOME/.config/rofi/themes/powermenu.rasi
        ln -sfv $DIR/rofi/themes/apps.rasi $HOME/.config/rofi/themes/apps.rasi
        ln -sfv $DIR/rofi/themes/windows.rasi $HOME/.config/rofi/themes/windows.rasi
        ln -sfv $DIR/rofi/themes/launcher.rasi $HOME/.config/rofi/themes/launcher.rasi
        ;;
    15)
        ### Dunst 
        # .config/alacritty
        [ ! -d $HOME/.config/dunst ] && mkdir -v $HOME/.config/dunst
        ln -sfv $DIR/dunst/dunstrc $HOME/.config/dunst/dunstrc
        ;;
    16)
        ### Picom 
        # .config/picom
        [ ! -d $HOME/.config/picom ] && mkdir -v $HOME/.config/picom
        ln -sfv $DIR/picom/picom.conf $HOME/.config/picom/picom.conf
        ;;
    17)
        ### Feh 
        # .config/feh
        [ ! -d $HOME/.config/feh ] && mkdir -v $HOME/.config/feh
        ln -sfv $DIR/feh/themes $HOME/.config/feh/themes
        ;;
    18)
        ### Awesome 
        # .config/awesome
        [ ! -d $HOME/.config/awesome ] && mkdir -v $HOME/.config/awesome
        ln -sfv $DIR/awesome/theme.lua $HOME/.config/awesome/theme.lua
        ln -sfv $DIR/awesome/rc.lua $HOME/.config/awesome/rc.lua
        git clone https://github.com/lcpz/lain.git ~/.config/awesome/lain
        git clone https://github.com/lcpz/awesome-freedesktop.git ~/.config/awesome/freedesktop
        ;;
    19)
        ### Neofetch 
        # .config/neofetch
        [ ! -d $HOME/.config/neofetch ] && mkdir -v $HOME/.config/neofetch
        ln -sfv $DIR/neofetch/config.conf $HOME/.config/neofetch/config.conf
        ;;
    20)
        ### Cava 
        # .config/cava
        [ ! -d $HOME/.config/cava ] && mkdir -v $HOME/.config/cava
        ln -sfv $DIR/cava/config $HOME/.config/cava/config
        ;;
    21)
        ### mpd and ncmpcpp 
        # .cache/mpd
        [ ! -d $HOME/.cache/mpd ] && mkdir -v $HOME/.cache/mpd
        # .cache/mpd/playlists
        [ ! -d $HOME/.cache/mpd/playlists ] && mkdir -v $HOME/.cache/mpd/playlists
        # .config/mpd
        [ ! -d $HOME/.config/mpd ] && mkdir -v $HOME/.config/mpd
        ln -sfv $DIR/mpd/mpd.conf $HOME/.config/mpd/mpd.conf
        # .config/ncmpcpp
        [ ! -d $HOME/.config/ncmpcpp ] && mkdir -v $HOME/.config/ncmpcpp
        ln -sfv $DIR/ncmpcpp/config $HOME/.config/ncmpcpp/config
        ln -sfv $DIR/ncmpcpp/bindings $HOME/.config/ncmpcpp/bindings
        ;;
    *)
        echo "Sorry, choice understand"
        ;;
    esac
done
