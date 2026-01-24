# My macOS Dev Environment
## My complete development setup for macOS - tools, configs, and workflow

So, I recently bought a MacBook...

This repository contains my updated development environment configuration for macOS, featuring a modern and powerful terminal setup with Ghostty, a fully customized Neovim configuration, and various CLI tools like my custom 'ls' command alternative. Everything is themed with my own custom 'viis' colorscheme. Looks pretty nice, I've gotta say 😉

## 🛠️ Tools & Technologies

<img width="5120" height="2824" alt="CleanShot 2026-01-23 at 21 03 37@2x" src="https://github.com/user-attachments/assets/3f4c6268-6b06-47af-9afb-0463516b9904" />

### Terminal & Shell
- **[Ghostty](https://ghostty.org/)** - Modern, fast GPU-accelerated terminal emulator. Probably the best one out there right now. Currently have it defined with a vim keymap that I'm testing out.
- **[Starship](https://starship.rs/)** - Just a nice, lightweight cross-shell prompt that's easy to customize.
- **[Tmux](https://github.com/tmux/tmux)** - I'm honestly not using Tmux much anymore, as I'm trying to give Ghostty's native session/window management systems a shot. Liking them A LOT so far!
- ...all on top of good ol' zsh.

### Editor & Development
- **[Neovim](https://neovim.io/)** - Fully customized with Lazy.nvim plugin manager and a carefully-curated set of plugins. No off-the-shelf Neovim configuration here!
- **[Zed](https://zed.dev/)** - For when I need a bit more power than Neovim can provide. Ported over my custom theme because I like it so much.

### Productivity Tools
- **[lx-cli](https://github.com/JackDerksen/lx-cli)** - lx is my custom alternative to the traditional `ls` command, with nicer formatting and lots of customization options.
- **[FZF](https://github.com/junegunn/fzf)** - Command-line file fuzzy finder.
- **[FD](https://github.com/sharkdp/fd)** - Command-line directory fuzzy finder. Fast alternative to `find`.

<img width="5120" height="2824" alt="CleanShot 2026-01-11 at 20 08 20@2x" src="https://github.com/user-attachments/assets/9ee3cc75-a238-4a20-a7ab-3da4a28c9125" />

## 📁 Config Structure

```
.config/
├── ghostty/               # Ghostty config
│   ├── config             # Main Ghostty settings configuration
│   └── themes/            # Custom color schemes
│       └── viis           # Bespoke 'viis' theme config file
├── nvim/                  # Neovim config
│   ├── init.lua           # Entry point
│   ├── lua/
│   │   ├── colorschemes/  # Custom colorscheme config because I'm too lazy to make an actual plugin
│   │   ├── config/        # Core configurations
│   │   ├── plugins/       # Plugin specifications
│   │   └── utils/         # Utility functions
│   └── lazy-lock.json
├── lx/                    # lx-cli configuration
│   └── config             # lx-cli config file
├── fastfetch/             # FastFetch configuration
│   └── config.jsonc       # FastFetch config file
├── tmux/                  # Tmux configuration
│   └── tmux.conf          # Main tmux config
├── zed/                   # Neovim config
│   ├── settings.json      # Zed settings file
│   └── themes/            # Zed theme directory for local themes (once again, too lazy to make an actual extension)
│       └── viis.json      # Zed port of my bespoke nvim theme
└── starship.toml          # Starship prompt config

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
- **Beautiful UI** - Custom lualine statusline with mode indicators
- **Code Formatting** - Conform.nvim with automatic formatting on save

<img width="5120" height="2820" alt="CleanShot 2026-01-11 at 20 09 52@2x" src="https://github.com/user-attachments/assets/3bbae743-98c1-4985-8f76-001c00b547b3" />
<img width="5120" height="2820" alt="CleanShot 2026-01-11 at 20 10 32@2x" src="https://github.com/user-attachments/assets/6aeedd1a-daa4-4043-b32b-a60d1db8847a" />


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
2. `tn project` to start a new tmux session (if I decided to use Tmux that day)
3. Create focused windows for different tasks (coding, testing, etc.), either with Tmux or Ghostty tabs/panes
4. Get to work!
## 🎨 Theme: Viis Dark

My entire environment uses my own custom theme for consistency:
- **Ghostty** - Custom viis terminal colors
- **Neovim** - Viis colorscheme defined locally, with custom highlights
- **Tmux** - Matching status bar colors
- **FZF** - Matching themed fuzzy finder interface

<img width="5120" height="2818" alt="CleanShot 2026-01-11 at 20 12 29@2x" src="https://github.com/user-attachments/assets/ecb890e0-7eed-4722-a190-f5292bfe9ff0" />


## 📦 Plugin Highlights

### Neovim Plugins
| Plugin                     | Purpose                                    |
| -------------------------- | ------------------------------------------ |
| **lazy.nvim**              | Modern plugin manager                      |
| **mason.nvim + lspconfig** | LSP management and configuration           |
| **nvim-cmp + sources**     | Intelligent code completion                |
| **conform.nvim**           | Code formatting with multiple formatters   |
| **gitsigns.nvim**          | Git integration and change indicators      |
| **harpoon**                | Quick file navigation and bookmarking      |
| **oil.nvim**               | File system editing as text                |
| **telescope.nvim**         | Fuzzy finder for everything                |
| **treesitter**             | Syntax highlighting and code understanding |
| **trouble.nvim**           | Better diagnostics and error management    |
| **lualine.nvim**           | Fast and highly customizable statusline    |

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

### Ghostty
- `Ctrl + Cmd + -` - Split window horizontally
- `Ctrl + Cmd + |` - Split window vertically
- `Ctrl + h/j/k/l` - Switch between panes
- `Ctrl + Cmd + z` - Zoom on focused pane
- `Ctrl + Cmd + x` - Close focused pane
- `Cmd + t` - Open a new tab
- `Cmd + w` - Close current tab
- `Opt + v` - Enter vim mode

### Terminal Aliases
- `ff` - Fuzzy find and open file in Neovim
- `dff` - Fuzzy find and change to directory
- `vim` → `nvim` - Muscle memory override
- `cl` → `clear` - Just a bit faster to type
- `gs` → `git status` - Quick git status
- `gb` → `git branch` - Quick git branch
- `gc` → `git checkout` - Quick git checkout
- `ga` → `git add` - Quick git add
- `gitgood` → `git branch -m master main && git fetch --all --prune` - Convert 'master' branch to 'main'

## 🔧 Customization

### Adding Your Own Aliases
I mean... you should know how to do this already.

### Modifying Neovim Configuration
The modular structure makes it easy to customize:
- **Keymaps:** Edit `lua/config/keymaps.lua`
- **Options:** Modify `lua/config/options.lua`
- **Plugins:** Add new plugins in `lua/plugins/`
- **LSP:** Configure language servers in `lua/config/lsp.lua`
-  **Colours:** Configure the colour scheme to your liking in `lua/colorschemes/viis/init.lua`

## 🤝 Contributing

I don't necessarily want anyone contributing to or modifying this particular repo, as it's meant to show my own personal preferences (unless you see a way I can optimize the setup 👀).
However, you should obviously feel free to fork it and modify things to your liking!

## 📝 Notes

- This configuration is optimized for software development with a focus on web technologies, Python, Rust, and C/C++
- Some plugins may require additional language-specific tools (installed via Mason)
- The configuration prioritizes performance and minimalism while maintaining powerful functionality

---

Happy coding! 🚀
