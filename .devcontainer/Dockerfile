FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Install build essentials for Neovim plugins (Treesitter, Telescope, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    unzip \
    tmux \
    less \
    git \
    && rm -rf /var/lib/apt/lists/*
