#!/usr/bin/env bash
# This WILL format and partition 1 drive in your system. It is recommended to run the script with only 1 drive installed.
# Selected drive is /dev/nvme0n1, replace sda with specified drive if you have multiple. List drives with 'lsblk'
# Change boot, SWAP, and root partition sizes to your needs in lines 15-17

echo "-------------------------------------------------"
echo "Setting up partitions - DRIVE WILL BE WIPED"
echo "-------------------------------------------------"

# disk prep
sgdisk -Z /dev/nvme0n1 # zap all on disk
sgdisk -a 2048 -o /dev/nvme0n1 # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:1024M /dev/nvme0n1 # partition 1 (boot)
sgdisk -n 2:0:8G /dev/nvme0n1 # partition 2 (SWAP - change to desired size)
sgdisk -n 3:0:50G /dev/nvme0n1 # partition 3 (root - change to desired size)
sgdisk -n 4:0:0 /dev/nvme0n1 # partition 4 (home, remaining space)

# set partition types
sgdisk -t 1:ef00 /dev/nvme0n1
sgdisk -t 2:8200 /dev/nvme0n1
sgdisk -t 3:8300 /dev/nvme0n1
sgdisk -t 4:8300 /dev/nvme0n1

# label partitions
sgdisk -c 1:"boot" /dev/nvme0n1
sgdisk -c 2:"swap" /dev/nvme0n1
sgdisk -c 3:"root" /dev/nvme0n1
sgdisk -c 4:"home" /dev/nvme0n1

# make filesystems
echo "-------------------------------------------------"
echo "Creating Filesystems"
echo "-------------------------------------------------"

mkfs.fat -F32 /dev/nvme0n1p1 # FAT32 boot partition
mkswap /dev/nvme0n1p2 # create SWAP
swapon /dev/nvme0n1p2 # enable SWAP
mkfs.ext4 /dev/nvme0n1p3
mkfs.ext4 /dev/nvme0n1p4

# mount partitions
echo "-------------------------------------------------"
echo "Mounting Partitions"
echo "-------------------------------------------------"

mount /dev/nvme0n1p3 /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/nvme0n1p1 /mnt/boot
mount /dev/nvme0n1p4 /mnt/home

# set download mirrors
echo "-------------------------------------------------"
echo "Setting Mirrorlist"
echo "-------------------------------------------------"

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup # backs up mirrorlist
sudo pacman -Syyy
sudo pacman -S pacman-contrib --noconfirm
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

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
echo "Finished install script 1. Please run [arch-chroot /mnt], create your user and move on to the 2nd installer."
echo "-------------------------------------------------"
