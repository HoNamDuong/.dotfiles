" Split panes to left/bottom/top/right
nnoremap <C-h> <C-w>H
nnoremap <C-j> <C-w>J
nnoremap <C-k> <C-w>K
nnoremap <C-l> <C-w>L

" Resize split windows using arrow keys
noremap <A-Up> <c-w>+
noremap <A-Down> <c-w>-
noremap <A-Left> <c-w>>
noremap <A-Right> <c-w><

" Between panes to left/bottom/top/right
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" Window next
nnoremap <A-n> <C-w>w
" Close current window
nnoremap <A-c> <C-w>c
" Only window
nnoremap <A-o> <C-w>o

" Rnavigate windows
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
tnoremap <A-n> <C-\><C-N><C-w>w
" Quit Terminal mode
tnoremap <leader><leader> <C-\><C-n>

" Next Buffer
nnoremap <silent> <Space>bn   :bn<CR>
" Unload current buffer
nnoremap <silent> <Space>bd   :bd<CR>
" Unload current buffer [!]
nnoremap <silent> <Space>bq  :bd!<CR>

" Stop the highlightin
nnoremap <silent> <Space>nh   :noh<CR>
" Remove unwanted whitespace
nnoremap <silent> <Space>ns   :%s/\s\+$//e<CR> :noh<CR>

" Save file
nnoremap <Space>w :w<CR>
" Quit
nnoremap <Space>q :q!<CR>
" Visual all lines
nnoremap <C-a> ggVG

" Create scratch buffer
fun! ScratchBuffer()
    bo new
    setlocal bufhidden=wipe buftype=nofile nobuflisted
    " setlocal nomodifiable nomodified
    nnoremap <buffer><silent> <Esc> :bd<CR>
endfun
" Get messages
nnoremap <silent> <Space>m :call ScratchBuffer()<bar> silent put = execute('messages')<CR>
" Get register
nnoremap <silent> <Space>r :call ScratchBuffer()<bar> silent put = execute('register')<CR>

" Terminal
nnoremap <silent> <Space>tt :bo 10new term://zsh<CR>i
" Run python file
" nnoremap <silent> <Space>tr :w <bar> cd %:h <bar> bo sp <bar> terminal python %<CR>i
