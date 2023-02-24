" Show the status on the second to last line.
set laststatus=2
" Clear status line when vimrc is reloaded.
set statusline=
" Status line left side.
set statusline+=\ %{sy#repo#get_stats_decorated()}
set statusline+=\ %<%F\ %m\ %H\ %R
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\%{&filetype!=#''?&filetype:'none'}
set statusline+=\ \|\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \|\ %{&fileformat}
set statusline+=\ %l\/%L\ 
