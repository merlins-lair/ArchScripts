# Arch Linux Install Scripts

Scripts for Arch install & configuration with DE, support packages, and apps. Includes VMWare drivers.

---

## Arch Live ISO

This step installs Arch to your hard drive. *IT WILL FORMAT THE DISK*

Boot into your Arch ISO

```bash
# Installer 1
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall1.sh -o preinstall1.sh
sh preinstall1.sh

# Creating user account - Run commands below & replace "USERNAME" with your preferred username.
arch-chroot /mnt

passwd # This is your ROOT password
useradd -m -g users -G wheel,storage,power -s /bin/bash USERNAME
passwd USERNAME # This is your USER password
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo "Defaults rootpw" >> /etc/sudoers

ip link # Take note of your network adapter name (ex: ens33)

# Installer 2 Setup
sudo pacman -S nano curl --noconfirm --needed
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall2.sh -o preinstall2.sh

# Edit network adapter name for dhcpcd service in script line 43
nano preinstall2.sh

# Installer 2
sh preinstall2.sh

# Preparing for first boot
exit
umount -R /mnt
reboot # Remove installation media during reboot
```

### After First Boot

```bash
sudo pacman -S --noconfirm pacman-contrib curl git
sudo git clone https://git.boppdev.net/beech/ArchScripts
cd ArchScripts
sh setup.sh # Comment out line 9 if you're not on a VM
sh software.sh
```

### System Description
GNOME Desktop Enviornment
GDM Login Manager

Booting using `systemd` 

### Credits
__[Credits to rickellis - ArchMatic for inspiration](https://github.com/ChrisTitusTech/ArchMatic)__