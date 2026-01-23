#!/bin/bash

echo "Stowing config files..."
stow . --adopt

echo "Downloading essential packages..."
essential_packages=(
    # login
    sddm
    qt5-graphicaleffects
    qt5-svg
    qt5-quickcontrols2

    # userspace packages
    firefox
    dolphin
    ttf-cascadia-code-nerd
    discord
    swww
    waybar
    dunst
    pavucontrol
    rofi

    # terminal packages
    git
    kitty
    zellij
    lazygit
    neovim

    # terminal utilities
    atuin
    saty
    starship
    zsh
    eza
    zoxide
    btop
    slurp
    grim

    # AUR helper
    git
    base-devel
)

sudo pacman -S "${essential_packages[@]}"

echo "Installing AUR helper..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo "Installing yay packages..."
yay_packages=(
    wlogout
)
yay -S "{yay_packages[@]}"

echo "Creating sdddm config directory"
sudo mkdir /etc/sddm.conf.d/

echo "Adding sddm theme..."
if [ ! -e /usr/share/sddm/themes/corners/ ]; then
    sudo cp -r ~/.config/sddm-theme-corners/corners/ /usr/share/sddm/themes/
fi

echo "Applying sddm theme"
sudo tee /etc/sddm.conf.d/theme.conf > /dev/null << EOF
[Theme]
Current=corners
EOF
