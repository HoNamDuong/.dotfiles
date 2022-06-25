set encoding=utf-8 " The encoding displayed
set mouse=a " Enable mouse
set updatetime=300
set tabstop=4 " Insert 4 spaces for a tab
set shiftwidth=4 " Number of space characters inserted for indentation
set expandtab " Converts tabs to spaces
set foldmethod=indent " Fold based on the indentation
set foldlevelstart=99
set ignorecase " Enable case-sensitive
set autochdir " Set working directory to the current file
set pumheight=10 " Makes popup menu smaller
set cmdheight=2 " More space for displaying messages
set showtabline=2 " Always show tabs
set cursorline " Highlight current line
set number " Show line number
set relativenumber " Relative line numbers
set list " Whitespace characters are made visible
set lcs+=space:- " Show <Space>
set laststatus=2 " Always show status bar
set shortmess+=c " Don't pass messages to |ins-completion-menu|
set noruler " Hide the line and column number
" set signcolumn=number " Always show the signcolumn

set nobackup
set nowritebackup
set noswapfile " Disable creating swap file
set hidden

syntax on " Syntax highlighting

" set nowrap " Display long lines as just one line
" set cc=80 " set an 80 column border for good coding style
" set splitbelow
" set splitright

" Display cursorline and cursorcolumn ONLY in active window.
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Color schemes
if (has("termguicolors"))
    set termguicolors
endif

" Enable copying from vim to clipboard
if has('win32')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
