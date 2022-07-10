" Toggle NERDTree
noremap <silent> <leader>e :NERDTreeToggle<CR>
" Set size
let g:NERDTreeWinSize = 20
" Hide status line in buffer NERDTree
let g:NERDTreeStatusline = '%#NonText#'

" " Close the tab if NERDTree is the only window remaining in it
" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If NERDTree is open, it will show that file in NERDTree window
let g:nerdtree_sync_cursorline = 1
" Show hidden files
let NERDTreeShowHidden=1
" Automatically close NERDTree when you open a file
let NERDTreeQuitOnOpen=1
