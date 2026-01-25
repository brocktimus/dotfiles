#!/bin/bash
set -euo pipefail

# --- 1. Config ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"


# Get absolute path for robust symlinking
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Git
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"

# Bash
ln -sf "$DOTFILES_DIR/bash/bashrc_personal" "$HOME/.bashrc_personal"
ln -sf "$DOTFILES_DIR/bash/inputrc" "$HOME/.inputrc"

# SSH
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
ln -sf "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"

# Starship
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# fzf
ln -sfn "$DOTFILES_DIR/fzf" "$HOME/.fzf"

ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# --- The Pinned Toolbelt ---
# Usage: fetch_bin "binary_name" "url"
fetch_bin() {
    local name=$1
    local url=$2
    local tmp_dir=$(mktemp -d)
    
    echo "Fetching $name..."
    if [[ "$url" == *.tar.gz || "$url" == *.tgz ]]; then
        curl -fsSL "$url" | tar xz -C "$tmp_dir"
        # Find the actual binary in the extracted tree and move it
        find "$tmp_dir" -type f -name "$name" -exec mv {} "$BIN_DIR/$name" \;
    else
        # Direct binary download (like jq)
        curl -fsSL "$url" -o "$BIN_DIR/$name"
    fi
    
    chmod +x "$BIN_DIR/$name"
    rm -rf "$tmp_dir"
}

# ripgrep: High-speed search
fetch_bin "rg" "https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz"

# fd: Simple find alternative
fetch_bin "fd" "https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-v9.0.0-x86_64-unknown-linux-musl.tar.gz"

# fzf: Fuzzy finder (Binary only)
fetch_bin "fzf" "https://github.com/junegunn/fzf/releases/download/0.46.1/fzf-0.46.1-linux_amd64.tar.gz"

# bat: Cat with syntax highlighting
fetch_bin "bat" "https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-x86_64-unknown-linux-musl.tar.gz"

# jq: JSON processor (Direct binary download)
fetch_bin "jq" "https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-amd64"

# starship: The prompt (Optional/Commented out later)
fetch_bin "starship" "https://github.com/starship/starship/releases/download/v1.17.1/starship-x86_64-unknown-linux-musl.tar.gz"

# delta: Better git diff
fetch_bin "delta" "https://github.com/dandavison/delta/releases/download/0.17.0/git-delta-0.17.0-x86_64-unknown-linux-musl.tar.gz"

# Neovim (Linux x64 tarball - more reliable than AppImage)
# This needs to be extracted carefully to keep the /share and /bin folders together
if [[ ! -d "$HOME/.local/nvim-linux64" ]]; then
    echo "Installing Neovim..."
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz" | tar xz -C "$HOME/.local/"
    ln -sf "$HOME/.local/nvim-linux64/bin/nvim" "$BIN_DIR/nvim"
fi

# 2. Inject the source command into the native bashrc
# We use a guard (grep) so we don't append it every time you run the script
if ! grep -q "source ~/.bashrc_personal" "$HOME/.bashrc"; then
    echo "" >> "$HOME/.bashrc"
    echo "# Load personal overrides" >> "$HOME/.bashrc"
    echo "[ -f ~/.bashrc_personal ] && source ~/.bashrc_personal" >> "$HOME/.bashrc"
fi

echo "Done."
