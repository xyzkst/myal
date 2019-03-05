#!/bin/env bash

echo "Installing..."
echo "timedatectl set-ntp true"
timedatectl set-ntp true
echo "done"

echo "mkfs.ext4 /dev/sda2"
echo "mount /dev/sda2 /mnt"
echo "mkdir /mnt/boot"
echo "mount /dev/sdxY /mnt/boot"
mkfs.ext4 -y /dev/sda2
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
echo "done"

echo "vim /etc/pacman.d/mirrorlist"
sed -i '1i\Server = http://mirrors.163.com/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
echo "done"

echo "pacstrap /mnt base base-devel"
pacstrap /mnt base base-devel
echo "done"

echo "genfstab -L /mnt >> /mnt/etc/fstab"
genfstab -L /mnt >> /mnt/etc/fstab
echo "done"

echo "arch-chroot /mnt"
arch-chroot /mnt
echo "done"

echo "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "done."

echo "hwclock --systohc"
hwclock --systohc
echo "done."

echo "pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager"
pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager
echo "done."

echo "vim /etc/locale.gen"
sed -i '1i\zh_TW.UTF-8 UTF-8' /etc/locale.gen
sed -i '1i\zh_HK.UTF-8 UTF-8' /etc/locale.gen
sed -i '1i\zh_CN.UTF-8 UTF-8' /etc/locale.gen
sed -i '1i\en_US.UTF-8 UTF-8' /etc/locale.gen
locale-gen
echo "done."

echo "vim /etc/locale.conf"
touch /etc/locale.conf
sed -i '1i\LANG=en_US.UTF-8' /etc/locale.conf
echo "done."

echo "vim /etc/hostname"
touch /etc/hostname
sed -i '1i\arch' /etc/hostname
echo "done."

echo "vim /etc/hosts"
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo "done."

echo "pacman -S intel-ucode"
pacman -S intel-ucode
echo "done."

echo "pacman -S os-prober"
pacman -S os-prober
echo "done."

echo "pacman -S grub efibootmgr"
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
exit
reboot
echo "done."
echo "complete!"

