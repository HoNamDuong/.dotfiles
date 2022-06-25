" F5 to toggle NERDTree
map <silent> <space>f :NERDTreeToggle<CR>
" Set size
let g:NERDTreeWinSize = 20
" Close the tab if NERDTree is the only window remaining in it
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If NERDTree is open, it will show that file in NERDTree window
let g:nerdtree_sync_cursorline = 1
" Show hidden files
let NERDTreeShowHidden=1
" Show Bookmarks
let g:NERDTreeShowBookmarks=1
" Specifies the bookmark file
" let g:NERDTreeBookmarksFile='C:\Users\TPC\AppData\Local\nvim-data\nerdbookmarks.txt'
