#
# ~/.zshrc (cleaned + organized)
#

# Stop if not interactive
[[ -o interactive ]] || return

########################################
# Homebrew Setup (Apple Silicon / Linux)
########################################
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

###########################
# PATH Additions
###########################
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

########################################
# FZF Theme (viis-ified)
########################################
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#2d2b30,bg:#1a191c,spinner:#9be3ed,hl:#fc808f,gutter:#1a191c \
  --color=fg:#bcb5cb,header:#fc808f,info:#878292,pointer:#9be3ed,border:#878292 \
  --color=marker:#b4befe,fg+:#e2e2e3,prompt:#bcb5cb,hl+:#9be3ed"

########################################
# LS Colors (BSD macOS)
########################################
export CLICOLOR=1
alias ls='ls -G'  # enable color

# Might add a custom palette in the future

########################################
# grep Colors (ggrep if available)
########################################
if command -v ggrep >/dev/null; then
  alias grep='ggrep --color=auto'
else
  alias grep='grep --color=auto'
fi

########################################
# Keybindings (history search)
########################################
bindkey -e
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

########################################
# Aliases File
########################################
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

########################################
# Starship Prompt & zoxide
########################################
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

########################################
# Bun
########################################
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/jack/.bun/_bun" ] && source "/Users/jack/.bun/_bun"
