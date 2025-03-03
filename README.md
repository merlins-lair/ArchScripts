# Arch Linux Install Scripts

Scripts for Arch install & configuration with GNOME or KDE Plasma, support packages, and apps.

---

## Arch Live ISO

This step installs Arch to your hard drive. *IT WILL FORMAT THE DISK*

Boot into your Arch ISO & run commands:

```bash
# Installer 1
curl https://git.merlinslair.net/beech/ArchScripts/raw/branch/main/install1.sh -o install1.sh
sh install1.sh

# Installer 2
curl https://git.merlinslair.net/beech/ArchScripts/raw/branch/main/install2.sh -o install2.sh
sh install2.sh

# Preparing for first boot
exit
umount -R /mnt

# Reboot Machine (remove installation media during reboot)
reboot
```

### After First Boot

```bash
# Install Pacman Tools
sudo pacman -S --noconfirm pacman-contrib

# Installer 3 (Desktop & Nvidia Drivers)
sudo git clone https://git.merlinslair.net/beech/ArchScripts
cd ArchScripts
sh install3.sh

# Reboot System
reboot
```

### System Description
Systemd boot

GNOME or KDE Desktop Environment

SDDM Login Manager

### Credits
__[Inspired by ArchTitus](https://github.com/ChrisTitusTech/ArchTitus)__