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

# Enter Arch root directory
arch-chroot /mnt

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
sudo pacman -S --noconfirm pacman-contrib
sudo git clone https://git.merlinslair.net/beech/ArchScripts
cd ArchScripts
chmod +x install3.sh
sh install3.sh

reboot
```

# Audio Fix for VMs
```bash
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/

cd ~/.config/wireplumber/wireplumber.conf.d

nano 50-alsa-config.conf
```

Add the following lines:

```bash
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
```

Reboot Machine

### System Description
GNOME or KDE Desktop Environment 

GDM or SDDM Login Manager

### Credits
__[Inspired by ArchTitus](https://github.com/ChrisTitusTech/ArchTitus)__