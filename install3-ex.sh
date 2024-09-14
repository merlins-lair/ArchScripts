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

while true; do
    options=("Install GNOME + GDM" "Install KDE + SDDM" "Install Software" "Exit")

    echo "Debian Server Setup: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_gnome; break ;;
            2) install_kde; break ;;
            3) install_software; break ;;
            4) break 2 ;;
            *) echo "Invalid" >&2
        esac
    done
done

echo "Exiting! Please reboot to enter desktop environment."
