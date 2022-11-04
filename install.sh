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
    echo "9 Ripgrep"
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
        ln -sfv $path/.tmux.conf $HOME/.tmux.conf
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
        ln -sfv $path/.tigrc $HOME/.tigrc
        ;;
    6)
        ### Htop
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/htop
        [ ! -d $HOME/.config/htop ] && mkdir -v $HOME/.config/htop
        ln -sfv $path/htoprc $HOME/.config/htop/htoprc
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
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/snippets
        [ ! -d $HOME/.config/snippets ] && mkdir -v $HOME/.config/snippets
        ln -sfv $path/snippets/javascript.json $HOME/.config/snippets/javascript.json
        ln -sfv $path/snippets/package.json $HOME/.config/snippets/package.json
        # .config/nvim
        [ ! -d $HOME/.config/nvim ] && mkdir -v $HOME/.config/nvim
        ln -sfv $path/nvim/init.lua $HOME/.config/nvim/init.lua
        # .config/nvim/lua
        [ ! -d $HOME/.config/nvim/lua ] && mkdir -v $HOME/.config/nvim/lua
        # .config/nvim/lua/dat
        [ ! -d $HOME/.config/nvim/lua/dat ] && mkdir -v $HOME/.config/nvim/lua/dat
        ln -sfv $path/nvim/lua/dat/options.lua $HOME/.config/nvim/lua/dat/options.lua
        ln -sfv $path/nvim/lua/dat/keymaps.lua $HOME/.config/nvim/lua/dat/keymaps.lua
        ln -sfv $path/nvim/lua/dat/plugins.lua $HOME/.config/nvim/lua/dat/plugins.lua
        ln -sfv $path/nvim/lua/dat/autocommands.lua $HOME/.config/nvim/lua/dat/autocommands.lua
        ln -sfv $path/nvim/lua/dat/colorscheme.lua $HOME/.config/nvim/lua/dat/colorscheme.lua
        ln -sfv $path/nvim/lua/dat/lualine.lua $HOME/.config/nvim/lua/dat/lualine.lua
        ln -sfv $path/nvim/lua/dat/bufferline.lua $HOME/.config/nvim/lua/dat/bufferline.lua
        ln -sfv $path/nvim/lua/dat/nvimtree.lua $HOME/.config/nvim/lua/dat/nvimtree.lua
        ln -sfv $path/nvim/lua/dat/telescope.lua $HOME/.config/nvim/lua/dat/telescope.lua
        ln -sfv $path/nvim/lua/dat/treesitter.lua $HOME/.config/nvim/lua/dat/treesitter.lua
        ln -sfv $path/nvim/lua/dat/gitsigns.lua $HOME/.config/nvim/lua/dat/gitsigns.lua
        ln -sfv $path/nvim/lua/dat/colorizer.lua $HOME/.config/nvim/lua/dat/colorizer.lua
        ln -sfv $path/nvim/lua/dat/illuminate.lua $HOME/.config/nvim/lua/dat/illuminate.lua
        ln -sfv $path/nvim/lua/dat/autopairs.lua $HOME/.config/nvim/lua/dat/autopairs.lua
        ln -sfv $path/nvim/lua/dat/comment.lua $HOME/.config/nvim/lua/dat/comment.lua
        ln -sfv $path/nvim/lua/dat/lsp.lua $HOME/.config/nvim/lua/dat/lsp.lua
        ln -sfv $path/nvim/lua/dat/cmp.lua $HOME/.config/nvim/lua/dat/cmp.lua
        ln -sfv $path/nvim/lua/dat/startscreen.lua $HOME/.config/nvim/lua/dat/startscreen.lua
        ln -sfv $path/nvim/lua/dat/whichkey.lua $HOME/.config/nvim/lua/dat/whichkey.lua
        ln -sfv $path/nvim/lua/dat/dressing.lua $HOME/.config/nvim/lua/dat/dressing.lua
        # .config/nvim/lua/lsp
        [ ! -d $HOME/.config/nvim/lua/dat/lsp ] && mkdir -v $HOME/.config/nvim/lua/dat/lsp
        ln -sfv $path/nvim/lua/dat/lsp/init.lua $HOME/.config/nvim/lua/dat/lsp/init.lua
        ln -sfv $path/nvim/lua/dat/lsp/mason.lua $HOME/.config/nvim/lua/dat/lsp/mason.lua
        ln -sfv $path/nvim/lua/dat/lsp/handlers.lua $HOME/.config/nvim/lua/dat/lsp/handlers.lua
        ln -sfv $path/nvim/lua/dat/lsp/nullls.lua $HOME/.config/nvim/lua/dat/lsp/nullls.lua
        # .config/nvim/lua/lsp/settings
        [ ! -d $HOME/.config/nvim/lua/dat/lsp/settings ] && mkdir -v $HOME/.config/nvim/lua/dat/lsp/settings
        ln -sfv $path/nvim/lua/dat/lsp/settings/sumneko_lua.lua $HOME/.config/nvim/lua/dat/lsp/settings/sumneko_lua.lua
        ln -sfv $path/nvim/lua/dat/lsp/settings/emmet_ls.lua $HOME/.config/nvim/lua/dat/lsp/settings/emmet_ls.lua
        ln -sfv $path/nvim/lua/dat/lsp/settings/tsserver.lua $HOME/.config/nvim/lua/dat/lsp/settings/tsserver.lua
        ;;
    9)
        ### Ripgrep
        ln -sfv $path/.ripgreprc $HOME/.ripgreprc
        ;;
    *)
        echo "Sorry, choice understand"
        ;;
    esac
done
