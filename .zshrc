# Disable ctrl-s to freeze terminal.
stty stop undef

# # Set tmux
# case $- in *i*)
#     [ -z "$TMUX" ] && exec tmux
# esac

# Autoload
autoload -U select-word-style
select-word-style bash
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
autoload -U colors && colors

# Exports
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export EDITOR="nvim"
export VISUAL="nvim"
if [ "$TERM" != "xterm-256color" ]; then
    export TERM=xterm-256color
fi



# Prompt
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%F{blue}[%F{green}%c%F{red}%u %F{yellow} %F{magenta}%b%F{blue}]%f '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
        hook_com[unstaged]+='?'
    fi
}

setopt prompt_subst
PROMPT=' %(?:%B%F{green}➜%f%b :%B%F{red}➜%f%b )%F{blue}%c%f '
PROMPT+='${vcs_info_msg_0_}'
RPROMPT='%B%F{8}%*%f%b'



# Options
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
# Directories
eval "$(dircolors ~/.dircolors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true



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

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done



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
    alias tree='lsd -a --tree --ignore-glob .git'
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
    nvim $file
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
