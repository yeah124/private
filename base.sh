# Preparations
loadkeys hu
timedatectl set-ntp true
hwclock --systohc
clear
# fdisk
echo "Disk partitioning"
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << FDISK_CMDS | sudo fdisk /dev/vda
g
n
1

+550M
n
2



t
1
1
t
2
20
w
FDISK_CMDS
clear
# Make filesystems
echo "Creating file systems ..."
mkfs.fat -F 32 /dev/vda1
mkfs.ext4 /dev/vda2
clear
# Base install
echo "Installing OS ..."
mount /dev/vda2 /mnt
pacstrap /mnt base linux-zen linux-firmware
genfstab -U /mnt >> /mnt/etc/fsab
clear
# Chroot
cp /root/chroot.sh /mnt/chroot.sh
arch-chroot /mnt && ./chroot.sh
