#!/usr/bin/env bash
echo
echo "Installing Base System"
echo

PKGS=(

    # --- XORG
        'xorg'
        'xorg-drivers'
        'xterm'
        'xorg-server'
        'xorg-apps'
        'xorg-xinit'
        'xorg-xinput'
        'xorg-twm'
        'xorg-xclock'
        'xf86-input-vmmouse'
        'xf86-video-vmware'
        'mesa'

    # --- Desktop
        'plasma'

    # --- Login manager
        'sddm'

    # --- Networking
        'dialog'
        'network-manager-applet'
        'dhclient'
        'libsecret'
        'fail2ban'
        'ufw'
    
    # --- Audio
        'pipewire'
        'wireplumber'
        'pipewire-pulse'
        'pipewire-alsa'
        'pavucontrol'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

sudo systemctl enable sddm.service

echo
echo "Done! Please Reboot & Run software.sh"
echo
