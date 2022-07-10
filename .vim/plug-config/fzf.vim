" This is the default extra key bindings
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
" Search file
nnoremap <leader>ff :Files<CR>
" History
nnoremap <leader>fh :History<CR>
" Open buffers
nnoremap <leader>fb :Buffers<CR>
" Rg search result
nnoremap <leader>fr :Rg<CR>
" Marks
nnoremap <leader>fm :Marks<CR>
" Commands history
nnoremap <leader>fc :Commands<CR>
" Lines in loaded buffers
nnoremap <leader>fl :BLines<CR>
" File types
nnoremap <leader>fy :Filetype<CR>
" Command history
nnoremap <leader>f; :History:<CR>

" Config
let $FZF_DEFAULT_OPTS = '--info=inline'
let g:fzf_layout = { 'down': '30%' }
" Hide statusline
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
