#!/usr/bin/env bash

DOTFILES="$HOME/dotfiles"
DOTREPO="http://github.com/silahgee/dotfiles"

set -e

if [ ! -d "$DOTFILES" ]; then
	echo "Fetching dotfiles..."
	git clone "$DOTREPO" "$DOTFILES"
fi;

# detect OS and run distribution-specific setups
if [ -f /etc/fedora-release ]; then
    echo "Running system setup..."
    bash ./distro/fedora/install.sh
else
    echo "Warning: Unsupported OS"
fi

echo "Setup complete!"
