#!/usr/bin/env bash
set -euo pipefail

# Create backup function
backup_if_exists() {
    if [ -e "$1" ]; then
        local backup="${1}.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r "$1" "$backup"
        echo "Backed up $1 to $backup"
    fi
}

# Ensure installation occurs from home dir
cd ~

# Update font cache
echo "Updating font cache..."
fc-cache -fv

# Starship prompt installation
echo "Installing Starship prompt..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! grep -q 'starship init bash' ~/.bashrc 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

if ! grep -q 'starship init zsh' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Oh-my-zsh install
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Zsh-autosuggestions plugin install
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Check for yay
if ! command -v yay &> /dev/null; then
    echo "Warning: yay AUR helper not found. Install it to get AUR packages:"
    echo "  cd ~ && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    echo ""
    echo "Optional AUR packages: brave-bin hyprshade visual-studio-code-bin waypaper"
    echo ""
fi

# Backup existing configs
echo "Backing up existing configurations..."
backup_if_exists ~/.zshrc
backup_if_exists ~/.config

# Get SoloLinux config files
echo "Downloading SoloLinux configurations..."
cd ~
if [ -d SoloLinux_GUI ]; then
    rm -rf SoloLinux_GUI
fi
git clone https://github.com/Solomon-DbW/SoloLinux_GUI

# Move config files carefully
echo "Applying configurations..."
cp SoloLinux_GUI/zshrcfile ~/.zshrc
cp -r SoloLinux_GUI/* ~/.config/ 2>/dev/null || true

# Cleanup
rm -rf SoloLinux_GUI

# Enable services
echo "Enabling system services..."
sudo systemctl enable NetworkManager
sudo systemctl enable ly

# Making scripts executable
echo "Setting script permissions..."
chmod +x ~/.config/hypr/scripts/* 2>/dev/null || true
chmod +x ~/.config/waybar/switch_theme.sh ~/.config/waybar/scripts/* 2>/dev/null || true

# Customize /etc/os-release for colour of #256897
echo "Customizing OS release info..."
sudo tee /etc/os-release > /dev/null <<'EOF'
NAME="SoloLinux"
PRETTY_NAME="SoloLinux"
ID=sololinux
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="0;38;2;37;104;151"
HOME_URL="https://github.com/Solomon-DbW/SoloLinuxISO"
DOCUMENTATION_URL="https://github.com/Solomon-DbW/SoloLinuxISO"
SUPPORT_URL="https://github.com/Solomon-DbW/SoloLinuxISO"
BUG_REPORT_URL="https://github.com/Solomon-DbW/SoloLinuxISO"
PRIVACY_POLICY_URL="https://github.com/Solomon-DbW/SoloLinuxISO"
LOGO=archlinux-logo
EOF

# Change shell (will take effect after logout)
echo "Changing default shell to zsh..."
chsh -s $(which zsh)

echo ""
echo "=========================================="
echo "Setup complete! Please log out and log back in."
echo "Select Hyprland from the display manager to start the SoloLinux GUI."
echo "=========================================="
