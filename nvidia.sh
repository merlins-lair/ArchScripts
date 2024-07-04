#!/usr/bin/env bash
echo "-------------------------------------------------"
echo "Installing Nvidia Graphics Drivers"
echo "-------------------------------------------------"

sudo pacman -S linux-headers --noconfirm
sudo pacman -S nvidia-dkms libglvnd nvidia-utils opencl-nvidia lib32-libglvnd lib32-nvidia-utils lib32-opencl-nvidia nvidia-settings --noconfirm

sed -i 's/^MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sed -i 's/^#rw/rw nvidia-drm.modeset=1/' /boot/loader/entries/arch.conf

sudo mkdir /etc/pacman.d/hooks
touch /etc/pacman.d/hooks/nvidia.hook
echo "[Trigger]" > /etc/pacman.d/hooks
echo "Operation=Install" >> /etc/pacman.d/hooks
echo "Operation=Upgrade" >> /etc/pacman.d/hooks
echo "Operation=Remove" >> /etc/pacman.d/hooks
echo "Type=Package" >> /etc/pacman.d/hooks
echo "Target=nvidia" >> /etc/pacman.d/hooks
echo "[Action]" >> /etc/pacman.d/hooks
echo "Depends=mkinitcpio" >> /etc/pacman.d/hooks
echo "When=PostTransaction" >> /etc/pacman.d/hooks
echo "Exec=/usr/bin/mkinitcpio -P" >> /etc/pacman.d/hooks

echo "-------------------------------------------------"
echo "Nvidia Drivers Installed & Hooks Setup"
echo "-------------------------------------------------"