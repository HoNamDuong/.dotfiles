function! airline#themes#onedark#refresh()

    let g:airline#themes#onedark#palette = {}

    let g:airline#themes#onedark#palette.accents = {
        \ 'red': [ '#E06C75', '', '', 0 ]
        \ }

    let s:N1 = [ '#1E2127', '#98c379', '', '' ]
    let s:N2 = [ '#ABB2BF', 'NONE', '', '' ]
    let s:N3 = [ '#98c379', 'NONE', '', '' ]
    let g:airline#themes#onedark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3, s:N3, s:N2, s:N3)
    let g:airline#themes#onedark#palette.normal.airline_term = [s:N1[1], s:N1[0], '', '']
    let g:airline#themes#onedark#palette.normal_modified = {
        \ 'airline_c': [ '#61afef' , '' , '' , '' , '' ] ,
        \ }

    let s:I1 = [ '#1E2127', '#61afef', '', '' ]
    let s:I2 = s:N2
    let s:I3 = [ '#61afef', 'NONE', '', '' ]
    let g:airline#themes#onedark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3, s:I3, s:I2, s:I3)


    let s:R1 = [ '#1E2127', '#E06C75', '', '' ]
    let s:R2 = s:N2
    let s:R3 = [ '#E06C75', 'NONE', '', '' ]
    let g:airline#themes#onedark#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3, s:R3, s:R2, s:R3)


    let s:V1 = [ '#1E2127', '#C678DD', '', '' ]
    let s:V2 = s:N2
    let s:V3 = [ '#C678DD', 'NONE', '', '' ]
    let g:airline#themes#onedark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3, s:V3, s:V2, s:V3)
    let g:airline#themes#onedark#palette.visual.airline_term = [s:V1[1], s:V1[0], '', '']


    let s:C1 = [ '#1E2127', '#E5C07B', '', '' ]
    let s:C2 = s:N2
    let s:C3 = [ '#E5C07B', 'NONE', '', '' ]
    let g:airline#themes#onedark#palette.commandline = airline#themes#generate_color_map(s:C1, s:C2, s:C3, s:C3, s:C2, s:C3)
    let g:airline#themes#onedark#palette.commandline.airline_term = [s:C1[1], s:C1[0], '', '']


    let s:T1 = [ '#1E2127', '#E06C75', '', '' ]
    let s:T2 = s:N2
    let s:T3 = [ '#E06C75', 'NONE', '', '' ]
    let g:airline#themes#onedark#palette.terminal = airline#themes#generate_color_map(s:T1, s:T2, s:T3)
    let g:airline#themes#onedark#palette.terminal.airline_term = [s:T1[1], s:T1[0], '', '']


    let s:IA1 = [ '#1E2127', '#ABB2BF', '', '' ]
    let s:IA2 = [ '#ABB2BF', 'NONE', '', '' ]
    let s:IA3 = s:N2
    let g:airline#themes#onedark#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
    let g:airline#themes#onedark#palette.inactive.airline_term = [s:IA1[1], s:IA1[0], '', '']
    let g:airline#themes#onedark#palette.inactive_modified = {
        \ 'airline_c': [ '#61afef' , '' , '' , '' , '' ] ,
        \ }


    let s:WI = [ '#1E2127', '#E5C07B', '', '' ]
    let g:airline#themes#onedark#palette.normal.airline_warning = [
       \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
       \ ]
    let g:airline#themes#onedark#palette.normal_modified.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning
    let g:airline#themes#onedark#palette.insert.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning
    let g:airline#themes#onedark#palette.visual.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning
    let g:airline#themes#onedark#palette.replace.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning
    let g:airline#themes#onedark#palette.commandline.airline_warning =
      \ g:airline#themes#onedark#palette.normal.airline_warning


    let s:ER = [ '#1E2127', '#E06C75', '', '' ]
    let g:airline#themes#onedark#palette.normal.airline_error = [
       \ s:ER[0], s:ER[1], s:ER[2], s:ER[3]
       \ ]
    let g:airline#themes#onedark#palette.normal_modified.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error
    let g:airline#themes#onedark#palette.insert.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error
    let g:airline#themes#onedark#palette.visual.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error
    let g:airline#themes#onedark#palette.replace.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error
    let g:airline#themes#onedark#palette.commandline.airline_error =
      \ g:airline#themes#onedark#palette.normal.airline_error

endfunction

call airline#themes#onedark#refresh()
