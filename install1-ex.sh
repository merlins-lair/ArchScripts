#!/usr/bin/env bash
# This WILL format and partition 1 drive in your system. It is recommended to run the script with only 1 drive installed.
# Selected drive is /dev/sda, replace sda with specified drive if you have multiple. List drives with 'lsblk'
# Change boot, SWAP, and root partition sizes to your needs in lines 15-17

echo "-------------------------------------------------"
echo "Arch Install Script 1 - Drive Setup"
echo "-------------------------------------------------"

echo "Specify drive name for install(ex. /dev/sda, /dev/nvme0n1). THIS WILL FORMAT & PARTITION THE SPECIFIED DRIVE!"

read Diskname

# disk prep
sgdisk -Z $Diskname # zap all on disk
sgdisk -a 2048 -o $Diskname # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:1024M $Diskname # partition 1 (boot)
sgdisk -n 2:0:4G $Diskname # partition 2 (SWAP - change to desired size)
sgdisk -n 3:0:35G $Diskname # partition 3 (root - change to desired size)
sgdisk -n 4:0:0 $Diskname # partition 4 (home, remaining space)

# set partition types
sgdisk -t 1:ef00 $Diskname
sgdisk -t 2:8200 $Diskname
sgdisk -t 3:8300 $Diskname
sgdisk -t 4:8300 $Diskname

# label partitions
sgdisk -c 1:"boot" $Diskname
sgdisk -c 2:"swap" $Diskname
sgdisk -c 3:"root" $Diskname
sgdisk -c 4:"home" $Diskname

# make filesystems
echo "-------------------------------------------------"
echo "Creating Filesystems"
echo "-------------------------------------------------"

mkfs.fat -F32 $(Diskname)1 # FAT32 boot partition
mkswap $(Diskname)2 # create SWAP
swapon $(Diskname)2 # enable SWAP
mkfs.ext4 $(Diskname)3
mkfs.ext4 $(Diskname)4

# mount partitions
echo "-------------------------------------------------"
echo "Mounting Partitions"
echo "-------------------------------------------------"

mount $(Diskname)3 /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount $(Diskname)1 /mnt/boot
mount $(Diskname)4 /mnt/home

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
echo "Finished install script 1. Please run [arch-chroot /mnt], and move on to the 2nd installer."
echo "-------------------------------------------------"
