" Clear status line when vimrc is reloaded.
set statusline=
" Status line left side.
set statusline+=\ %H\ %F\ %m\ %R
" Use a divider to separate the left side from the right side.
set statusline+=%=
" Status line right side.
set statusline+=\ %y\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]
set statusline+=\ %l\/%L
" Show the status on the second to last line.
set laststatus=2
