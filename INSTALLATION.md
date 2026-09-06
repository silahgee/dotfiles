# Installation

Make sure to clone the repository directly into your user's `home` directory.

```bash
cd ~

# using HTTPS
git clone https://github.com/silahgee/dotfiles.git

# using SSH
git clone git@github.com:silahgee/dotfiles.git

cd dotfiles
```

## Configuration Setup

Run the installation script to map and apply your configurations.

```bash
chmod +x install.sh # make the file executable
./install.sh
```

### How It Works

The installation script automatically processes your mappings from the [links.toml](links.toml) file. It safely handles existing configurations by removing them and establishing fresh symbolic links back to your `~/dotfiles` directory.

For example, a symlink is created under the hood like this:

```bash
ln -s ~/dotfiles/bashrc ~/.bashrc
```

### Prerequisites

- **Package Manager:** The script currently targets **Fedora/RHEL-based systems** and requires `dnf`
- **TOML Parser:** The script relies on `yq` to read your link configurations. If `yq` is missing, the script will prompt you for permission to install it automatically via `dnf`
