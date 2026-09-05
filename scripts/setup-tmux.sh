#!/bin/bash

# ================================================================
# Fedora Terminal Multiplexer installation
#
# Project info:
# https://tmux.us | https://github.com/tmux/tmux
# =================================================================

sudo dnf install tmux -y
tmux -v

TMUX_CONF="$HOME/.tmux.conf"

if [ -f "$TMUX_CONF" ]; then
	echo -e "\nConfig file already exists at $TMUX_CONF"
	echo "No changes made"
else
	touch "$TMUX_CONF"
	echo -e "\n$TMUX_CONF created"
fi
