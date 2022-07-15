set nocompatible " Disable compatibility with vi which can cause unexpected issues.
filetype on " Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype plugin on " Enable plugins and load plugin for the detected file type.
filetype indent on " Load an indent file for the detected file type.
set encoding=utf-8 " The encoding displayed
set mouse=a " Enable mouse
set tabstop=4 " Insert 4 spaces for a tab
set shiftwidth=4 " Number of space characters inserted for indentation
set expandtab " Converts tabs to spaces
set list listchars=tab:❘⠀,trail:·,extends:»,precedes:«,nbsp:×,space:·
set scrolloff=5 " Do not let cursor scroll below or above N number of lines when scrolling.
set foldmethod=indent " Fold based on the indentation
set foldlevelstart=99
set ignorecase " Ignore capital letters during search.
set smartcase " This will allow you to search specifically for capital letters.
set autochdir " Set working directory to the current file
set pumheight=10 " Makes popup menu smaller
set cmdheight=1 " More space for displaying messages
set showtabline=2 " Always show tabs
set cursorline " Highlight cursor line underneath the cursor horizontally.
" set cursorcolumn " Highlight cursor line underneath the cursor vertically.
set number " Show line number
set relativenumber " Relative line numbers
set signcolumn=number " Always show the signcolumn
set wildmenu " Enable auto completion menu after pressing TAB.
set wildmode=longest:full,full
set showcmd " Show partial command you type in the last line of the screen.
set showmatch " Show matching words during a search.
set hlsearch " Use highlighting when doing a search.
set incsearch " While searching though a file incrementally highlight matching characters as you type.
set shortmess-=S " Show search count message when searching
set timeoutlen=1000 ttimeoutlen=0 " Key code delay

set nobackup " Do not save backup files.
set nowritebackup
set noswapfile " Disable creating swap file
set hidden

" set nowrap " Do not wrap lines. Allow long lines to extend as far as the line goes.

syntax on " Syntax highlighting

" Display cursorline and cursorcolumn ONLY in active window.
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" color schemes
if (has("termguicolors"))
    set termguicolors
endif

set splitbelow
set splitright

"Enable copying from vim to clipboard
set clipboard=unnamedplus

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Yanking to windows clipboard from vim (WSL2)
if system('uname -r') =~ "microsoft"
    augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
    augroup END
endif

" Change cursor
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
