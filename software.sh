#!/usr/bin/env bash
echo
echo "Setting up Yay for AUR packages..."
echo
echo "Please enter username:"
read username
cd "${HOME}"
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si
echo
echo "Yay setup complete."
echo
echo
echo "INSTALLING SOFTWARE"
echo

PKGS=(

    # TERMINAL UTILITIES --------------------------------------------------

    'curl'                    # Remote content retrieval
    'gufw'                    # Firewall manager
    'neofetch'                # Shows system info when you launch terminal
    'numlockx'                # Turns on numlock in X11
    'p7zip'                   # 7z compression program
    'unrar'                   # RAR compression program
    'unzip'                   # Zip compression program
    'wget'                    # Remote content retrieval
    'vim'                     # Terminal Editor
    'zenity'                  # Display graphical dialog boxes via shell scripts
    'zip'                     # Zip compression program
    'nano'                    # Simpler Terminal Editor
    'kitty'                   # Terminal Emulator

    # GENERAL UTILITIES ---------------------------------------------------

    'mpv'                  # Video Player
    'gwenview'             # Image Viewer
    'lutris'               # Gaming
    'wine'                 # Gaming
    'steam'                # Gaming
    'obs-studio'           # Screen Recording
    'remmina'              # RDP
    'discord'              # Messaging
    'xpdf'                 # PDF viewer
    'thunar'               # File Manager
    'thunar-archive-plugin'
    'ark'
    'tumbler'
    'gvfs'
    'gvfs-smb'
    'samba'

    # DEVELOPMENT ---------------------------------------------------------

    'gedit'                 # Text editor
    'git'                   # Version control system
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    'python'                # Scripting language
    'yarn'                  # Dependency management (Hyper needs this)
    'gimp'                  # Photo Editor
    'kdenlive'              # Video Editor

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

AUR_PKGS=(
    'floorp-bin'            # Floorp browser
    'brave-bin'             # Brave browser
    'downgrade'             # Downgrade packages
    'spotify-edge'          # Spotify
    'proton-ge-custom-bin'  # Proton GE

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
    'org.prismlauncher.PrismLauncher'   # Prism Launcher (Minecraft)

)

for FLATPAK_APP in "${FLATPAK_APPS[@]}"; do
    echo "INSTALLING: ${FLATPAK_APP}"
    flatpak install flathub "$FLATPAK_APP" -y
done

echo
echo "All software installed!"
echo