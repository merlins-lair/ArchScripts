#!/usr/bin/env bash
chmod +x gnomesetup.sh
chmod +x kdesetup.sh
chmod +x software.sh
chmod +x aur.sh

install_gnome () {
    echo "Setting up GNOME + SDDM..."
    sh gnomesetup.sh
    echo "Gnome installed & GDM enabled on reboot."
}

install_kde () {
    echo "Setting up KDE + SDDM..."
    sh kdesetup.sh
    echo "KDE installed + SDDM enabled on reboot"
}

install_software () {
    echo "Setting up KDE + SDDM..."
    sh software.sh
    echo "Software installed."
}

setup_aur () {
    echo "Setting up Yay..."
    sh aur.sh
    echo "Yay installed."
}

setup_nvidia () {
    echo "Setting up Nvidia drivers..."
    sudo pacman -Syu --noconfirm --needed
    sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings --noconfirm --needed
    sudo sed -i 's/^MODULES=().*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    sudo sed -i 's/\(HOOKS=.*\) kms/\1/' /etc/mkinitcpio.conf
    sudo mkinitcpio -P
    sudo mkdir -p /etc/pacman.d/hooks/ && sudo cp nvidia.hook /etc/pacman.d/hooks/
    sudo sed -i '/^options/ s/$/ nvidia-drm.modeset=1 nvidia_drm.fbdev=1 nvidia-drm.ForceCompositionPipeline=1 nvidia.NVreg_EnableGpuFirmware=0/' /boot/loader/entries/arch.conf
    echo "Nvidia driver setup finished."
}

while true; do
    options=("Install GNOME + SDDM" "Install KDE + SDDM" "Install Software" "Setup Yay" "Setup Nvidia Drivers" "Exit")

    echo "Debian Server Setup: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_gnome; break ;;
            2) install_kde; break ;;
            3) install_software; break ;;
            4) setup_aur; break ;;
            5) setup_nvidia; break ;;
            6) break 2 ;;
            *) echo "Invalid" >&2
        esac
    done
done

echo "Exiting! Please reboot to enter desktop environment."
