#!/usr/bin/env bash
# This WILL format and partition 1 drive in your system. It is recommended to run the script with only 1 drive installed.
# Change boot, SWAP, and root partition sizes to your needs in lines 15-17

echo "-------------------------------------------------"
echo "Arch Install Script 1 - Drive Setup"
echo "-------------------------------------------------"

lsblk
echo "Specify drive name for install (ex. /dev/sda, /dev/nvme0n1). THIS WILL FORMAT & PARTITION THE SPECIFIED DRIVE!"

read -r DISK

if [[ ! -b $DISK ]]; then
    echo "Disk $DISK does not exist."
    exit 1
fi

echo -e "\nFormatting disk...\n$HR"

# disk prep
sgdisk -Z $DISK 2>/dev/null # zap all on disk
sgdisk -a 2048 -o $DISK 2>/dev/null  # new gpt disk 2048 alignment

# create partitions
sgdisk -n 1:0:1024M $DISK 2>/dev/null  # partition 1 (boot)
sgdisk -n 2:0:8G $DISK 2>/dev/null  # partition 2 (SWAP - change to desired size)
sgdisk -n 3:0:75G $DISK 2>/dev/null # partition 3 (root - change to desired size)
sgdisk -n 4:0:0 $DISK 2>/dev/null # partition 4 (home, remaining space)

# partition types
sgdisk -t 1:ef00 $DISK 2>/dev/null
sgdisk -t 2:8200 $DISK 2>/dev/null
sgdisk -t 3:8300 $DISK 2>/dev/null
sgdisk -t 4:8300 $DISK 2>/dev/null

# label partitions
sgdisk -c 1:"boot" $DISK 2>/dev/null
sgdisk -c 2:"swap" $DISK 2>/dev/null
sgdisk -c 3:"root" $DISK 2>/dev/null
sgdisk -c 4:"home" $DISK 2>/dev/null 

echo -e "\nCreating Filesystems...\n$HR"

mkfs.fat -F32 ${DISK}1 # FAT32 boot partition
mkswap ${DISK}2 # create SWAP
swapon ${DISK}2 # enable SWAP
mkfs.ext4 ${DISK}3
mkfs.ext4 ${DISK}4

echo "-------------------------------------------------"
echo "Mounting Partitions"
echo "-------------------------------------------------"

mount ${DISK}3 /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount ${DISK}1 /mnt/boot
mount ${DISK}4 /mnt/home

echo "-------------------------------------------------"
echo "Downloading 2nd install script"
echo "-------------------------------------------------"

curl https://git.merlinslair.net/beech/ArchScripts/raw/branch/rework/install2.sh -o /mnt/install2.sh
sed -i 's/\r$//' /mnt/install2.sh
chmod +x /mnt/install2.sh

echo "-------------------------------------------------"
echo "Enabling Parallel Downloads"
echo "-------------------------------------------------"

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
pacman -Syy
pacman -S archlinux-keyring --noconfirm 
pacman -S pacman-contrib rsync reflector terminus-font --noconfirm --needed 
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
cat > /etc/pacman.d/mirrorlist << 'EOF'
##
## Arch Linux repository mirrorlist
## Generated on install
##
EOF
reflector -a 48 -c "US" -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist

# install arch
echo "-------------------------------------------------"
echo "Installing to drive"
echo "-------------------------------------------------"

pacstrap -K /mnt base linux linux-firmware base-devel --noconfirm --needed

echo "-------------------------------------------------"
echo "Installed - Generating fstab"
echo "-------------------------------------------------"

genfstab -U -p /mnt >> /mnt/etc/fstab

echo "-------------------------------------------------"
echo "Finished install script 1. Run install2.sh"
echo "-------------------------------------------------"

# chroot
arch-chroot /mnt /install2.sh