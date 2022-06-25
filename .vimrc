" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Call plugin
call plug#begin('~/.vim/plugged')
" Color
Plug 'joshdick/onedark.vim' " Theme
" File browser and Search
Plug 'preservim/nerdtree' " File system explorer
Plug 'unkiwii/vim-nerdtree-sync' " Sync current file
Plug '~/.fzf' " Search file
Plug 'junegunn/fzf.vim' " Support fzf
" Code intellisense
Plug 'jiangmiao/auto-pairs' " Brackets
Plug 'tpope/vim-surround' " Delete, change and add brackets
Plug 'preservim/nerdcommenter' " Comment code
" Source code version control
Plug 'mhinz/vim-signify' " Show all changes
call plug#end()


" Settings
source $HOME/.vim/settings.vim
" Mappings
source $HOME/.vim/mappings.vim
" Statusline
source $HOME/.vim/statusline.vim
" Plugin configs
source $HOME/.vim/plug-config/onedark.vim
source $HOME/.vim/plug-config/nerdtree.vim
source $HOME/.vim/plug-config/nerdcommenter.vim
source $HOME/.vim/plug-config/fzf.vim
