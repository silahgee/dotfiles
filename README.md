# dotfiles

My personal configuration files and environment settings for Linux systems.

## Software Stack

The repository manages configurations for the following tools:

- **Shell:** Bash (via `.bashrc` and `.bash_profile`)
- **Terminal Emulator:** Alacritty including custom themes from [terminalcolors.com](https://terminalcolors.com/alacritty/)
- **Terminal Multiplexer:** Tmux
- **Version Control**: Git global configuration

## Installation

For step-by-step setup instructions, please see [INSTALLATION.md](INSTALLATION.md).

## Adding New Configs

To manage a new configuration file or application folder using this dotfiles repository, follow these three steps:

### 1. Moving the Config into your Dotfiles

Move the target configuration file or directory from your `$HOME` directory into the appropriate folder inside `~/dotfiles`.

*Example: Moving a custom configuration file:*

```bash
mkdir -p ~/dotfiles/neofetch
mv ~/.config/neofetch/config.conf ~/dotfiles/neofetch/config.conf
```

### 2. Update `links.toml`

Open `links.toml` and append a new key-value pair mapping rule.

- **Key:** The relative path inside your `~/dotfiles` directory
- **Value:** The relative path from your `$HOME` directory where the application expects it to be

```toml
"neofetch/config.conf" = ".config/neofetch/config.conf"
```

### 3. Deploy the changes

Run the installation script again. The script will automatically verify the source, build any missing parent directories (like `.config/neofetch`), remove old files, and apply the new semlink.

```bash
cd ~/dotfiles
./install.sh
```
