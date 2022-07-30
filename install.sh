#!/bin/sh

path=$(pwd)

while :
do
    echo
    echo "INSTALL"
    echo "0 Quit"
    echo "1 All"
    echo "2 Vim"
    echo "3 Zsh"
    echo "4 Tmux"
    echo "5 Htop"
    echo "6 Dircolors"
    echo "7 Lsd"
    echo "8 Tig"
    echo "9 Nvim"
    read -p "Enter your choice: " choice
    case $choice in
    0)
        break
        ;;
    1)
        # Home directory
        ln -sfv $path/.dircolors $HOME/.dircolors
        ln -sfv $path/.tigrc $HOME/.tigrc
        ln -sfv $path/.vimrc $HOME/.vimrc
        ln -sfv $path/.zshrc $HOME/.zshrc
        # Add plugin zsh
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
        git clone https://github.com/hlissner/zsh-autopair.git ~/.zsh/zsh-autopair
        git clone https://github.com/rupa/z.git  ~/.zsh/z
        ln -sfv $path/.tmux.conf $HOME/.tmux.conf
        # .vim directory
        [ ! -d $HOME/.vim ] && mkdir -v $HOME/.vim
        ln -sfv $path/.vim/mappings.vim $HOME/.vim/mappings.vim
        ln -sfv $path/.vim/settings.vim $HOME/.vim/settings.vim
        ln -sfv $path/.vim/statusline.vim $HOME/.vim/statusline.vim
        ln -sfv $path/.vim/plugins.vim $HOME/.vim/plugins.vim
        # .vim/plug-config directory
        [ ! -d $HOME/.vim/plug-config ] && mkdir -v $HOME/.vim/plug-config
        ln -sfv $path/.vim/plug-config/fzf.vim $HOME/.vim/plug-config/fzf.vim
        ln -sfv $path/.vim/plug-config/nerdcommenter.vim $HOME/.vim/plug-config/nerdcommenter.vim
        ln -sfv $path/.vim/plug-config/nerdtree.vim $HOME/.vim/plug-config/nerdtree.vim
        ln -sfv $path/.vim/plug-config/onedark.vim $HOME/.vim/plug-config/onedark.vim
        ln -sfv $path/.vim/plug-config/buftabline.vim $HOME/.vim/plug-config/buftabline.vim
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/htop
        [ ! -d $HOME/.config/htop ] && mkdir -v $HOME/.config/htop
        ln -sfv $path/htoprc $HOME/.config/htop/htoprc
        # .config/lsd
        [ ! -d $HOME/.config/lsd ] && mkdir -v $HOME/.config/lsd
        ln -sfv $path/lsd/config.yaml $HOME/.config/lsd/config.yaml
        # .config/lsd/themes
        [ ! -d $HOME/.config/lsd/themes ] && mkdir -v $HOME/.config/lsd/themes
        ln -sfv $path/lsd/themes/theme.yaml $HOME/.config/lsd/themes/theme.yaml
        break
        ;;
    2)
        ln -sfv $path/.vimrc $HOME/.vimrc
        [ ! -d $HOME/.vim ] && mkdir -v $HOME/.vim
        ln -sfv $path/.vim/mappings.vim $HOME/.vim/mappings.vim
        ln -sfv $path/.vim/settings.vim $HOME/.vim/settings.vim
        ln -sfv $path/.vim/statusline.vim $HOME/.vim/statusline.vim
        ln -sfv $path/.vim/plugins.vim $HOME/.vim/plugins.vim
        [ ! -d $HOME/.vim/plug-config ] && mkdir -v $HOME/.vim/plug-config
        ln -sfv $path/.vim/plug-config/fzf.vim $HOME/.vim/plug-config/fzf.vim
        ln -sfv $path/.vim/plug-config/nerdcommenter.vim $HOME/.vim/plug-config/nerdcommenter.vim
        ln -sfv $path/.vim/plug-config/nerdtree.vim $HOME/.vim/plug-config/nerdtree.vim
        ln -sfv $path/.vim/plug-config/onedark.vim $HOME/.vim/plug-config/onedark.vim
        ln -sfv $path/.vim/plug-config/buftabline.vim $HOME/.vim/plug-config/buftabline.vim
        ;;
    3)
        ln -sfv $path/.zshrc $HOME/.zshrc
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
        git clone https://github.com/hlissner/zsh-autopair.git ~/.zsh/zsh-autopair
        git clone https://github.com/rupa/z.git  ~/.zsh/z
        ;;
    4)
        ln -sfv $path/.tmux.conf $HOME/.tmux.conf
        ;;
    5)
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        [ ! -d $HOME/.config/htop ] && mkdir -v $HOME/.config/htop
        ln -sfv $path/htoprc $HOME/.config/htop/htoprc
        ;;
    6)
        ln -sfv $path/.dircolors $HOME/.dircolors
        ;;
    7)
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/lsd
        [ ! -d $HOME/.config/lsd ] && mkdir -v $HOME/.config/lsd
        ln -sfv $path/lsd/config.yaml $HOME/.config/lsd/config.yaml
        # .config/lsd/themes
        [ ! -d $HOME/.config/lsd/themes ] && mkdir -v $HOME/.config/lsd/themes
        ln -sfv $path/lsd/themes/theme.yaml $HOME/.config/lsd/themes/theme.yaml
        ;;
    8)
        ln -sfv $path/.tigrc $HOME/.tigrc
        ;;
    9)
        # .config
        [ ! -d $HOME/.config ] && mkdir -v $HOME/.config
        # .config/nvim
        [ ! -d $HOME/.config/nvim ] && mkdir -v $HOME/.config/nvim
        ln -sfv $path/nvim/init.vim $HOME/.config/nvim/init.vim
        ln -sfv $path/nvim/settings.vim $HOME/.config/nvim/settings.vim
        ln -sfv $path/nvim/mappings.vim $HOME/.config/nvim/mappings.vim
        ln -sfv $path/nvim/statusline.vim $HOME/.config/nvim/statusline.vim
        ln -sfv $path/nvim/plugins.vim $HOME/.config/nvim/plugins.vim
        ln -sfv $path/nvim/startscreen.vim $HOME/.config/nvim/startscreen.vim
        # .config/nvim/plug-config
        [ ! -d $HOME/.config/nvim/plug-config ] && mkdir -v $HOME/.config/nvim/plug-config
        ln -sfv $path/nvim/plug-config/fzf.vim $HOME/.config/nvim/plug-config/fzf.vim
        ln -sfv $path/nvim/plug-config/nerdcommenter.vim $HOME/.config/nvim/plug-config/nerdcommenter.vim
        ln -sfv $path/nvim/plug-config/onedark.vim $HOME/.config/nvim/plug-config/onedark.vim
        ln -sfv $path/nvim/plug-config/nerdtree.vim $HOME/.config/nvim/plug-config/nerdtree.vim
        ln -sfv $path/nvim/plug-config/buftabline.vim $HOME/.config/nvim/plug-config/buftabline.vim
        ;;
    *)
        echo "Sorry, choice understand"
        ;;
    esac
done
