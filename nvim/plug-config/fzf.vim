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
" Tags in the project
nnoremap <leader>ft :Tags<CR>
" Marks
nnoremap <leader>fm :Marks<CR>
" Commands history
nnoremap <leader>fc :Commands<CR>
" Git commits
nnoremap <leader>fg :Commits<CR>
" Lines in loaded buffers
nnoremap <leader>fl :BLines<CR>
" File types
nnoremap <leader>fy :Filetype<CR>
" Command history
nnoremap <leader>f; :History:<CR>

" Empty value to disable preview window altogether
" let g:fzf_preview_window = []
" Config
let $FZF_DEFAULT_OPTS = '--info=inline'
let $BAT_STYLE="plain"
let $BAT_THEME='TwoDark'
let g:fzf_layout = { 'down': '30%' }
" Hide statusline
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%h%d | %C(#E5C07B)(%ar)%C(reset) %s %C(#61AFEF)<%an%C(reset)"'

" History files will be stored in the specified directory
let g:fzf_history_dir = '~/.config/nvim-data/fzf-history'
