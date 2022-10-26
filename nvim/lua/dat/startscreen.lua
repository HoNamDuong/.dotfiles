vim.cmd([[ 
fun! Start()
    " don't show MRU if the command line indicated a file to open
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif
    " Start a new buffer ...
    enew
    " ... and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ norelativenumber
    " Now we can just write to the buffer, whatever you want.
    call append(0,[
                \ "",
                \ "                                W e l c o m e  t o",
                \ "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                \ "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                \ "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                \ "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                \ "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                \ "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                \ "",
                \ "    [N] New file",
                \ "    [P] Projext",
                \ "    [H] History",
                \ "    [V] Config Nvim",
                \ "    [C] Check Health",
                \ "    [Q] Quit"
                \])
    " Some margin for readability
    :silent %>>
    " Go to line 1
    :0
    " No modifications to this buffer
    setlocal nomodifiable nomodified
    " Key map
    nnoremap <buffer><silent> n :enew<CR>
    nnoremap <buffer><silent> p :Telescope project display_type=full<CR>
    nnoremap <buffer><silent> h :Telescope oldfiles<CR>
    nnoremap <buffer><silent> v :e $MYVIMRC<CR>
    nnoremap <buffer><silent> c :checkhealth<CR>
    nnoremap <buffer><silent> q :q!<CR>
endfun
autocmd VimEnter * call Start()
]])
