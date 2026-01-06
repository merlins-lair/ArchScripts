#!/usr/bin/env bash

# Yay install
if ! command -v yay &> /dev/null; then
    echo
    echo "Setting up Yay for AUR packages..."
    echo
    echo "Please enter username:"
    read username
    cd "${HOME}"
    git clone "https://aur.archlinux.org/yay.git"
    cd ${HOME}/yay
    makepkg -si
    cd "${HOME}"
    rm -rf "${HOME}/yay"
    echo
    echo "Yay setup complete."
    echo
else
    echo
    echo "Yay already installed, skipping installation."
    echo
fi
echo
echo "INSTALLING SOFTWARE"
echo

PKGS=(

    # Terminal

    'curl'
    'gufw'
    'neofetch'
    'numlockx'
    'p7zip'
    'unrar'
    'unzip'
    'wget'
    'vim'
    'zenity'
    'zip'
    'nano'
    'kitty'

    # General

    'mpv'
    'gwenview'
    'lutris'
    'wine'
    'steam'
    'obs-studio'
    'remmina'
    'discord'
    'xpdf'
    'thunar'
    'thunar-archive-plugin'
    'ark'
    'tumbler'
    'gvfs'
    'gvfs-smb'
    'samba'
    'libimobiledevice'
    'usbmuxd'
    'gvfs-afc'
    'gvfs-gphoto2'


    # Development

    'gedit'
    'git'
    'nodejs'
    'npm'
    'python'
    'yarn'
    'gimp'
    'kdenlive'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

AUR_PKGS=(
    'floorp-bin'
    'brave-bin'
    'downgrade'
    'spotify-edge'
    'proton-ge-custom-bin'

)

for AUR_PKG in "${AUR_PKGS[@]}"; do
    echo "INSTALLING: ${AUR_PKG}"
    yay -S "$AUR_PKG" --noconfirm --needed
done

# Flatpak Apps

if ! flatpak remote-list | grep -q "flathub"; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "Flathub added successfully."
else
    echo "Flathub is already enabled."
fi
echo
echo "Installing Flatpak Applications..."
echo

FLATPAK_APPS=(
    'org.prismlauncher.PrismLauncher'

)

for FLATPAK_APP in "${FLATPAK_APPS[@]}"; do
    echo "INSTALLING: ${FLATPAK_APP}"
    flatpak install flathub "$FLATPAK_APP" -y
done

echo
echo "All software installed!"
echo