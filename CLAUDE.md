# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for macOS development environment configuration. It uses a manual organization strategy with a directory-per-tool structure, maintaining standard configuration paths within each tool's directory.

## Architecture & Structure

### Organization Pattern
- **Store-in-place strategy**: Each tool's directory contains its actual configuration path structure (e.g., `ghostty/.config/ghostty/config`)
- **No automation framework**: Manual installation and symlink management
- **Consistent theming**: Gruvbox Dark theme across all tools with JetBrainsMono Nerd Font

### Tool Dependencies
- **Required**: Ghostty, Neovim, Tmux (with TPM), Karabiner-Elements, Oh-My-Zsh, Homebrew
- **Modern CLI tools**: eza, bat, zoxide, fzf, fd, ripgrep
- **Font**: JetBrainsMono Nerd Font

## Key Components

### Neovim (`nvim/.config/nvim/`)
- **Plugin Manager**: Lazy.nvim
- **Configuration**: Single monolithic `init.lua`
- **LSP Support**: Configured for Lua, TypeScript, Python, Rust via Mason and LSP-zero

### Tmux (`tmux/`)
- **Plugin Manager**: TPM (Tmux Plugin Manager)
- **Custom Script**: `tmux-sessionizer.sh` - Project-based session management with fzf
- **Prefix**: Ctrl-a (remapped from default)

### Karabiner (`karabiner/.config/karabiner/`)
- **Hyper Key System**: Caps Lock acts as Escape (tap) or Hyper modifier (hold)
- **System-wide Vim navigation**: Hyper+hjkl for arrow keys
- **App launchers**: Hyper+letter combinations for quick app switching

### Zsh (`zsh/.zshrc`)
- **Framework**: Oh-My-Zsh with Agnoster theme
- **Key Integration**: Ctrl-f bound to tmux-sessionizer
- **Modern replacements**: Uses eza (ls), bat (cat), zoxide (cd)

## Common Development Tasks

### Setting up symlinks (manual process)
```bash
# Example for Neovim
ln -sf ~/dotfiles/nvim/.config/nvim ~/.config/nvim

# Example for Ghostty
ln -sf ~/dotfiles/ghostty/.config/ghostty ~/.config/ghostty

# Example for Git
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global
```

### Installing dependencies
```bash
# Install Homebrew packages (no Brewfile exists yet)
brew install neovim tmux fzf fd ripgrep eza bat zoxide

# Install TPM for Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install JetBrainsMono Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

### Neovim plugin management
```bash
# Plugins auto-install on first launch via Lazy.nvim
nvim

# Update plugins within Neovim
:Lazy update

# Clean unused plugins
:Lazy clean
```

### Tmux plugin management
```bash
# Install plugins (after TPM is installed)
# Press prefix + I (Ctrl-a then Shift+i) within tmux

# Update plugins
# Press prefix + U (Ctrl-a then Shift+u) within tmux
```

## Important Patterns

### Configuration Philosophy
- **Vim-centric**: Vim keybindings used throughout (tmux, system-wide via Karabiner)
- **Modern tooling preference**: Rust-based alternatives preferred (eza, bat, ripgrep)
- **Project-based workflow**: tmux-sessionizer provides fuzzy project switching
- **Consistent colors**: Gruvbox theme with custom FZF colors matching the theme

### File Locations
- Configurations maintain standard paths within their tool directories
- No centralized configuration or dotfile manager
- Each tool is self-contained in its directory

### Custom Scripts
- `tmux/.config/tmux/tmux-sessionizer.sh`: Core workflow automation for project switching
  - Searches: ~/personal, ~/work, ~/projects, ~/.config
  - Creates or attaches to tmux sessions based on project selection

## GitHub Repository

This dotfiles repository is synced to GitHub at: https://github.com/asieglinger/dotfilesstudio

### Pushing Changes to Remote

After making changes to your dotfiles:

```bash
# Stage your changes
git add .
# Or stage specific files
git add path/to/file

# Commit with a descriptive message
git commit -m "Your commit message"

# Push to GitHub
git push

# If working on a new branch
git push -u origin branch-name
```

### Common Git Operations

```bash
# Check status of changes
git status

# View uncommitted changes
git diff

# Pull latest changes from GitHub
git pull

# View commit history
git log --oneline
```

## Areas Needing Implementation

1. **Installation automation**: No bootstrap or setup scripts exist
2. **Dependency tracking**: No Brewfile or requirements list
3. **Raycast configuration**: Directory exists but is empty
4. **Backup/restore procedures**: No automated backup strategy
5. **Cross-platform support**: Currently macOS-specific

## Testing & Validation

Since this is a dotfiles repository without traditional tests:
- Verify symlinks are correctly created
- Test each tool launches without errors
- Confirm keybindings work as expected
- Check plugin installations complete successfully

## Working with This Repository

When making changes:
1. Maintain the existing directory structure
2. Preserve the Gruvbox theme consistency
3. Test configurations in their actual locations before committing
4. Document any new dependencies or setup steps
5. Consider automation opportunities for manual processes