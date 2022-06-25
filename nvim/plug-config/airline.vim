" Set theme for status bar
let g:airline_theme='onedark'

" Enable Tab bar
let g:airline#extensions#tabline#enabled = 1
" Enable Tab seperator
let g:airline#extensions#tabline#left_alt_sep = '|'
" Set Tab name as file name
let g:airline#extensions#tabline#fnamemod = ':t'

" Note: set to an empty dictionary to disable truncation.
let g:airline#extensions#default#section_truncate_width = {}

" Disable fileformat symbols on airline
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Define the set of text to display for each mode
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

" Set Powerline font
let g:airline_powerline_fonts = 1
" Set symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" Powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.colnr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" Change section b
au VimEnter * call airline#parts#define('branch', {'raw': '', 'minwidth': 50})
au VimEnter * call airline#parts#define('hunks', {'raw': '', 'minwidth': 50})
au VimEnter * let g:airline_section_b = airline#section#create(['hunks', 'branch'])
" Change section z
let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr'])

" Enable/disable nerdtree's statusline integration
let g:airline#extensions#nerdtree_statusline = 0
