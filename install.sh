#!/bin/bash
set -euo pipefail
echo "Starting install..."

# --- 1. Config ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use absolute paths for everything during install
export BIN_DIR="$HOME/.local/bin"
export PATH="$BIN_DIR:$PATH"

# Ensure the bin dir exists before fetch_bin runs
mkdir -p "$BIN_DIR"

# Force non-interactive for any apt/tools
export DEBIAN_FRONTEND=noninteractive

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

# fzf
ln -sfn "$DOTFILES_DIR/fzf" "$HOME/.fzf"

# tmux
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# nvim
mkdir -p "$HOME/.config"
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# --- The Pinned Toolbelt ---
# Usage: fetch_bin "binary_name" "url"
fetch_bin() {
    local name=$1
    local url=$2
    local tmp_dir=$(mktemp -d)

    # Skip if already installed
    if [ -f "$BIN_DIR/$name" ]; then
        echo "$name already exists, skipping."
        return 0
    fi

    echo "Fetching $name..."
    # Download to a file first to check success
    if ! curl -fsSL "$url" -o "$tmp_dir/archive"; then
        echo "Error: Failed to download $name from $url"
        rm -rf "$tmp_dir"
        return 1
    fi

    if [[ "$url" == *.tar.gz || "$url" == *.tgz ]]; then
        tar xzf "$tmp_dir/archive" -C "$tmp_dir"
        find "$tmp_dir" -type f -name "$name" -exec mv {} "$BIN_DIR/$name" \;
    elif [[ "$url" == *.gz ]]; then
        gunzip -c "$tmp_dir/archive" > "$BIN_DIR/$name"
    else
        mv "$tmp_dir/archive" "$BIN_DIR/$name"
    fi

    chmod +x "$BIN_DIR/$name"
    rm -rf "$tmp_dir"
}

fetch_bin "rg"          "https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz"
fetch_bin "fd"          "https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-musl.tar.gz"
fetch_bin "fzf"         "https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz"
fetch_bin "bat"         "https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-i686-unknown-linux-musl.tar.gz"
fetch_bin "jq"          "https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-linux-amd64"
fetch_bin "delta"       "https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-unknown-linux-musl.tar.gz"
fetch_bin "tree-sitter" "https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.3/tree-sitter-linux-x64.gz"


# Neovim (Linux x64 tarball - more reliable than AppImage)
# This needs to be extracted carefully to keep the /share and /bin folders together
if [[ ! -d "$HOME/.local/nvim-linux64" ]]; then
    echo "Installing Neovim..."
    curl -fsSL "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz" | tar xz -C "$HOME/.local/"
    ln -sf "$HOME/.local/nvim-linux-x86_64/bin/nvim" "$BIN_DIR/nvim"
fi

# 2. Inject the source command into the native bashrc
# We use a guard (grep) so we don't append it every time you run the script
if ! grep -q "source ~/.bashrc_personal" "$HOME/.bashrc"; then
    echo "" >> "$HOME/.bashrc"
    echo "# Load personal overrides" >> "$HOME/.bashrc"
    echo "[ -f ~/.bashrc_personal ] && source ~/.bashrc_personal" >> "$HOME/.bashrc"
fi

echo "Lazy Nvim."

# This forces the plugin to load explicitly before running the update
nvim --headless "+Lazy! sync" +qa

echo "Done."
echo "Install finished, lingering for agent handshake..."
sync
sleep 1
exit 0
