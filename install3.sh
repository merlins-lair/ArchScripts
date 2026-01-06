#!/usr/bin/env bash
chmod +x gnomesetup.sh
chmod +x kdesetup.sh
chmod +x software.sh
chmod +x qemu.sh

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

install_qemu () {
    echo "Setting up QEMU + Virt Manager..."
    sh qemu.sh
    echo "Virt Manager installed."
}

setup_nvidia () {
    echo "-------------------------------------------------"
    echo "NVIDIA Driver Selection"
    echo "-------------------------------------------------"
    
    nvidia_options=("Main NVIDIA Drivers (Latest)" "NVIDIA 580xx Drivers (Pascal/Older - AUR)" "Cancel")
    
    echo "Select NVIDIA driver version:"
    select nvidia_opt in "${nvidia_options[@]}"; do
        case $REPLY in
            1)
                echo "Setting up main NVIDIA drivers..."
                sudo pacman -Syu --noconfirm --needed
                sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings --noconfirm --needed
                sudo sed -i 's/^MODULES=().*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
                sudo sed -i 's/\(HOOKS=.*\) kms/\1/' /etc/mkinitcpio.conf
                sudo mkinitcpio -P
                sudo mkdir -p /etc/pacman.d/hooks/ && sudo cp nvidia.hook /etc/pacman.d/hooks/
                sudo sed -i '/^options/ s/$/ nvidia-drm.modeset=1 nvidia_drm.fbdev=1 nvidia-drm.ForceCompositionPipeline=1 nvidia.NVreg_EnableGpuFirmware=0/' /boot/loader/entries/arch.conf
                echo "NVIDIA driver setup finished."
                break
                ;;
            2)
                echo "Setting up NVIDIA 580xx drivers (AUR)..."
                
                # Check if yay is installed
                if ! command -v yay &> /dev/null; then
                    echo "Yay is not installed. Installing yay..."
                    cd "${HOME}"
                    git clone "https://aur.archlinux.org/yay.git"
                    cd "${HOME}/yay"
                    makepkg -si
                    cd "${HOME}"
                    rm -rf "${HOME}/yay"
                    echo "Yay installation complete."
                else
                    echo "Yay already installed."
                fi
                
                # Install 580xx drivers
                sudo pacman -Syu --noconfirm --needed
                yay -S nvidia-580xx-dkms nvidia-580xx-utils lib32-nvidia-580xx-utils nvidia-580xx-settings opencl-nvidia-580xx lib32-opencl-nvidia-580xx --noconfirm --needed
                sudo sed -i 's/^MODULES=().*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
                sudo sed -i 's/\(HOOKS=.*\) kms/\1/' /etc/mkinitcpio.conf
                sudo mkinitcpio -P
                sudo mkdir -p /etc/pacman.d/hooks/ && sudo cp nvidia.hook /etc/pacman.d/hooks/
                sudo sed -i '/^options/ s/$/ nvidia-drm.modeset=1 nvidia_drm.fbdev=1 nvidia-drm.ForceCompositionPipeline=1 nvidia.NVreg_EnableGpuFirmware=0/' /boot/loader/entries/arch.conf
                echo "NVIDIA 580xx driver setup finished."
                break
                ;;
            3)
                echo "Cancelled NVIDIA driver setup."
                break
                ;;
            *)
                echo "Invalid option. Please select 1, 2, or 3."
                ;;
        esac
    done
}

while true; do
    options=("Install GNOME" "Install KDE" "Install Software" "Install QEMU + Virt Manager" "Setup Nvidia Drivers" "Exit")

    echo "Desktop & Software Setup: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_gnome; break ;;
            2) install_kde; break ;;
            3) install_software; break ;;
            4) install_qemu; break ;;
            5) setup_nvidia; break ;;
            6) break 2 ;;
            *) echo "Invalid" >&2
        esac
    done
done

echo "Exiting! Please reboot to enter desktop environment."