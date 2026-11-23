#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
DOTREPO="https://github.com/silahgee/dotfiles"

# parse arguments
GIT_ONLY=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --git)
            GIT_ONLY=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--git]"
            exit 1
            ;;
    esac
done

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Fetching dotfiles..."
    git clone "$DOTREPO" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# configure git filters
if [ -f "./distro/fedora/setup/git-filters.sh" ]; then
    bash ./distro/fedora/setup/git-filters.sh
fi

# exit if only Git configuration was requested
if [[ "$GIT_ONLY" == true ]]; then
    echo "Git configuration complete!"
    exit 0
fi

# detect OS and run distribution-specific setups
if [ -f /etc/fedora-release ]; then
    echo "Running system setup..."
    bash ./distro/fedora/install.sh
else
    echo "Warning: Unsupported OS"
fi

echo "Setup complete!"
