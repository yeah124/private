# Preparations
loadkeys hu
timedatectl set-ntp true
hwclock --systohc
clear
# Other
mount /dev/sdb1 /mnt
cp /mnt/scripts/archinstall/base/bad/install-sda.sh /root/install.sh
cp /mnt/scripts/archinstall/base/chroot.sh /root/chroot.sh
cd /root
umount -l /mnt
clear
# fdisk
echo "Disk partitioning"
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << FDISK_CMDS | sudo fdisk /dev/sda
g
n
1

+550M
n
2

+3G
n
3


t
1
1
t
2
19
t
3
20
w
FDISK_CMDS
clear
# Make filesystems
echo "Creating file systems ..."
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3
clear
# Base install
echo "Installing OS ..."
mount /dev/sda3 /mnt
pacstrap /mnt base linux-zen linux-firmware
genfstab -U /mnt >> /mnt/etc/fsab
clear
# Chroot
cp /root/chroot.sh /mnt/chroot.sh
arch-chroot /mnt && ./chroot.sh