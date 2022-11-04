" Map leader to Space
let mapleader = " " 

" Window navigation
nnoremap <C-h>      <C-w>h
nnoremap <C-j>      <C-w>j
nnoremap <C-k>      <C-w>k
nnoremap <C-l>      <C-w>l
" Resize with arrows
nnoremap <C-Up>     :resize -2<CR>
nnoremap <C-Down>   :resize +2<CR>
nnoremap <C-Left>   :vertical resize -2<CR>
nnoremap <C-Right>  :vertical resize +2<CR>
" Delete single character without copying into register
nnoremap x      "_x

" Motion cursor
nnoremap <S-h>  ^
nnoremap <S-l>  g_

" Previous
nnoremap <leader>bb    :b#<CR>
" Previous buffer
nnoremap <leader>bp    :bnext<CR>
" Next buffer
nnoremap <leader>bn    :bnext<CR>
" Delete current buffer
nnoremap <leader>bd    :bdelete<CR>
" Delete current buffer [!]
nnoremap <leader>bq    :bd!<CR>

" Save file
nnoremap <leader>w  :w<CR>
" Quit all
nnoremap <leader>q  :qa!<CR>
" Visual all lines
nnoremap <leader>a  ggVG
" Stop the highlightin
nnoremap <leader>h  :noh<CR>
" Toggle wrap
nnoremap <leader>z  :set wrap!<CR>

" Complete
inoremap <Nul>  <C-n>

