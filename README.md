# Arch Linux Install Scripts

Scripts for Arch install & configuration with GNOME or KDE Plasma, support packages, and apps.

---

## Arch Live ISO

This step installs Arch to your hard drive. *IT WILL FORMAT THE DISK*

Boot into your Arch ISO & run commands:

```bash
# Installer 1
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall1.sh -o preinstall1.sh
sh preinstall1.sh

# Creating user account - Run commands below & replace "USERNAME" with your preferred username.
arch-chroot /mnt

passwd # Set your ROOT password
useradd -m -g users -G wheel,storage,power -s /bin/bash USERNAME
passwd USERNAME # Set your USER password
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo "Defaults rootpw" >> /etc/sudoers # Require root pass for sudo

ip link # Take note of your network adapter name (ex: ens33)

# Installer 2 Setup
sudo pacman -S nano curl --noconfirm --needed
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall2.sh -o preinstall2.sh

# Edit network adapter name for dhcpcd service in script line 43
nano preinstall2.sh

# Installer 2
sh preinstall2.sh

# Preparing for first boot (Non-Nvidia GPU)
exit
umount -R /mnt
reboot # Remove installation media during reboot

# Preparing for first boot (Nvidia GPU)
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/nvidia.sh -o nvidia.sh
sh nvidia.sh

nano /boot/loader/entries/arch.conf
nvidia-drm.modeset=1 # Add this to the last line (ex: rw nvidia-drm.modeset=1)

exit
umount -R /mnt
reboot # Remove installation media during reboot
```

### After First Boot

```bash
sudo pacman -S --noconfirm pacman-contrib curl git
sudo git clone https://git.boppdev.net/beech/ArchScripts
cd ArchScripts

# Normal Install
sh setup.sh # GNOME install - use setup-kde.sh for plasma
sh software.sh

# Installed as VM (GNOME only)
sh setup-vm.sh
sh software.sh
```

### System Description
GNOME or KDE Desktop Enviornment
GDM or SDDM Login Manager

Booting using `systemd` 

### Credits
__[Credits to rickellis - ArchMatic for inspiration](https://github.com/ChrisTitusTech/ArchMatic)__