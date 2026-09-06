#!/bin/bash

# exit immediately if dnf is not installed
if ! command -v dnf &> /dev/null; then
	echo "Error: dnf is required but not installed"
	exit 1
fi

DOTFILES="$HOME/dotfiles"
CONFIG_FILE="$DOTFILES/links.toml"

# check if yq is installed
if ! command -v yq &> /dev/null; then
	echo "'yq' is required but not installed"
	read -p "Would you like to install it now? (y/N): " choice

	case "$choice" in
		[yY][eE][sS]|[yY]*)
			sudo dnf install -y yq
			;;
		*)
			echo "Exiting: 'yq' is mandatory to process the TOML configuration"
			exit 1
			;;
	esac
fi

# verify the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
	echo "Error: Config file $CONFIG_FILE not found"
	exit 1
fi

# define the associative array of source and target paths
declare -A LINKS

# read TOML keys and values into the array using yq
# [source_in_dotfiles]=targetin_in_home
while IFS=$'\t' read -r src tgt; do
	LINKS["$src"]="$HOME/$tgt"
done < <(yq -p=toml -o=tsv 'to_entries | .[] | [ .key, .value ]' "$CONFIG_FILE")

for src in "${!LINKS[@]}"; do
	source="$DOTFILES/$src"
	target="${LINKS[$src]}"

	# verify source exists
	if [ ! -e "$source" ]; then
		echo "Warning: Source $source does not exist. Skipping."
		continue
	fi

	# create the target's parent directory if it doesn't exist
	target_dir=$(dirname "$target")
	if [ ! -d "$target_dir" ]; then
		mkdir -p "$target_dir"
		echo "Created directory: $target_dir"
	fi

	# safely backup existing file or folder and remove link
	if [ -e "$target" ] || [ -L "$target" ]; then
		TIMESTAMP=$(date +%Y%m%d%H%M%S)
		cp -rLf "$target" "$target.$TIMESTAMP.bak"
		rm -rf "$target"
	fi

	# create the new symlink
	ln -s "$source" "$target"
	echo "Linked $source -> $target"

	# check if the target is .bashrc and source it
	if [[ "$target" == *".bashrc" ]]; then
		echo -e "\tSourcing $target..."
		source "$target"
	fi

	# Check if the target is .tmux.conf and reload it
	if [[ "$target" == *".tmux.conf" ]]; then
		if [ -n "$TMUX" ]; then
			echo -e "\tReloading tmux configuration..."
			tmux source-file "$target"
		else
			echo -e "\tSkipped tmux reload (not inside a tmux session)"
		fi
	fi
done

echo "Done"

