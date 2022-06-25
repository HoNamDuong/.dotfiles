" Automatic installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('config').'/plugged')
" Color
Plug 'joshdick/onedark.vim' "Theme
Plug 'vim-airline/vim-airline' " Status bar
Plug 'ryanoasis/vim-devicons' " Adds filetype-specific icons
Plug 'sheerun/vim-polyglot' " Syntax-highlighting for filetypes
Plug 'luochen1990/rainbow' " Color brackets
" File browser and Search
Plug 'preservim/nerdtree' " File system explorer
Plug 'unkiwii/vim-nerdtree-sync' " Sync current file
Plug '~/.fzf' " Search file
Plug 'junegunn/fzf.vim' " Support fzf
" Code intellisense
Plug 'preservim/nerdcommenter' " Comment code
Plug 'jiangmiao/auto-pairs' " Brackets
Plug 'tpope/vim-surround' " Delete, change and add brackets
" Source code version control
Plug 'mhinz/vim-signify' " Show all changes
call plug#end()


" Settings
source $HOME/.config/nvim/settings.vim
" Mappings
source $HOME/.config/nvim/mappings.vim
" Plugin configs
source $HOME/.config/nvim/plug-config/nerdcommenter.vim
source $HOME/.config/nvim/plug-config/onedark.vim
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/nerdtree.vim
source $HOME/.config/nvim/plug-config/fzf.vim

" for settings in split(glob(stdpath('config').'/plug-config/*.vim'))
    " execute 'source' settings
" endfor

" Start Screen
" source $HOME/.config/nvim/startscreen.vim
