#!/usr/bin/env bash
chmod +x gnomesetup.sh
chmod +x kdesetup.sh
chmod +x software.sh
chmod +x aur.sh

install_gnome () {
    echo "Setting up GNOME + GDM..."
    sh gnomesetup.sh
    echo "Gnome installed & GDM enabled on reboot."
}

install_kde () {
    echo "Setting up KDE + SDDM..."
    sh kdesetup.sh
    echo "KDE installed + SDDM enabled on reboot."
}

install_hyprland () {
    echo "Setting up Hyprland + SDDM..."
    sh hyprsetup.sh
    echo "Hyprland installed + SDDM enabled on reboot."
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

while true; do
    options=("Install GNOME + GDM" "Install KDE + SDDM" "Install Hyprland + SDDM" "Install Software" "Setup Yay" "Exit")

    echo "Debian Server Setup: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_gnome; break ;;
            2) install_kde; break ;;
            3) install_hyprland; break ;;
            4) install_software; break ;;
	    5) setup_aur
            6) break 2 ;;
            *) echo "Invalid" >&2
        esac
    done
done

echo "Exiting! Please reboot to enter desktop environment."
