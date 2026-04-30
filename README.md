# Arch Linux Install Scripts

Scripts for Arch install & configuration with KDE Plasma or GNOME, support packages, and apps.

---

## Arch Live ISO

This step installs Arch to your specified drive. *IT WILL FORMAT THE DISK*

Boot into your Arch ISO & run commands:

```bash
# Installer 1 & 2
curl https://raw.githubusercontent.com/merlins-lair/ArchScripts/refs/heads/main/install1.sh -o install1.sh
sh install1.sh

# Reboot machine when prompted (remove installation media during reboot)
reboot
```

### After First Boot

```bash
# Install Pacman Tools
sudo pacman -S --noconfirm pacman-contrib

# Installer 3 (Desktop, software & Nvidia Drivers)
cd ArchScripts
sh install3.sh

# Reboot System
reboot
```

### System Description
Systemd boot

KDE or Gnome Desktop Environment

SDDM Login Manager
