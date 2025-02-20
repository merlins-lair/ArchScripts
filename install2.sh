#!/usr/bin/env bash

lsblk
echo "Specify drive name that you entered in the first script."

read -r -p "Enter the disk: " DISK

echo "Create a root password (not your user password)."

passwd

echo "Create a user account."

read -r -p "Create username: " Username

useradd -m -g users -G wheel,storage,power -s /bin/bash $Username

echo "Create a USER password (should be different from root)."

passwd $Username

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

echo "Set hostname (name of your PC on the network)."

read -r -p "Enter the hostname: " HOSTNAME

echo ${HOSTNAME} > /etc/hostname

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

echo "options root=PARTUUID=$(blkid -s PARTUUID -o value ${DISK}3) rw" >> /boot/loader/entries/arch.conf

# install NetworkManager

sudo pacman -S networkmanager --noconfirm --needed
sudo pacman -S git --noconfirm --needed
sudo sed -i '/^\#\[multilib\]/s/^#//' /etc/pacman.conf
sudo sed -i '/^\#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm --needed
sudo pacman -S base-devel linux-headers --noconfirm --needed
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

echo "-------------------------------------------------"
echo "Arch Linux Installed & Configured. Please [exit] & run [umount -R /mnt] and reboot"
echo "-------------------------------------------------"