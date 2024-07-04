#!/usr/bin/env bash
echo
echo "INSTALLING SOFTWARE"
echo

PKGS=(

    # TERMINAL UTILITIES --------------------------------------------------

    'curl'                    # Remote content retrieval
    'file-roller'              # Archive utility
    'gufw'                    # Firewall manager
    'hardinfo'                # Hardware info app
    'neofetch'                # Shows system info when you launch terminal
    'numlockx'                # Turns on numlock in X11
    'p7zip'                   # 7z compression program
    'unrar'                   # RAR compression program
    'unzip'                   # Zip compression program
    'wget'                    # Remote content retrieval
    'konsole'                 # Terminal emulator
    'vim'                     # Terminal Editor
    'zenity'                  # Display graphical dialog boxes via shell scripts
    'zip'                     # Zip compression program
    'zsh'                     # Interactive shell
    'zsh-autosuggestions'     # Zsh Plugin
    'zsh-syntax-highlighting' # Zsh Plugin
    'nano'                    # Simpler Terminal Editor

    # GENERAL UTILITIES ---------------------------------------------------

    'dolphin'              # Filesystem browser
    'vlc'                  # Video Player

    # DEVELOPMENT ---------------------------------------------------------

    'gedit'                 # Text editor
    'code'                  # Visual Studio Code
    'git'                   # Version control system
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    'python'                # Scripting language
    'yarn'                  # Dependency management (Hyper needs this)

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
