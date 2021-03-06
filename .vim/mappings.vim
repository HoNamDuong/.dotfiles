" Map leader to Space
let mapleader = " " 

" Split panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-n> <C-w>w

" Resize split windows using arrow keys
noremap <C-up> <c-w>+
noremap <C-down> <c-w>-
noremap <C-left> <c-w>>
noremap <C-right> <c-w><

" Next Buffer
nnoremap <silent> <leader>bn   :bn<CR>
" Unload current buffer
nnoremap <silent> <leader>bd   :bd<CR>
" Unload current buffer [!]
nnoremap <silent> <leader>bq  :bd!<CR>

" Save file
nnoremap <leader>w :w<CR>
" Quit
nnoremap <leader>q :q!<CR>

" Stop the highlightin
nnoremap <silent> <leader>nh   :noh<CR>
" Remove unwanted whitespace
nnoremap <silent> <leader>ns   :%s/\s\+$//e<CR> :noh<CR>

" Visual all lines
nnoremap <leader>a ggVG

" Enter visual block mode
nnoremap <C-b> <C-v>

" Complete
inoremap <Nul> <C-n>

" Create scratch buffer
fun! ScratchBuffer()
    bo new
    setlocal bufhidden=wipe buftype=nofile nobuflisted
    " setlocal nomodifiable nomodified
    nnoremap <buffer><silent> <Esc> :bd<CR>
endfun
" Get messages
nnoremap <silent> <leader>m :call ScratchBuffer()<bar> silent put = execute('messages')<CR>
