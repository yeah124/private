# Chroot
ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime
pacman -S nano --noconfirm
sed -i "/hu/s/^#//g/" /etc/locale.gen
locale-gen
touch /mnt/etc/hostname
sed -i '1i archlinux' /etc/hostname
sed -i '4i 127.0.0.1	localhost' /etc/hosts
sed -i '5i ::1		localhost' /etc/hosts
sed -i '6i 127.0.1.1	localdomain.archlinux	archlinux' /etc/hosts
clear
# Users and passwords
echo "Enter the password for root"
passwd
useradd -m patrik
echo "Enter the password for user"
passwd patrik
usermod -aG wheel,audio,video,storage,optical patrik
clear
# Sudo
pacman -S sudo --noconfirm
EDITOR=nano visudo
clear
# GRUB
pacman -S grub efibootmgr dosfstools mtools os-prober --noconfirm
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=arch --recheck
sed -i "/OS-PROBER/s/^#//g/" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
clear
# Networking
pacman -S networkmanager openssh base-devel git --noconfirm
systemctl enable NetworkManager sshd
clear
echo "Installing i3 and kde-plasma"
pacman -S i3 i3-wm sddm plasma plasma-wayland-session kde-applications --noconfirm
systemctl enable sddm
echo "Restarting, after screen turned black remove installation medium"