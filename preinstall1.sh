#!/usr/bin/env bash
echo "-------------------------------------------------"
echo "Setting up partitions - DRIVE WILL BE WIPED"
echo "-------------------------------------------------"

# disk prep
sgdisk -Z /dev/sda # zap all on disk
sgdisk -a 2048 -o /dev/sda # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:1024M /dev/sda # partition 1 (boot)
sgdisk -n 2:0:4G /dev/sda # partition 2 (SWAP)
sgdisk -n 3:0:35G /dev/sda # partition 3 (root)
sgdisk -n 4:0:0 /dev/sda # partition 4 (home, remaining space)

# set partition types
sgdisk -t 1:ef00 /dev/sda
sgdisk -t 2:8200 /dev/sda
sgdisk -t 3:8300 /dev/sda
sgdisk -t 4:8300 /dev/sda

# label partitions
sgdisk -c 1:"boot" /dev/sda
sgdisk -c 2:"swap" /dev/sda
sgdisk -c 3:"root" /dev/sda
sgdisk -c 4:"home" /dev/sda

# make filesystems
echo "-------------------------------------------------"
echo "Creating Filesystems"
echo "-------------------------------------------------"

mkfs.fat -F32 /dev/sda1 # FAT32 boot partition
mkswap /dev/sda2 # create SWAP
swapon /dev/sda2 # enable SWAP
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

# mount partitions
echo "-------------------------------------------------"
echo "Mounting Partitions"
echo "-------------------------------------------------"

mount /dev/sda3 /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

# set download mirrors

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup # backs up mirrorlist
sudo pacman -Sy pacman-contrib
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# install arch

pacstrap -K /mnt base linux linux-firmware base-devel

echo "-------------------------------------------------"
echo "Arch Installed - Generating fstab and entering chroot"
echo "-------------------------------------------------"

# generate fstab

genfstab -U -p /mnt >> /mnt/etc/fstab

arch chroot /mnt # chroot

# generate locales

sudo pacman -S nano bash-completion
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

# set timezone & link HW clock

ln -S /usr/share/zoneinfo/America/Chicago > /etc/localtime
hwclock --systohc --utc

# set hostname

echo archdesk > /etc/hostname

# Enable TRIM

systemctl enable fstrim.timer

echo "-------------------------------------------------"
echo "Create user accounts using commands in README, then proceed to 2nd installer."
echo "-------------------------------------------------"
