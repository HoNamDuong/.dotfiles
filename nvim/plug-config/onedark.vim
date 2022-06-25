" Don't set background and foreground color when running in a terminal
" if (has("autocmd") && !has("gui_running"))
    " autocmd ColorScheme * call onedark#set_highlight("Normal", {})
" endif

" Set background, foreground and popup menu color
let g:onedark_color_overrides = {
\ "background": {"gui": "NONE", "cterm": "NONE"},
\ "foreground": {"gui": "#BCC4D1", "cterm": "NONE"},
\ "menu_grey": {"gui":"#15171c", "cterm":"NONE"},
\}

" #1E2127 #abb2bf #e06c75 #98c379 #e5c07b #61afef #c678dd

" Hide end-of-buffer filler lines (~)
let g:onedark_hide_endofbuffer=1
" Comment italics
let g:onedark_terminal_italics=1
" Set theme
colorscheme onedark
