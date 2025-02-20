#!/usr/bin/env bash
# This WILL format and partition 1 drive in your system. It is recommended to run the script with only 1 drive installed.
# Selected drive is /dev/sda, replace sda with specified drive if you have multiple. List drives with 'lsblk'
# Change boot, SWAP, and root partition sizes to your needs in lines 15-17

echo "-------------------------------------------------"
echo "Arch Install Script 1 - Drive Setup"
echo "-------------------------------------------------"

lsblk
echo "Specify drive name for install (ex. /dev/sda, /dev/nvme0n1). THIS WILL FORMAT & PARTITION THE SPECIFIED DRIVE!"

read -r -p "Enter the disk: " DISK

echo -e "\nFormatting disk...\n$HR"

# disk prep
sgdisk -Z $DISK # zap all on disk
sgdisk -a 2048 -o $DISK  # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:1024M $DISK  # partition 1 (boot)
sgdisk -n 2:0:4G $DISK  # partition 2 (SWAP - change to desired size)
sgdisk -n 3:0:35G $DISK # partition 3 (root - change to desired size)
sgdisk -n 4:0:0 $DISK # partition 4 (home, remaining space)

# set partition types
sgdisk -t 1:ef00 $DISK 
sgdisk -t 2:8200 $DISK 
sgdisk -t 3:8300 $DISK 
sgdisk -t 4:8300 $DISK 

# label partitions
sgdisk -c 1:"boot" $DISK 
sgdisk -c 2:"swap" $DISK 
sgdisk -c 3:"root" $DISK 
sgdisk -c 4:"home" $DISK 

# make filesystems
echo -e "\nCreating Filesystems...\n$HR"

mkfs.fat -F32 ${DISK}1 # FAT32 boot partition
mkswap ${DISK}2 # create SWAP
swapon ${DISK}2 # enable SWAP
mkfs.ext4 ${DISK}3
mkfs.ext4 ${DISK}4

# mount partitions
echo "-------------------------------------------------"
echo "Mounting Partitions"
echo "-------------------------------------------------"

mount ${DISK}3 /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount ${DISK}1 /mnt/boot
mount ${DISK}4 /mnt/home

# set download mirrors
echo "-------------------------------------------------"
echo "Setting Mirrorlist"
echo "-------------------------------------------------"

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
pacman -Sy
pacman -S archlinux-keyring --noconfirm 
pacman -S pacman-contrib terminus-font --noconfirm --needed 
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
echo "" > /etc/pacman.d/mirrorlist
pacman -S reflector rsync --noconfirm --needed 
reflector -a 48 -c "US" -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist

# install arch
echo "-------------------------------------------------"
echo "Installing to drive"
echo "-------------------------------------------------"

pacstrap -K /mnt base linux linux-firmware base-devel --noconfirm --needed

echo "-------------------------------------------------"
echo "Installed - Generating fstab"
echo "-------------------------------------------------"

# generate fstab

genfstab -U -p /mnt >> /mnt/etc/fstab

echo "-------------------------------------------------"
echo "Finished install script 1. Run install2.sh"
echo "-------------------------------------------------"

# chroot
arch-chroot /mnt

