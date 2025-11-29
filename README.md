# My macOS Dev Environment
## My complete development setup for macOS - tools, configs, and workflow

So, I recently bought a MacBook...

This repository contains my updated development environment configuration for macOS, featuring a modern terminal setup with Ghostty, a fully customized Neovim configuration, and a streamlined workflow using Tmux and various CLI tools. Everything is themed with the beautiful Sonokai colorscheme.

## 🛠️ Tools & Technologies

<img width="5120" height="2880" alt="CleanShot 2025-10-24 at 21 33 11@2x" src="https://github.com/user-attachments/assets/d45bbf6d-ccd0-496e-ba9e-1e8d8e48e0e4" />

### Terminal & Shell
- **[Ghostty](https://ghostty.org/)** - Modern, fast GPU-accelerated terminal emulator. Probably the best one out there right now
- **[Starship](https://starship.rs/)** - Just a nice cross-shell prompt that's easy to customize
- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer for session management. Customized with sane keybinds and a nice status bar

### Editor & Development
- **[Neovim](https://neovim.io/)** - Fully customized with Lazy.nvim plugin manager and a carefully-curated set of plugins. No off-the-shelf Neovim configuration here!

### Productivity Tools
- **[FZF](https://github.com/junegunn/fzf)** - Command-line file fuzzy finder
- **[FD](https://github.com/sharkdp/fd)** - Command-line directory fuzzy finder. Fast alternative to `find`
- **[Ripgrep](https://github.com/BurntSushi/ripgrep)** - Fast text search tool

<img width="5120" height="2880" alt="CleanShot 2025-10-24 at 21 35 20@2x" src="https://github.com/user-attachments/assets/249099fa-3199-4dcc-9c3b-e4e5c4bd1a15" />

## 📁 Config Structure

```
.config/
├── ghostty/          # Ghostty config
│   ├── config        # Main Ghostty settings configuration
│   └── themes/       # Custom color schemes
│       └── sonokai   # Sonokai theme configuration file
├── nvim/             # Neovim config
│   ├── init.lua      # Entry point
│   ├── lua/
│   │   ├── config/   # Core configurations
│   │   ├── plugins/  # Plugin specifications
│   │   └── utils/    # Utility functions
│   └── lazy-lock.json
├── tmux/             # Tmux configuration
│   └── tmux.conf     # Main tmux config
└── starship.toml     # Starship prompt config

dotfiles/
├── .zshrc           # Zsh configuration
└── .zsh_aliases     # Custom aliases and functions
```

## ✨ Key Features

### Neovim Configuration
My Neovim setup is built around productivity and speed, featuring:

- **LSP Integration** - Full language server support with Mason
- **Smart Completion** - nvim-cmp with multiple sources
- **Git Integration** - Gitsigns for change tracking and Git operations
- **File Management** - Oil.nvim for intuitive file system editing
- **Quick Navigation** - Harpoon for instant file switching
- **Beautiful UI** - Custom Heirline statusline with mode indicators
- **Code Formatting** - Conform.nvim with automatic formatting on save

<img width="5120" height="2880" alt="CleanShot 2025-10-24 at 21 37 47@2x" src="https://github.com/user-attachments/assets/ee23695f-4303-4ce7-b652-84142410526c" />
<img width="5120" height="2880" alt="CleanShot 2025-10-24 at 21 39 37@2x" src="https://github.com/user-attachments/assets/a395f29b-a5f6-4f7e-8b1e-b0bcfd391e40" />

### Terminal Experience
- **Ghostty Terminal** - Hardware-accelerated terminal emulator with custom Sonokai theme
- **Starship Prompt** - Clean, fast, informative prompt
- **Tmux Integration** - Seamless navigation between vim and tmux panes
- **Smart Aliases** - Productivity-focused shortcuts and functions (also just because I'm lazy)

### Workflow Highlights

#### Quick File Access
```bash
# Fuzzy find a file and automatically open it in Neovim
ff

# Fuzzy navigate to a directory
dff
```




#### Tmux Session Management
```bash
# Create new session
tn project-name

# List existing sessions
tls

# Attach to existing session  
ta project-name

# Kill session
tk project-name
```

#### Development Workflow Example
1. `dff` to navigate to project directory
2. `tn project` to start a new tmux session
3. Create focused windows for different tasks (coding, testing, etc.)
4. Use `<leader>e` in Neovim to open Oil file explorer
5. `<leader><leader>` for fuzzy file finding
6. `<leader>h` to access Harpoon quick menu

## 🎨 Theme: Sonokai

My entire environment uses the lovely Sonokai theme for consistency:
- **Ghostty** - Custom Sonokai terminal colors
- **Neovim** - Sonokai colorscheme with custom highlights
- **Tmux** - Matching status bar colors. Muted so they aren't overwhelming!
- **FZF** - Themed fuzzy finder interface


## 📦 Plugin Highlights

### Neovim Plugins
| Plugin | Purpose |
|--------|---------|
| **lazy.nvim** | Modern plugin manager |
| **mason.nvim + lspconfig** | LSP management and configuration |
| **nvim-cmp + sources** | Intelligent code completion |
| **conform.nvim** | Code formatting with multiple formatters |
| **gitsigns.nvim** | Git integration and change indicators |
| **harpoon** | Quick file navigation and bookmarking |
| **oil.nvim** | File system editing as text |
| **telescope.nvim** | Fuzzy finder for everything |
| **treesitter** | Syntax highlighting and code understanding |
| **trouble.nvim** | Better diagnostics and error management |
| **heirline.nvim** | Highly customizable statusline |

### Tmux Plugins
- **TPM** - Tmux plugin manager
- **tmux-sensible** - Sensible defaults
- **tmux-yank** - Copy to system clipboard
- **tmux-resurrect** - Save and restore sessions
- **vim-tmux-navigator** - Seamless vim/tmux navigation

## 🚀 Installation

### Prerequisites
Ensure you have these tools installed:

```bash
# Install Homebrew if you haven't already
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install git curl neovim tmux fzf fd ripgrep starship
brew install --cask ghostty

# Install a Nerd Font (required for icons)
brew tap homebrew/cask-fonts
brew install --cask font-geist-mono-nerd-font
```

### Automatic Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/JackDerksen/macos-dev-env.git
   cd macos-dev-env
   ```

2. **Run the installation script:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

4. **Set up Tmux plugins:**
   ```bash
   # Start tmux
   tmux
   
   # Install TPM plugins (in tmux session)
   # Press: Ctrl+Space + I
   ```

### Manual Setup (Optional)

If you prefer manual installation:

1. **Copy configurations:**
   ```bash
   cp -r .config/* ~/.config/
   cat dotfiles/.zshrc >> ~/.zshrc
   cat dotfiles/.zsh_aliases >> ~/.zshrc
   ```

2. **Install Tmux Plugin Manager:**
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

## ⚡ Notable Key Bindings

### Neovim
- `<Space>` - Leader key
- `<leader>e` - Toggle Oil file explorer
- `<leader><leader>` - Telescope find files
- `<leader>sg` - Telescope live grep
- `<leader>h` - Harpoon quick menu
- `<leader>H` - Add file to Harpoon
- `<leader>1-5` - Navigate to Harpoon file 1-5
- `<leader>ar` - Find out for yourself ;)

### Tmux
- `Ctrl+Space` - Prefix key
- `Prefix + |` - Split window vertically
- `Prefix + -` - Split window horizontally
- `Prefix + r` - Reload tmux config
- `Alt+H/L` - Switch between windows
- `Ctrl+h/j/k/l` - Navigate between vim/tmux panes

### Terminal Aliases
- `ff` - Fuzzy find and open file in Neovim
- `dff` - Fuzzy find and change to directory
- `vim` → `nvim` - Muscle memory override
- `cls` → `clear` - Windows did something right? I like 'cls' better
- `gs` → `git status` - Quick git status

## 🔧 Customization

### Adding Your Own Aliases
Edit `dotfiles/.zsh_aliases` and add your custom functions:

```bash
# Example: Quick project navigation
proj() {
  cd ~/Projects/"$1" && tn "$1"
}
```

### Modifying Neovim Configuration
The modular structure makes it easy to customize:
- **Keymaps:** Edit `lua/config/keymaps.lua`
- **Options:** Modify `lua/config/options.lua`
- **Plugins:** Add new plugins in `lua/plugins/`
- **LSP:** Configure language servers in `lua/config/lsp.lua`

### Theme Customization
To change from Sonokai to another theme:
1. Update the Ghostty theme in `.config/ghostty/themes/`
2. Change the Neovim colorscheme in `lua/plugins/colors.lua`
3. Adjust Tmux colors in `tmux/tmux.conf`

## 🤝 Contributing

I don't necessarily want anyone contributing to or modifying this particular repo, as it's meant to show my own personal preferences (unless you see a way I can optimize the setup 👀).
However, you should obviously feel free to fork it and modify things to your liking!

## 📝 Notes

- This configuration is optimized for software development with a focus on web technologies, Python, Rust, and C/C++
- Some plugins may require additional language-specific tools (installed via Mason)
- The configuration prioritizes performance and minimalism while maintaining powerful functionality

---

Happy coding! 🚀
