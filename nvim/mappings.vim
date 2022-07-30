" Map leader to Space
let mapleader = " " 

" Split panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Next panes
nnoremap <C-n> <C-w>w

" Next Buffer
nnoremap <silent> <leader>bn    :bn<CR>
" Unload current buffer
nnoremap <silent> <leader>bd    :bd<CR>
" Unload current buffer [!]
nnoremap <silent> <leader>bq    :bd!<CR>

" Save file
nnoremap <leader>w :w<CR>
" Quit
nnoremap <leader>q :q!<CR>
" Visual all lines
nnoremap <leader>a ggVG

" Stop the highlightin
nnoremap <silent> <leader>nh     :noh<CR>
" Remove unwanted whitespace
nnoremap <silent> <leader>ns     :%s/\s\+$//e<CR> :noh<CR>

" Enter visual block mode
nnoremap <C-b> <C-v>

" Create scratch buffer
fun! ScratchBuffer()
    bo new
    setlocal bufhidden=wipe buftype=nofile nobuflisted
    " setlocal nomodifiable nomodified
    nnoremap <buffer><silent> <Esc> :bd<CR>
endfun
" Get messages
nnoremap <silent> <leader>m :call ScratchBuffer()<bar> silent put = execute('messages')<CR>
" Get register
nnoremap <silent> <leader>r :call ScratchBuffer()<bar> silent put = execute('register')<CR>

" Terminal
nnoremap <silent> <leader>tt :bo 10new term://zsh<CR>i
