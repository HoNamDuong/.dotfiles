" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif
" Call plugins
call plug#begin('~/.vim/plugged')
" Color
Plug 'joshdick/onedark.vim' " Theme
Plug 'ap/vim-buftabline'
" File browser and Search
Plug 'preservim/nerdtree' " File system explorer
Plug 'unkiwii/vim-nerdtree-sync' " Sync current file
Plug '~/.fzf' " Search file
Plug 'junegunn/fzf.vim' " Support fzf
" Code intelliSense
Plug 'jiangmiao/auto-pairs' " Brackets
Plug 'tpope/vim-surround' " Delete, change and add brackets
Plug 'preservim/nerdcommenter' " Comment code
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' } " Format code
" Source code version control
Plug 'mhinz/vim-signify' " Show all changes
call plug#end()
