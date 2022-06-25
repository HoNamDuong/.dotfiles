" Split panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-n> <C-w>w

" Resize split windows using arrow keys
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Next Buffer
nnoremap <silent> <Space>bn   :bn<CR>
" Unload current buffer
nnoremap <silent> <Space>bd   :bd<CR>
" Unload current buffer [!]
nnoremap <silent> <Space>bq  :bd!<CR>

" Save file
nnoremap <Space>w :w<CR>
" Quit
nnoremap <Space>q :q!<CR>

" Stop the highlightin
nnoremap <silent> <Space>nh   :noh<CR>
" Remove unwanted whitespace
nnoremap <silent> <Space>ns   :%s/\s\+$//e<CR> :noh<CR>

" Visual all lines
nnoremap <C-a> ggVG

" Complete
inoremap <Tab> <C-n>
inoremap <S-Tab> <C-p>

" Create scratch buffer
fun! ScratchBuffer()
    bo new
    setlocal bufhidden=wipe buftype=nofile nobuflisted
    " setlocal nomodifiable nomodified
    nnoremap <buffer><silent> <Esc> :bd<CR>
endfun
" Get messages
nnoremap <silent> <Space>m :call ScratchBuffer()<bar> silent put = execute('messages')<CR>
