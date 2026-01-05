#!/usr/bin/env bash

lsblk
echo "Specify drive name that you entered in the first script (ex. /dev/sda, /dev/nvme0n1)."

read -r -p "Enter the disk: " DISK

echo "Create a root password (not your user password)."

passwd

echo "Create a user account."

read -r -p "Create username: " Username

useradd -m -g users -G wheel,storage,power -s /bin/bash $Username

echo "Create a USER password (should be different from root)."

passwd $Username

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo "Defaults rootpw" >> /etc/sudoers

sudo pacman -S bash-completion --noconfirm --needed

pacman -S reflector --noconfirm --needed 2>/dev/null || true
reflector -a 48 -c "US" -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist 2>/dev/null || true

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc --utc

echo "Set hostname (name of your PC on the network)."

read -r -p "Enter the hostname: " HOSTNAME

echo ${HOSTNAME} > /etc/hostname

systemctl enable fstrim.timer

mount -t efivarfs efivarfs /sys/firmware/efi/efivars/

bootctl install

# Fix boot permissions
chmod 755 /boot
chmod 600 /boot/loader/random-seed 2>/dev/null || true

touch /boot/loader/entries/arch.conf

echo "title Arch" > /boot/loader/entries/arch.conf
echo "linux /vmlinuz-linux" >> /boot/loader/entries/arch.conf
echo "initrd /initramfs-linux.img" >> /boot/loader/entries/arch.conf

echo "options root=PARTUUID=$(blkid -s PARTUUID -o value ${DISK}3) rw" >> /boot/loader/entries/arch.conf

sudo pacman -S networkmanager --noconfirm --needed
sudo pacman -S git --noconfirm --needed
sudo sed -i '/^\#\[multilib\]/s/^#//' /etc/pacman.conf
sudo sed -i '/^\#Include = \/etc\/pacman.d\/mirrorlist/s/^#//' /etc/pacman.conf
sudo pacman -Syu --noconfirm --needed
sudo pacman -S base-devel linux-headers --noconfirm --needed
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

umount /sys/firmware/efi/efivars/ 2>/dev/null || true

echo "-------------------------------------------------"
echo "Arch Linux Installed & Configured. Please [exit] & run [umount -R /mnt] and reboot"
echo "-------------------------------------------------"