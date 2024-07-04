# ArchMatic Installer Script - VMWare

My modified ArchMatic scripts for a full Arch install & configuration with DE, support packages, and apps. Forked for VMWare optimization.

---

## Setup Boot and Arch ISO on USB key

First, setup the boot USB, boot arch live iso, and run the `preinstall.sh` from terminal. 

### Arch Live ISO (Pre-Install)

This step installs arch to your hard drive. *IT WILL FORMAT THE DISK*

```bash
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall1.sh -o preinstall1.sh
sh preinstall1.sh

passwd
useradd -M -g users -G wheel,storage,power -S /bin/bash USERNAME
passwd USERNAME
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
echo "Defaults rootpw" >> /etc/sudoers

ip link # Take note of your link name & edit in preinstall2.

# Run preinstall2.sh

curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall2.sh -o preinstall2.sh
nano preinstall2.sh
# Edit adapter name for dhcpcd service in script
sh preinstall2.sh
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

Installs the LTS Kernel along side the rolling one, and configures the bootloader to offer both as a choice during startup. This allows you to switch kernels in the event of a problem with the rolling one.

### Credits

__[Credits to johnynfulleffect's fork of ArchMatic](https://github.com/johnynfulleffect/ArchMatic)__

__[Credits to rickellis - ArchMatic](https://github.com/ChrisTitusTech/ArchMatic)__