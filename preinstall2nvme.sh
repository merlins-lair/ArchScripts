#!/usr/bin/env bash

# Create your user account following the README instructions before running this.
# Edit hostname on line 26 if desired

# File edits for user permissions

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo "Defaults rootpw" >> /etc/sudoers

# generate locales

sudo pacman -S bash-completion --noconfirm --needed
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

# set timezone & link HW clock

ln -s /usr/share/zoneinfo/America/Chicago > /etc/localtime
hwclock --systohc --utc

# set hostname - edit archdesk with preferred hostname

echo archdesk > /etc/hostname

# Enable TRIM

systemctl enable fstrim.timer

# mount efivars

mount -t efivarfs efivarfs /sys/firmware/efi/efivars/

# install bootloader

bootctl install

touch /boot/loader/entries/arch.conf

echo "title Arch" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf

echo "options root=PARTUUID=$(blkid -s PARTUUID -o value /dev/nvme0n1p3) rw" >> /boot/loader/entries/arch.conf

# install dhcpd service

sudo pacman -S dhcpcd --noconfirm --needed

sudo systemctl enable dhcpcd@ADAPTER.service # EDIT "ADAPTER" WITH YOUR ADAPTER IN IP LINK

# install NetworkManager

sudo pacman -S networkmanager --noconfirm --needed
sudo systemctl enable NetworkManager.service


echo "-------------------------------------------------"
echo "Arch Linux Installed & Configured. Please [exit] & run [umount -R /mnt] and reboot"
echo "-------------------------------------------------"