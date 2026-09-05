#!/bin/bash

# ================================================================
# Fedora GNOME Alacritty installation and Nautilus integration
#
# Project info:
# https://alacritty.org | https://github.com/alacritty/alacritty
# =================================================================

if ! rpm -q alacritty &> /dev/null; then
	sudo dnf install alacritty -y
else
	echo "Alacritty is already installed. Skipping."
fi

# enable COPR repository containing the plugin allowing you to open custom terminals from the Nautilus file manager
if [ ! -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:monkeygold:nautilus-open-any-terminal.repo ]; then
	sudo dnf copr enable monkeygold/nautilus-open-any-terminal
else
    echo "COPR repository is already enabled. Skipping."
fi

if ! rpm -q nautilus-open-any-terminal &> /dev/null; then
	# install the Nautilus integration plugin from the newly enabled COPR repository
	sudo dnf install nautilus-open-any-terminal -y

	# configure Nautilus to use Alacritty
	gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

	echo "Restarting Nautilus file manager..."
	nautilus -q
	nohup nautilus &> /dev/null &
else 
	echo "Nautilus extension is already installed. Skipping."
fi

echo "Done"
