### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit ice wait'!0'

# Zsh plugins

# load?
zinit light z-shell/H-S-MW
zinit light zsh-users/zsh-completions
zinit light z-shell/F-Sy-H
zinit light zsh-users/zsh-autosuggestions
zinit light olets/zsh-abbr

# Zsh Config
# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000

setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt extended_history

# Completion
autoload -Uz compinit; compinit
autoload -Uz colors; colors

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt auto_param_slash
setopt auto_param_keys

setopt correct
setopt interactive_comments

setopt no_beep

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# . "$HOME/.cargo/env"

# addr alias
# la ls -a
# lla ls -la
# rr rm -rf

abbr -S l='eza -F'
abbr -S ll='eza -Fl'
abbr -S la='eza -Fa'
abbr -S lla='eza -Fla'
abbr -S rr='rm -rf'
abbr -S v='nvim'

clear
