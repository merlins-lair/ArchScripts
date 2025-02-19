#!/usr/bin/env bash
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
    'spotify'              # Music
    'obs-studio'           # Screen Recording
    'remmina'              # RDP
    'discord'              # Messaging
    'thunar'               # File Manager
    'thunar-archive-plugin'
    'ark'
    'tumbler'

    # DEVELOPMENT ---------------------------------------------------------

    'gedit'                 # Text editor
    'code'                  # Visual Studio Code
    'git'                   # Version control system
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    'python'                # Scripting language
    'yarn'                  # Dependency management (Hyper needs this)
    'gimp'                  # Photo Editor
    'kdenlive'              # Video Editor

    # PRODUCTIVITY --------------------------------------------------------

    'xpdf'                  # PDF viewer

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
