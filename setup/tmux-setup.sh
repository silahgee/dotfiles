#!/bin/bash

# ================================================================
# Fedora Terminal Multiplexer installation
#
# Project info:
# https://tmux.us | https://github.com/tmux/tmux
# =================================================================

# exit immediately if dnf is not installed
if ! command -v dnf &> /dev/null; then
	echo "Error: dnf is required but not installed"
	exit 1
fi

# check tmux is installed
if ! command -v tmux &> /dev/null; then
	sudo dnf install tmux -y
else
	echo -n "$(tmux -V) - "
	echo "Tmux is already installed"
fi

TMUX_CONF="$HOME/.tmux.conf"

if [ -f "$TMUX_CONF" ]; then
	echo -e "\nConfig file already exists at $TMUX_CONF"
	echo "No changes made"
else
	touch "$TMUX_CONF"
	echo -e "\n$TMUX_CONF created"
fi
