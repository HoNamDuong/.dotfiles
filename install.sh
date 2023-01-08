#!/bin/sh

path=$(pwd)

while :
do
    echo
    echo "INSTALL"
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
    echo "17 Xprofile"
    
    read -p "Enter your choice: " choice
    case $choice in
    0)
        break
        ;;
    1)
        ### Zsh
        ln -sfv $path/.zshrc $HOME/.zshrc
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
        git clone https://github.com/hlissner/zsh-autopair.git ~/.zsh/zsh-autopair
        git clone https://github.com/rupa/z.git  ~/.zsh/z
        ;;
    2)
        ### Tmux
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/tmux
        [ ! -d $HOME/.config/tmux ] && mkdir -v $HOME/.config/tmux
        ln -sfv $path/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
        ;;
    3)
        ### Lsd
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/lsd
        [ ! -d $HOME/.config/lsd ] && mkdir -v $HOME/.config/lsd
        ln -sfv $path/lsd/config.yaml $HOME/.config/lsd/config.yaml
        # .config/lsd/themes
        [ ! -d $HOME/.config/lsd/themes ] && mkdir -v $HOME/.config/lsd/themes
        ln -sfv $path/lsd/themes/theme.yaml $HOME/.config/lsd/themes/theme.yaml
        ;;
    4)
        # Dircolors
        ln -sfv $path/.dircolors $HOME/.dircolors
        ;;
    5)
        ### Tig
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/tig
        [ ! -d $HOME/.config/tig ] && mkdir -v $HOME/.config/tig
        ln -sfv $path/tig/config $HOME/.config/tig/config
        ;;
    6)
        ### Htop
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/htop
        [ ! -d $HOME/.config/htop ] && mkdir -v $HOME/.config/htop
        ln -sfv $path/htop/htoprc $HOME/.config/htop/htoprc
        ;;
    7)
        ### Vim
        ln -sfv $path/.vimrc $HOME/.vimrc
        [ ! -d $HOME/.vim ] && mkdir -v $HOME/.vim
        ln -sfv $path/.vim/mappings.vim $HOME/.vim/mappings.vim
        ln -sfv $path/.vim/settings.vim $HOME/.vim/settings.vim
        ln -sfv $path/.vim/statusline.vim $HOME/.vim/statusline.vim
        ln -sfv $path/.vim/plugins.vim $HOME/.vim/plugins.vim
        # .vim/plug-config
        [ ! -d $HOME/.vim/plug-config ] && mkdir -v $HOME/.vim/plug-config
        ln -sfv $path/.vim/plug-config/fzf.vim $HOME/.vim/plug-config/fzf.vim
        ln -sfv $path/.vim/plug-config/nerdcommenter.vim $HOME/.vim/plug-config/nerdcommenter.vim
        ln -sfv $path/.vim/plug-config/nerdtree.vim $HOME/.vim/plug-config/nerdtree.vim
        ln -sfv $path/.vim/plug-config/onedark.vim $HOME/.vim/plug-config/onedark.vim
        ln -sfv $path/.vim/plug-config/buftabline.vim $HOME/.vim/plug-config/buftabline.vim
        ;;
    8)
        ### Nvim
        # # .config/snippets
        # [ ! -d $HOME/.config/snippets ] && mkdir -v $HOME/.config/snippets
        # ln -sfv $path/snippets/javascript.json $HOME/.config/snippets/javascript.json
        # ln -sfv $path/snippets/package.json $HOME/.config/snippets/package.json
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/nvim
        [ ! -d $HOME/.config/nvim ] && mkdir -v $HOME/.config/nvim
        ln -sfv $path/nvim/init.lua $HOME/.config/nvim/init.lua
        # .config/nvim/lua
        [ ! -d $HOME/.config/nvim/lua ] && mkdir -v $HOME/.config/nvim/lua
        # .config/nvim/lua/core
        [ ! -d $HOME/.config/nvim/lua/core ] && mkdir -v $HOME/.config/nvim/lua/core
        ln -sfv $path/nvim/lua/core/options.lua $HOME/.config/nvim/lua/core/options.lua
        ln -sfv $path/nvim/lua/core/keymaps.lua $HOME/.config/nvim/lua/core/keymaps.lua
        ln -sfv $path/nvim/lua/core/plugins.lua $HOME/.config/nvim/lua/core/plugins.lua
        ln -sfv $path/nvim/lua/core/autocommands.lua $HOME/.config/nvim/lua/core/autocommands.lua
        ln -sfv $path/nvim/lua/core/startscreen.lua $HOME/.config/nvim/lua/core/startscreen.lua
        # .config/nvim/lua/plugins
        [ ! -d $HOME/.config/nvim/lua/plugins ] && mkdir -v $HOME/.config/nvim/lua/plugins
        ln -sfv $path/nvim/lua/plugins/colorscheme.lua $HOME/.config/nvim/lua/plugins/colorscheme.lua
        ln -sfv $path/nvim/lua/plugins/lualine.lua $HOME/.config/nvim/lua/plugins/lualine.lua
        ln -sfv $path/nvim/lua/plugins/bufferline.lua $HOME/.config/nvim/lua/plugins/bufferline.lua
        ln -sfv $path/nvim/lua/plugins/nvimtree.lua $HOME/.config/nvim/lua/plugins/nvimtree.lua
        ln -sfv $path/nvim/lua/plugins/telescope.lua $HOME/.config/nvim/lua/plugins/telescope.lua
        ln -sfv $path/nvim/lua/plugins/treesitter.lua $HOME/.config/nvim/lua/plugins/treesitter.lua
        ln -sfv $path/nvim/lua/plugins/gitsigns.lua $HOME/.config/nvim/lua/plugins/gitsigns.lua
        ln -sfv $path/nvim/lua/plugins/colorizer.lua $HOME/.config/nvim/lua/plugins/colorizer.lua
        ln -sfv $path/nvim/lua/plugins/illuminate.lua $HOME/.config/nvim/lua/plugins/illuminate.lua
        ln -sfv $path/nvim/lua/plugins/autopairs.lua $HOME/.config/nvim/lua/plugins/autopairs.lua
        ln -sfv $path/nvim/lua/plugins/comment.lua $HOME/.config/nvim/lua/plugins/comment.lua
        ln -sfv $path/nvim/lua/plugins/lsp.lua $HOME/.config/nvim/lua/plugins/lsp.lua
        ln -sfv $path/nvim/lua/plugins/cmp.lua $HOME/.config/nvim/lua/plugins/cmp.lua
        ln -sfv $path/nvim/lua/plugins/whichkey.lua $HOME/.config/nvim/lua/plugins/whichkey.lua
        ln -sfv $path/nvim/lua/plugins/dressing.lua $HOME/.config/nvim/lua/plugins/dressing.lua
        ln -sfv $path/nvim/lua/plugins/breadcrumbs.lua $HOME/.config/nvim/lua/plugins/breadcrumbs.lua
        ln -sfv $path/nvim/lua/plugins/scrollbar.lua $HOME/.config/nvim/lua/plugins/scrollbar.lua
        # .config/nvim/lua/lsp
        [ ! -d $HOME/.config/nvim/lua/lsp ] && mkdir -v $HOME/.config/nvim/lua/lsp
        ln -sfv $path/nvim/lua/lsp/init.lua $HOME/.config/nvim/lua/lsp/init.lua
        ln -sfv $path/nvim/lua/lsp/mason.lua $HOME/.config/nvim/lua/lsp/mason.lua
        ln -sfv $path/nvim/lua/lsp/handlers.lua $HOME/.config/nvim/lua/lsp/handlers.lua
        ln -sfv $path/nvim/lua/lsp/nullls.lua $HOME/.config/nvim/lua/lsp/nullls.lua
        # .config/nvim/lua/lsp/settings
        [ ! -d $HOME/.config/nvim/lua/lsp/settings ] && mkdir -v $HOME/.config/nvim/lua/lsp/settings
        ln -sfv $path/nvim/lua/lsp/settings/sumneko_lua.lua $HOME/.config/nvim/lua/lsp/settings/sumneko_lua.lua
        ln -sfv $path/nvim/lua/lsp/settings/emmet_ls.lua $HOME/.config/nvim/lua/lsp/settings/emmet_ls.lua
        ln -sfv $path/nvim/lua/lsp/settings/tsserver.lua $HOME/.config/nvim/lua/lsp/settings/tsserver.lua
        ln -sfv $path/nvim/lua/lsp/settings/jsonls.lua $HOME/.config/nvim/lua/lsp/settings/jsonls.lua
        ;;
    9)
        ### Snippets 
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/snippets
        [ ! -d $HOME/.config/snippets ] && mkdir -v $HOME/.config/snippets
        ln -sfv $path/snippets/javascript.json $HOME/.config/snippets/javascript.json
        ln -sfv $path/snippets/package.json $HOME/.config/snippets/package.json
        ;;
    10)
        ### Ripgrep
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/ripgrep
        [ ! -d $HOME/.config/ripgrep ] && mkdir -v $HOME/.config/ripgrep
        ln -sfv $path/ripgrep/.ripgreprc $HOME/.config/ripgrep/.ripgreprc
        ;;
    11)
        ### Conky
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/conky
        [ ! -d $HOME/.config/conky ] && mkdir -v $HOME/.config/conky
        ln -sfv $path/conky/conky.conf $HOME/.config/conky/conky.conf
        ;;
    12)
        ### I3 
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/i3
        [ ! -d $HOME/.config/i3 ] && mkdir -v $HOME/.config/i3
        ln -sfv $path/i3/config $HOME/.config/i3/config
        # .config/i3status
        [ ! -d $HOME/.config/i3status ] && mkdir -v $HOME/.config/i3status
        ln -sfv $path/i3status/config $HOME/.config/i3status/config
        ;;
    13)
        ### Alacritty 
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/alacritty
        [ ! -d $HOME/.config/alacritty ] && mkdir -v $HOME/.config/alacritty
        ln -sfv $path/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
        ;;
    14)
        ### Rofi 
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/rofi
        [ ! -d $HOME/.config/rofi ] && mkdir -v $HOME/.config/rofi
        ln -sfv $path/rofi/config.rasi $HOME/.config/rofi/config.rasi
        # .config/rofi/bin
        [ ! -d $HOME/.config/rofi/bin ] && mkdir -v $HOME/.config/rofi/bin
        ln -sfv $path/rofi/bin/powermenu $HOME/.config/rofi/bin/powermenu
        chmod +x ~/.config/rofi/bin/powermenu
        ln -sfv $path/rofi/bin/launcher $HOME/.config/rofi/bin/launcher
        chmod +x ~/.config/rofi/bin/launcher
        ln -sfv $path/rofi/bin/apps $HOME/.config/rofi/bin/apps
        chmod +x ~/.config/rofi/bin/apps
        ln -sfv $path/rofi/bin/windows $HOME/.config/rofi/bin/windows
        chmod +x ~/.config/rofi/bin/windows
        # .config/rofi/themes
        [ ! -d $HOME/.config/rofi/themes ] && mkdir -v $HOME/.config/rofi/themes
        ln -sfv $path/rofi/themes/powermenu.rasi $HOME/.config/rofi/themes/powermenu.rasi
        ln -sfv $path/rofi/themes/apps.rasi $HOME/.config/rofi/themes/apps.rasi
        ln -sfv $path/rofi/themes/windows.rasi $HOME/.config/rofi/themes/windows.rasi
        ln -sfv $path/rofi/themes/launcher.rasi $HOME/.config/rofi/themes/launcher.rasi
        ;;
    15)
        ### Dunst 
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/alacritty
        [ ! -d $HOME/.config/dunst ] && mkdir -v $HOME/.config/dunst
        ln -sfv $path/dunst/dunstrc $HOME/.config/dunst/dunstrc
        ;;
    16)
        ### Picom 
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/picom
        [ ! -d $HOME/.config/picom ] && mkdir -v $HOME/.config/picom
        ln -sfv $path/picom/picom.conf $HOME/.config/picom/picom.conf
        ;;
    17)
        ### Xprofile 
        ln -sfv $path/.xprofile $HOME/.xprofile
        ;;
    *)
        echo "Sorry, choice understand"
        ;;
    esac
done
