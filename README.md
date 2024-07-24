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

# Enter Arch root directory
arch-chroot /mnt

# Set your root password
passwd

# Create your user account, replace USERNAME with your desired username
useradd -m -g users -G wheel,storage,power -s /bin/bash USERNAME

# Set the password for your account, replace USERNAME with the user you created
passwd USERNAME

# Run this & take note of your network adapter name (ex: ens33)
ip link 

# Installer 2 Setup
sudo pacman -S nano curl --noconfirm --needed
curl https://git.boppdev.net/beech/ArchScripts/raw/branch/main/preinstall2.sh -o preinstall2.sh

# Edit network adapter name for dhcpcd service in script line 43
nano preinstall2.sh

# Installer 2
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
sudo pacman -S --noconfirm pacman-contrib git
sudo git clone https://git.boppdev.net/beech/ArchScripts
cd ArchScripts

# Normal Install
sh setup-gnome.sh # GNOME install
OR
sh setup-kde.sh # KDE install

reboot

sh software.sh
```

### After First Boot (VM)

```bash
sudo pacman -S --noconfirm pacman-contrib git
sudo git clone https://git.boppdev.net/beech/ArchScripts
cd ArchScripts

# Installed as VM
sh setup-vmgnome.sh # GNOME install (VM)
OR
sh setup-vmkde.sh # KDE install (VM)

# Audio Fix for VMs
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/
cd ~/.config/wireplumber/wireplumber.conf.d
nano 50-alsa-config.conf

# Add the following lines:
monitor.alsa.rules = [
  {
    matches = [
      # This matches the value of the 'node.name' property of the node.
      {
        node.name = "~alsa_output.*"
      }
    ]
    actions = {
      # Apply all the desired node specific settings here.
      update-props = {
        api.alsa.period-size   = 1024
        api.alsa.headroom      = 8192
      }
    }
  }
]

# Reboot Machine
reboot

sh software.sh
```

### System Description
GNOME or KDE Desktop Enviornment

GDM or SDDM Login Manager

### Credits
__[Inspired by ArchTitus](https://github.com/ChrisTitusTech/ArchTitus)__