install_gnome () {
    echo "Setting up GNOME + GDM..."
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

while true; do
    options=("Install GNOME + GDM" "Install KDE + SDDM" "Install Software" "Setup Yay" "Exit")

    echo "Debian Server Setup: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_gnome; break ;;
            2) install_kde; break ;;
            3) install_software; break ;;
            4) setup_aur; break ;;
            5) break 2 ;;
            *) echo "Invalid" >&2
        esac
    done
done

echo "Exiting! Please reboot to enter desktop environment."
