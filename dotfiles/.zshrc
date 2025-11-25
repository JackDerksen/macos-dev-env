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
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

########################################
# Custom ls2 Command (paginated)
########################################
ls2() {
    setopt localoptions NULL_GLOB

    # ANSI Color Codes
    local C_RESET=$'\e[0m'
    local C_DIR=$'\e[1;34m'   # Bold blue for directories
    local C_EXEC=$'\e[1;31m'  # Bold red for executable
    local C_FILE=$'\e[0m'     # Default white/gray for files

    # Icons
    local I_DIR=""
    local I_EXEC=""
    local I_FILE=""

    local target="${1:-.}"
    target="${target%/}"

    if [[ ! -e "$target" ]]; then
        echo "ls2: cannot access '$target': No such file or directory"
        return 1
    fi

    local raw_items=( "$target"/*(N) )
    local count=${#raw_items[@]}
    (( count == 0 )) && { echo "No items in directory."; return; }

    local per_page=40
    local page=1
    local total_pages=$(( (count + per_page - 1) / per_page ))

    while (( page <= total_pages )); do
        local start=$(( (page - 1) * per_page ))
        local end=$(( start + per_page ))
        (( end > count )) && end=$count
        local length=$(( end - start ))

        local page_raw=("${raw_items[@]:$start:$length}")

        # Parallel arrays: one for the string to print, one for its length
        local page_disp=()
        local page_lens=()
        local max_len=0

        for item in "${page_raw[@]}"; do
            local fname="${item:t}"
            local display_str=""
            local visible_len=0

            # Determine type, icon, and color
            if [[ -d "$item" ]]; then
                display_str="${I_DIR} ${C_DIR}${fname}${C_RESET}"
            elif [[ -x "$item" ]]; then
                display_str="${I_EXEC} ${C_EXEC}${fname}${C_RESET}"
            else
                display_str="${I_FILE} ${C_FILE}${fname}${C_RESET}"
            fi

            # Calculate visible length: Icon (1) + Space (1) + Name length
            # Note: If your icons are double-width glyphs, change the '2' to '3'
            visible_len=$(( 2 + ${#fname} ))

            # Update Max Length for this page
            (( visible_len > max_len )) && max_len=$visible_len

            page_disp+=("$display_str")
            page_lens+=("$visible_len")
        done

        # Calculate padding (add a little breathing room)
        local pad=$(( max_len + 4 ))

        # Split both arrays (Display and Lengths)
        local half=$(( ( ${#page_disp[@]} + 1 ) / 2 ))

        local left_disp=("${page_disp[@]:0:$half}")
        local left_lens=("${page_lens[@]:0:$half}")

        local right_start=$half
        local right_length=$(( ${#page_disp[@]} - half ))

        local right_disp=("${page_disp[@]:$right_start:$right_length}")
        # We don't strictly need right_lens for printing, just left

        # Print Loop
        local rows=${#left_disp[@]}
        for ((i=1; i<=rows; i++)); do
            # 1. Print the Left Item
            printf "%s" "${left_disp[$i]}"

            # 2. Manually calculate spaces needed for alignment
            #    (Total Pad Width) - (This Item's Visible Width)
            local spaces_needed=$(( pad - ${left_lens[$i]} ))

            # 3. Zsh 'repeat' keyword makes this easy
            repeat $spaces_needed printf " "

            # 4. Print the Right Item
            printf "%s" "${right_disp[$i]}"
            echo
        done

        (( page++ ))
        if (( page <= total_pages )); then
            echo
            printf "Press Enter for next page... "
            read -r
            echo
        fi
    done
}

########################################
# FZF Theme (sonokai-ified)
########################################
export FZF_DEFAULT_OPTS=" \
--color=bg+:-1,bg:-1,spinner:#76CCE0,hl:#FC5D7C,gutter:-1 \
--color=fg:#595F6F,header:#FC5D7C,info:#595F6F,pointer:#76CCE0,border:#595F6F \
--color=marker:#B39DF3,fg+:#9CABCA,prompt:#595F6F,hl+:#76CCE0"

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
