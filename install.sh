#!/bin/bash

# macOS Dev Environment Installation Script
# Automatically installs and configures the development environment

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No color

# Print colored message with emoji
print_message() {
    local color=$1
    local emoji=$2
    local message=$3
    echo -e "${color}${emoji} ${message}${NC}"
}

# Print section header
print_header() {
    local message=$1
    echo
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${PURPLE}  $message${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Backup existing files
backup_file() {
    local file=$1
    if [ -f "$file" ] || [ -d "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        print_message "$YELLOW" "📦" "Creating backup of $file → $backup"
        cp -r "$file" "$backup"
    fi
}

# Create directory if it doesn't exist
ensure_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        print_message "$BLUE" "📁" "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Check for Homebrew and install if missing
check_homebrew() {
    if ! command_exists brew; then
        print_message "$YELLOW" "🍺" "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        
        print_message "$GREEN" "✅" "Homebrew installed successfully!"
    else
        print_message "$GREEN" "✅" "Homebrew already installed"
    fi
}

# Install required dependencies
install_dependencies() {
    print_header "Installing Dependencies"
    
    local deps=(
        "git"
        "curl" 
        "neovim"
        "tmux"
        "fzf"
        "fd"
        "ripgrep"
        "starship"
        "luarocks"
        "node"  # For some LSP servers
        "python3"  # For Python development
        "rust"  # For Rust development
    )
    
    local cask_deps=(
        "ghostty"
        "font-geist-mono-nerd-font"
    )
    
    print_message "$BLUE" "📦" "Installing command-line tools..."
    for dep in "${deps[@]}"; do
        if command_exists "$dep"; then
            print_message "$GREEN" "✅" "$dep is already installed"
        else
            print_message "$YELLOW" "⬇️" "Installing $dep..."
            brew install "$dep"
        fi
    done
    
    # Add font tap if not already added
    brew tap homebrew/cask-fonts 2>/dev/null || true
    
    print_message "$BLUE" "📦" "Installing applications and fonts..."
    for dep in "${cask_deps[@]}"; do
        if brew list --cask "$dep" >/dev/null 2>&1; then
            print_message "$GREEN" "✅" "$dep is already installed"
        else
            print_message "$YELLOW" "⬇️" "Installing $dep..."
            brew install --cask "$dep"
        fi
    done
}

# Install Tmux Plugin Manager
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$tpm_dir" ]; then
        print_message "$BLUE" "⬇️" "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        print_message "$GREEN" "✅" "TPM installed successfully!"
    else
        print_message "$GREEN" "✅" "TPM already installed"
    fi
}

# Install configuration files
install_configs() {
    print_header "Installing Configuration Files"
    
    # Ensure ~/.config exists
    ensure_directory "$HOME/.config"
    
    # Install Ghostty configuration
    if [ -d ".config/ghostty" ]; then
        print_message "$BLUE" "📝" "Installing Ghostty configuration..."
        backup_file "$HOME/.config/ghostty"
        cp -r .config/ghostty "$HOME/.config/"
        print_message "$GREEN" "✅" "Ghostty configuration installed"
    else
        print_message "$RED" "❌" "Ghostty configuration directory not found"
    fi
    
    # Install Neovim configuration
    if [ -d ".config/nvim" ]; then
        print_message "$BLUE" "📝" "Installing Neovim configuration..."
        backup_file "$HOME/.config/nvim"
        cp -r .config/nvim "$HOME/.config/"
        print_message "$GREEN" "✅" "Neovim configuration installed"
    else
        print_message "$RED" "❌" "Neovim configuration directory not found"
    fi
    
    # Install Tmux configuration
    if [ -d ".config/tmux" ]; then
        print_message "$BLUE" "📝" "Installing Tmux configuration..."
        backup_file "$HOME/.config/tmux"
        cp -r .config/tmux "$HOME/.config/"
        print_message "$GREEN" "✅" "Tmux configuration installed"
    else
        print_message "$RED" "❌" "Tmux configuration directory not found"
    fi
    
    # Install Starship configuration
    if [ -f ".config/starship.toml" ]; then
        print_message "$BLUE" "📝" "Installing Starship configuration..."
        backup_file "$HOME/.config/starship.toml"
        cp .config/starship.toml "$HOME/.config/"
        print_message "$GREEN" "✅" "Starship configuration installed"
    else
        print_message "$YELLOW" "⚠️" "Starship configuration not found"
    fi
}

# Install shell configurations
install_shell_configs() {
    print_header "Installing Shell Configuration"
    
    # Backup existing shell files
    backup_file "$HOME/.zshrc"
    
    # Install zsh configuration
    if [ -f "dotfiles/.zshrc" ]; then
        print_message "$BLUE" "📝" "Installing Zsh configuration..."
        # Append to existing .zshrc or create new one
        echo "" >> "$HOME/.zshrc"
        echo "# Added by macos-dev-env installation script" >> "$HOME/.zshrc"
        echo "# $(date)" >> "$HOME/.zshrc"
        cat "dotfiles/.zshrc" >> "$HOME/.zshrc"
        print_message "$GREEN" "✅" "Zsh configuration installed"
    fi
    
    # Install aliases
    if [ -f "dotfiles/.zsh_aliases" ]; then
        print_message "$BLUE" "📝" "Installing Zsh aliases..."
        echo "" >> "$HOME/.zshrc"
        echo "# Aliases and functions from macos-dev-env" >> "$HOME/.zshrc"
        cat "dotfiles/.zsh_aliases" >> "$HOME/.zshrc"
        print_message "$GREEN" "✅" "Zsh aliases installed"
    fi
}

# Set up fzf
setup_fzf() {
    print_message "$BLUE" "🔧" "Setting up FZF..."
    if command_exists fzf; then
        # Run fzf install script for shell integration
        "$(brew --prefix)"/opt/fzf/install --all --no-update-rc
        print_message "$GREEN" "✅" "FZF setup complete"
    fi
}

# Post-installation setup
post_install() {
    print_header "Post-Installation Setup"
    
    # Set Zsh as default shell if it isn't already
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_message "$BLUE" "🐚" "Setting Zsh as default shell..."
        chsh -s "$(which zsh)"
        print_message "$GREEN" "✅" "Zsh set as default shell"
    fi
    
    # Make tmux config executable and set up
    if [ -f "$HOME/.config/tmux/tmux.conf" ]; then
        print_message "$BLUE" "🔧" "Setting up Tmux configuration..."
        # Source the config (this will be done when tmux starts)
        print_message "$GREEN" "✅" "Tmux ready for first use"
    fi
    
    print_message "$CYAN" "💡" "To install Tmux plugins, start tmux and press: Ctrl+Space + I"
}

# Main installation function
main() {
    print_header "macOS Development Environment Installation"
    print_message "$CYAN" "🚀" "Starting installation of development environment..."
    
    # Check if we're in the right directory
    if [ ! -f "install.sh" ]; then
        print_message "$RED" "❌" "Please run this script from the macos-dev-env directory"
        exit 1
    fi
    
    # Check for required directories
    if [ ! -d ".config" ] && [ ! -d "dotfiles" ]; then
        print_message "$RED" "❌" "Configuration directories not found. Are you in the right directory?"
        exit 1
    fi
    
    # Installation steps
    check_homebrew
    install_dependencies
    install_tpm
    install_configs
    install_shell_configs
    setup_fzf
    post_install
    
    print_header "Installation Complete! 🎉"
    print_message "$GREEN" "✅" "Your development environment has been installed successfully!"
    print_message "$CYAN" "💡" "Next steps:"
    echo "   1. Restart your terminal or run: source ~/.zshrc"
    echo "   2. Open Ghostty and enjoy your new terminal setup"
    echo "   3. Start tmux and install plugins with: Ctrl+Space + I"
    echo "   4. Open Neovim and let it download plugins automatically"
    echo "   5. Try the aliases: 'ff' for file finding, 'dff' for directory navigation"
    echo
    print_message "$PURPLE" "🚀" "Happy coding!"
}

# Run the installation
main "$@"
