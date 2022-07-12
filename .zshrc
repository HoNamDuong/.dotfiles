# Disable ctrl-s to freeze terminal.
stty stop undef

# Autoload
autoload -U select-word-style
select-word-style bash
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Color
export TERM=xterm-256color

# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "cat {}"'
# export FZF_ALT_C_OPTS='--preview "tree -C {} | head -200"'
# export FZF_ALT_C_COMMAND='rg --hidden --files --sort-files --null --glob "!.git" | xargs -0 dirname | sort -u |  grep ...'
# export FZF_ALT_C_COMMAND='find . -type d | grep ...'
# export FZF_ALT_C_COMMAND='find . -type d | rg -N "^\./\." | grep ...'

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}

# Set tmux
case $- in *i*)
    [ -z "$TMUX" ] && exec tmux
esac



# Autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# Enable only git
zstyle ':vcs_info:*' enable git

# Setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%{$fg[blue]%}[%{$fg[red]%}%m%u%c%{$fg[yellow]%} %{$fg[magenta]%} %b%{$fg[blue]%}]%{$reset_color%} "
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT=' %(?:%B%F{green}➜%f%b :%B%F{red}➜%f%b )%F{blue}%c%f '
# PROMPT='%B%F{green}[%f%b%F{white}%n%f%F{green}@%f%F{green}%M%f%B%F{green}]%f%b %(?:%B%F{green}➜%f%b :%B%F{red}➜%f%b )%F{blue}%~%f '
PROMPT+='${vcs_info_msg_0_}'



# Exports
export EDITOR="vim"
export VISUAL="vim"
# export TERMINAL="alacritty"

setopt AUTO_PUSHD # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT # Do not print the directory stack after pushd or popd.
setopt CORRECT # Spelling correction
setopt CDABLE_VARS # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB # Use extended globbing syntax.

# History in cache directory:
setopt EXTENDED_HISTORY # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY # Share history between all sessions.
setopt MENU_COMPLETE # Automatically highlight first element of completion menu
setopt AUTO_LIST # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD # Complete from both ends of a word.
setopt GLOB_COMPLETE # Show autocompletion menu with globs
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt HIST_VERIFY # Do not execute immediately upon history expansion.

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history



# Basic auto/tab complete:
autoload -U compinit
zmodload zsh/complist
compinit
# Include hidden files.
_comp_options+=(globdots)

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{yellow}[Correction] (errors: %e) %f'
zstyle ':completion:*:descriptions' format ' %F{blue}[Description] %d %f'
zstyle ':completion:*:messages' format ' %F{magenta}[Message] %d %f'
zstyle ':completion:*:warnings' format ' %F{red}[Warning] no matches found %f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{green}[Completion] %d %f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# # Increase the number of errors based on the length of the typed word. But make
# # sure to cap (at 7) the max-errors to avoid hanging.
# zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# # Don't complete unavailable commands.
# zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# # Array completion element sorting.
# zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
eval "$(dircolors ~/.dircolors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# # History
# zstyle ':completion:*:history-words' stop yes
# zstyle ':completion:*:history-words' remove-all-dups yes
# zstyle ':completion:*:history-words' list false
# zstyle ':completion:*:history-words' menu true

# # Environment Variables
# zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# # Ignore multiple entries.
# zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
# zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# # Kill
# zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:*:kill:*' force-list always
# zstyle ':completion:*:*:kill:*' insert-ids single



# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^[' send-break
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.



# Plugins
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.zsh/zsh-autopair/autopair.zsh ] && source ~/.zsh/zsh-autopair/autopair.zsh && autopair-init
[ -f ~/.zsh/z/z.sh ] && . ~/.zsh/z/z.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Bind key
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search
bindkey '^H' backward-kill-word

# Alias
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rm -I -r'
alias mkdir='mkdir -pv'
alias ln='ln -v'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if [ -f /usr/bin/lsd ]; then
    alias ls='lsd -F'
    alias lls='lsd -lF'
    alias la='lsd -aF'
    alias lla='lsd -alF'
    alias tree='lsd -a --tree'
else
    alias ls='ls --color=auto --classify --human-readable --time-style=long-iso --group-directories-first'
    alias lls='ls -l'
    alias la='ls -a'
    alias lla='ls -al'
    alias tree='tree -a -F --dirsfirst -I ".git"'
fi



# Function
create() {
    mkdir -p "$(dirname "$1")" &&
    touch "$1" && echo "touch: created file '$(basename $1)'"
}

open() {
    local file
    file=$(fzf-tmux -d +m --preview "cat {}") &&
    vim $file
}

checkout() {
    local branches branc
    branches=$(git branch) &&
    branch=$(echo "$branches" | fzf-tmux -r 20% --reverse) &&
    git checkout $(echo "$branch" | sed "s/.* //")
}

ShowColors256() {
    local row col blockrow blockcol red green blue
    local showcolor=_showcolor256_${1:-bg}
    local white="\033[1;37m"
    local reset="\033[0m"

    echo -e "Set foreground color: \\\\033[38;5;${white}NNN${reset}m"
    echo -e "Set background color: \\\\033[48;5;${white}NNN${reset}m"
    echo -e "Reset color & style:  \\\\033[0m"
    echo

    echo 16 standard color codes:
    for row in {0..1}; do
        for col in {0..7}; do
            $showcolor $(( row*8 + col )) $row
        done
        echo
    done
    echo

    echo 6·6·6 RGB color codes:
    for blockrow in {0..2}; do
        for red in {0..5}; do
            for blockcol in {0..1}; do
                green=$(( blockrow*2 + blockcol ))
                for blue in {0..5}; do
                    $showcolor $(( red*36 + green*6 + blue + 16 )) $green
                done
                echo -n "  "
            done
            echo
        done
        echo
    done

    echo 24 grayscale color codes:
    for row in {0..1}; do
        for col in {0..11}; do
            $showcolor $(( row*12 + col + 232 )) $row
        done
        echo
    done
    echo
}

_showcolor256_fg() {
    local code=$( printf %03d $1 )
    echo -ne "\033[38;5;${code}m"
    echo -nE " $code "
    echo -ne "\033[0m"
}

_showcolor256_bg() {
    if (( $2 % 2 == 0 )); then
        echo -ne "\033[1;37m"
    else
        echo -ne "\033[0;30m"
    fi
    local code=$( printf %03d $1 )
    echo -ne "\033[48;5;${code}m"
    echo -nE " $code "
    echo -ne "\033[0m"
}

man() {
    LESS_TERMCAP_mb=$'\e[1;32m'\
    LESS_TERMCAP_md=$'\e[1;32m'\
    LESS_TERMCAP_me=$'\e[0m'\
    LESS_TERMCAP_se=$'\e[0m'\
    LESS_TERMCAP_so=$'\e[01;33m'\
    LESS_TERMCAP_ue=$'\e[0m'\
    LESS_TERMCAP_us=$'\e[1;4;31m'\
    command man "$@"
}
