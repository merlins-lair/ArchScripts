#!/usr/bin/env bash

# mount efivars

mount -t efivarfs efivarfs /sys/firmware/efi/efivars/

# install bootloader

bootctl install

touch /boot/loader/entries/arch.conf

echo "title Arch" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf

echo "options root=PARTUUID=$(blkid -S PARTUUID -o value /dev/sda3) rw" >> /boot/loader/entries/arch.conf

# install dhcpd service

sudo pacman -S dhcpcd
sudo systemctl enable dhcpcd@ADAPTER.service # EDIT "ADAPTER" WITH YOUR ADAPTER IN IP LINK

# install NetworkManager

sudo pacman -S networkmanager
sudo systemctl enable NetworkManager.service


echo "-------------------------------------------------"
echo "Arch Linux Installed & Configured - Reboot & Proceed to setup scripts"
echo "-------------------------------------------------"

exit
umount -R /mnt