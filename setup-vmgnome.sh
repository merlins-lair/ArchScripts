#!/usr/bin/env bash
echo
echo "Installing Base System"
echo

PKGS=(

    # --- VM Packages (Uncomment if not a VM guest)
        'open-vm-tools'

    # --- XORG Display Rendering
        'xorg'                  # Base Package
        'xorg-drivers'          # Display Drivers 
        'xterm'                 # Terminal for TTY
        'xorg-server'           # XOrg server
        'xorg-apps'             # XOrg apps group
        'xorg-xinit'            # XOrg init
        'xorg-xinput'           # XOrg xinput
        'xorg-twm'              # XOrg twm
        'xorg-xclock'           # XOrg xclock
        'xf86-input-vmmouse'
        'xf86-video-vmware'
        'mesa'

    # --- Setup Desktop
        'gnome'                 # GNOME
        'xfce4-power-manager'   # Power Manager 

    # --- Login Display Manager
        'gdm'                   # Base Login Manager

    # --- Networking Setup
        'dialog'                    # Enables shell scripts to trigger dialog boxex
        'networkmanager'            # Network connection manager
        'network-manager-applet'    # System tray icon/utility for network connectivity
        'dhclient'                  # DHCP client
        'libsecret'                 # Library for storing passwords
        'fail2ban'                  # Ban IP's after man failed login attempts
        'ufw'                       # Uncomplicated firewall
    
    # --- Audio
        'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
        'alsa-plugins'      # ALSA plugins
        'pnmixer'           # System tray volume control
        'pipewire'
        'pipewire-pulse'
        'pipewire-audio'
        'pipewire-alsa'
        'pipewire-jack'
        'wireplumber'
        'rtkit'

    # --- Bluetooth
        'bluez'                 # Daemons for the bluetooth protocol stack
        'bluez-utils'           # Bluetooth development and debugging utilities
        'bluez-libs'            # Bluetooth libraries
        'bluez-firmware'        # Firmware for Broadcom BCM203x and STLC2300 Bluetooth chips
        'blueberry'             # Bluetooth configuration tool
        'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

sudo systemctl enable gdm.service 

sudo systemctl enable vmtoolsd.service
sudo systemctl enable vmware-vmblock-fuse.service
cp /usr/share/pipewire/pipewire.conf /etc/pipewire/

echo
echo "Done! Please Reboot & Run software.sh. View wiki for VM audio fix."
echo
