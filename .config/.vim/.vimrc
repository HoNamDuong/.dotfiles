" Settings
source $HOME/.vim/settings.vim
" Mappings
source $HOME/.vim/mappings.vim
" Statusline
source $HOME/.vim/statusline.vim
" Call plugin
source $HOME/.vim/plugins.vim
" Plugin config
source $HOME/.vim/plug-config/onedark.vim
source $HOME/.vim/plug-config/nerdtree.vim
source $HOME/.vim/plug-config/nerdcommenter.vim
source $HOME/.vim/plug-config/fzf.vim
source $HOME/.vim/plug-config/buftabline.vim
" Auto format code when save file
au BufWrite * :Prettier
