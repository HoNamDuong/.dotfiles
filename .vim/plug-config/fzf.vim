" Search file
nnoremap <leader>sf :Files<CR>
" History
nnoremap <leader>sh :History<CR>
" Rg search result
nnoremap <leader>sr :Rg<CR>
" Marks
nnoremap <leader>sm :Marks<CR>
" Commands history
nnoremap <leader>sc :Commands<CR>
" Git commits
nnoremap <leader>sg :Commits<CR>
" Lines in loaded buffers
nnoremap <leader>sl :BLines<CR>
" File types
nnoremap <leader>st :Filetype<CR>
" Command history
nnoremap <leader>s; :History:<CR>
" Config
let $FZF_DEFAULT_OPTS = '--info=inline'
let g:fzf_layout = { 'down': '30%' }
" Hide statusline
autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
