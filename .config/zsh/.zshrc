# Alias
alias cp='cp --interactive --verbose'
alias mv='mv --interactive --verbose'
alias rm='rm --interactive --verbose'
alias rmdir='rm --interactive=once --recursive'
alias mkdir='mkdir --parents --verbose'
alias ln='ln --verbose'
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

if [ -f /usr/bin/lsd ]; then
    alias ls='lsd --classify'
    alias lls='lsd --long --classify'
    alias la='lsd --all --classify'
    alias lla='lsd --long --all --classify'
    alias tree='lsd --all --tree --ignore-glob .git'
else
    alias ls='ls --color=auto --classify --human-readable --time-style=long-iso --group-directories-first'
    alias lls='ls --long'
    alias la='ls --all'
    alias lla='ls --long --all'
fi

if [ -f /usr/bin/bat ]; then
    alias bat='bat --paging=never --wrap=auto'
fi

# Make dir
[ ! -d $HOME/.cache/zsh ] && mkdir -v $HOME/.cache/zsh

# Options
setopt PROMPT_SUBST # Parameter expansion, command substitution and arithmetic expansion are performed in prompts. 
setopt SHARE_HISTORY # Share history between all sessions.
setopt MENU_COMPLETE # Automatically highlight first element of completion menu
setopt GLOB_COMPLETE # Trigger the completion after a glob * instead of expanding it.
setopt CORRECT # Spelling correction
setopt HIST_IGNORE_DUPS # Do not record an event that was just recorded again.
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/.zsh_history

# Prompt
autoload -Uz vcs_info
precmd () { vcs_info }
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats        '%F{blue}[%F{yellow}%s %F{magenta}%b %F{green}%c%F{red}%u%F{blue}]%f '
zstyle ':vcs_info:*' actionformats  '%F{blue}[%F{yellow}%s %F{magenta}%b %F{green}%c%F{red}%u%F{cyan}%a%F{blue}]%f '
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
        hook_com[unstaged]+='?'
    fi
}
PROMPT=' %F{blue}%c%f '
PROMPT+='${vcs_info_msg_0_}'
PROMPT+='%(?.%F{green}%#%f.%F{red}%? %#%f) '
RPROMPT='%F{white}%*%f'

# Load directories
eval "$(dircolors ~/.dircolors)"

# Basic auto/tab complete
autoload -Uz compinit; compinit -d ~/.cache/zsh/.zcompdump
# Include hidden files.
_comp_options+=(globdots)
# The completion menu
zstyle ':completion:*' menu select
# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _extensions _complete _match _approximate
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
# Formatting the display
zstyle ':completion:*:corrections' format '%F{yellow}[%d]%f' 
zstyle ':completion:*:descriptions' format '%F{blue}[%d]%f' 
zstyle ':completion:*:messages' format '%F{magenta}[%d]%f' 
zstyle ':completion:*:warnings' format '%F{red}[%d]%f' 
# Colors for files and directory
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Plugins
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autopair/autopair.zsh ] && source /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh 
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

# FZF
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_DEFAULT_OPTS="--reverse --border --multi --info=inline --no-separator --bind='ctrl-/:toggle-preview' --color='bg:black,bg+:black,fg:white,fg+:bright-white,info:yellow,border:bright-black,spinner:yellow,header:blue,pointer:magenta,marker:cyan,prompt:magenta,hl:green,hl+:bright-green'"
export FZF_CTRL_T_COMMAND='fd --hidden --follow'
export FZF_CTRL_T_OPTS="--prompt='FILE/DIR ' --preview='(bat --style=numbers --color=always {} || tree -C {}) 2> /dev/null'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow" 
export FZF_ALT_C_OPTS="--prompt='DIRECTORY ' --preview='tree -C {}'"
export FZF_CTRL_R_OPTS="--prompt='HISTORY ' --preview-window=hidden"
_fzf_compgen_path() { fd --hidden --follow . "$1"; }
_fzf_compgen_dir() { fd --type d --hidden --follow . "$1"; }

# Key bindings 
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

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[1;5A' up-line-or-beginning-search
bindkey '^[[1;5B' down-line-or-beginning-search

bindkey '^W' backward-kill-word
bindkey '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete

# Disable ctrl-s to freeze terminal.
stty stop undef

# Show last command name
preexec() { print -Pn "\e]0;$1\a" }
