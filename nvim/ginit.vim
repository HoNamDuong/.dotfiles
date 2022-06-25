" Set size windown
" C:\tools\neovim\Neovim\bin\nvim-qt.exe -qwindowgeometry 869x745

" Disable qt popup
GuiPopupmenu 0
" Enable line
GuiLinespace 1
" Disable qt tab line
GuiTabline 0
" Set line space
GuiLinespace 0
" Set font
Guifont! Hack\ NF:h15

" Set key map to paste
inoremap <silent> <S-Insert> <C-R>+
cnoremap <S-Insert> <C-R>+
" Set Fullscreen
nnoremap <F11> :<C-U>call GuiWindowFullScreen(!g:GuiWindowFullScreen)<CR>

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
