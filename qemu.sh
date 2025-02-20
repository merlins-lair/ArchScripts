#!/usr/bin/env bash
PKGS=(

    'qemu'
    'virt-manager'
    'virt-viewer'
    'dnsmasq'
    'vde2'
    'bridge-utils'
    'openbsd-netcat'
    'ebtables'
    'iptables'
    'libguestfs'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

sudo sed -i 's/^#unix_sock_group = "libvirt"/unix_sock_group = "libvirt"/' /etc/libvirt/libvirtd.conf
sudo sed -i 's/^#unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0770"/' /etc/libvirt/libvirtd.conf
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
echo
echo "Virt manager installed!"
echo