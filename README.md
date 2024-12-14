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
sh preinstall2.sh

# Preparing for first boot (Non-Nvidia GPU or VM)
exit
umount -R /mnt

# Preparing for first boot (Nvidia GPU) - Follow linked instructions:
https://github.com/korvahannu/arch-nvidia-drivers-installation-guide

exit
umount -R /mnt

# Reboot Machine (remove installation media during reboot)
reboot
```

### After First Boot

```bash
# Install Pacman Tools
sudo pacman -S --noconfirm pacman-contrib

# Installer 3
sudo git clone https://git.merlinslair.net/beech/ArchScripts
cd ArchScripts
sh install3.sh

# Reboot System
reboot
```

### System Description
GNOME or KDE Desktop Environment 

GDM or SDDM Login Manager

### Credits
__[Inspired by ArchTitus](https://github.com/ChrisTitusTech/ArchTitus)__