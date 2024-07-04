# Arch Linux Install Scripts

My modified ArchMatic scripts for a full Arch install & configuration with DE, support packages, and apps. Forked for VMWare optimization.

---

## Arch Live ISO (Pre-Install)

This step installs arch to your hard drive. *IT WILL FORMAT THE DISK*

Boot into your Arch ISO

```bash
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall1.sh -o preinstall1.sh
sh preinstall1.sh

arch-chroot /mnt

passwd
useradd -M -g users -G wheel,storage,power -s /bin/bash USERNAME
passwd USERNAME
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo "Defaults rootpw" >> /etc/sudoers

ip link # Take note of your link name & edit in preinstall2.

# Run preinstall2.sh
sudo pacman -S nano curl --noconfirm --needed
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall2.sh -o preinstall2.sh
nano preinstall2.sh
# Edit adapter name for dhcpcd service in script
sh preinstall2.sh
exit
umount -R /mnt
```

### After First Boot

```bash
pacman -S --noconfirm pacman-contrib curl git
git clone https://git.boppdev.net/beech/ArchScripts
cd ArchScripts
sh setup.sh
sh software.sh
```

### System Description
GNOME Desktop Enviornment
GDM Login Manager

Booting using `systemd` 

### Credits
__[Credits to rickellis - ArchMatic for inspiration](https://github.com/ChrisTitusTech/ArchMatic)__