#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
DOTREPO="https://github.com/silahgee/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
	echo "Fetching dotfiles..."
	git clone "$DOTREPO" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# Configure git filters immediately so personal metadata is never committed
if [ -f "./distro/fedora/setup/git-filters.sh" ]; then
    bash ./distro/fedora/setup/git-filters.sh
fi

# detect OS and run distribution-specific setups
if [ -f /etc/fedora-release ]; then
    echo "Running system setup..."
    bash ./distro/fedora/install.sh
else
    echo "Warning: Unsupported OS"
fi

echo "Setup complete!"
