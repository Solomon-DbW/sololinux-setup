# Maintainer: Your Name <your.email@example.com>
pkgname=sololinux-setup
pkgver=1.0.0
pkgrel=1
pkgdesc="SoloLinux GUI environment setup and configuration"
arch=('any')
url="https://github.com/Solomon-DbW/SoloLinuxISO"
license=('GPL')
depends=(
    'git'
    'base-devel'
    'ttf-jetbrains-mono-nerd'
    'noto-fonts'
    'noto-fonts-emoji'
    'noto-fonts-cjk'
    'ttf-dejavu'
    'jq'
    'zsh'
    'zsh-autosuggestions'
    'figlet'
    'eza'
    'zoxide'
    'fzf'
    'yad'
    'ghc'
    'dunst'
    'hyprland'
    'hyprpaper'
    'hyprlock'
    'waybar'
    'rofi'
    'fastfetch'
    'brightnessctl'
    'kitty'
    'ly'
    'virt-manager'
    'networkmanager'
    'neovim'
    'emacs'
)
optdepends=(
    'brave-bin: Recommended web browser'
    'hyprshade: Hyprland shader support'
    'visual-studio-code-bin: Code editor'
    'waypaper: Wallpaper manager'
    'gnome-tweaks: GNOME customization tool (if using GNOME)'
)
optdepends=(
    'brave-bin: Recommended web browser'
    'hyprshade: Hyprland shader support'
    'visual-studio-code-bin: Code editor'
    'waypaper: Wallpaper manager'
)
source=("sololinux-setup.sh")
sha256sums=('SKIP')
install=sololinux-setup.install

package() {
    install -Dm755 "$srcdir/sololinux-setup.sh" "$pkgdir/usr/bin/sololinux-setup"
}
