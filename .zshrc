#
# ~/.zshrc
#

# If not running interactively, bail early
[[ -o interactive ]] || return

# Homebrew (macOS Apple Silicon default). Falls back to Linuxbrew if present.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# PATH
export PATH="$HOME/bin:$PATH"

# FZF theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:-1,bg:-1,spinner:#76CCE0,hl:#FC5D7C,gutter:-1 \
--color=fg:#595F6F,header:#FC5D7C,info:#595F6F,pointer:#76CCE0,border:#595F6F \
--color=marker:#B39DF3,fg+:#9CABCA,prompt:#595F6F,hl+:#76CCE0"

# Prompt (zsh uses PROMPT, with % escapes)
# Example: current dir on first line, Sonokai-ish arrow on second.
# Commented-out because I'm now using Starship instead!
# PROMPT=$'\n%F{8}%B%~%b%f\n%F{5}~❯%f '

# File colour fixes
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Keybindings: search history with ↑/↓ starting from current prefix
bindkey -e
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# Works in most terminals:
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
# And for good measure, if $key[...] is set:
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

# Aliases & functions
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# macOS ls coloring (BSD ls uses -G; GNU-style --color isn't portable here)
export CLICOLOR=1
alias ls='ls -G'

# grep color: works if you `brew install grep` (ggrep). Otherwise this may be ignored.
if command -v ggrep >/dev/null; then
  alias grep='ggrep --color=auto'
else
  alias grep='grep --color=auto'  # OK on many macOS versions; harmless if ignored
fi

eval "$(starship init zsh)"
