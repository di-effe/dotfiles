# Arch [UEFI install] 

## NTP
``` 
timedatectl set-ntp true
timedatectl status
```

## PARTITIONS
Check disk device name (/dev/sda in this example)
```
fdisk -l
```
Erase disk
```
wipefs -a /dev/sda
```
Parition disk
```
cfdisk /dev/sda
```
- EFI boot (500Mb~1GB)
- Swap
- Root

Format EFI boot partition
```
mkfs.fat -F32 /dev/sda1
```
Swap
```
mkswap /dev/sda2
swapon /dev/sda2
```
Filesystem
```
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

Filesystem BTRFS
```
mkfs.btrfs /dev/sda3
mount /dev/sda3 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount -R /mnt
mount -o subvol=@ /dev/sda3 /mnt
mkdir -p /mnt/home
mount -o subvol=@home /dev/sda3 /mnt/home
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
```

## Pacman mirrors
```
pacman -S reflector 
reflector -c "IT" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
pacman -Syy
```

## Install
```
pacstrap /mnt base base-devel linux linux-firmware nano
```

## Install BTRFS
```
pacstrap /mnt base base-devel linux linux-firmware nano btrfs-progs grub-btrfs
```

## Create fstab
```
genfstab -U /mnt >> /mnt/etc/fstab
```

## Complete install
```
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc
pacman -S nano
nano /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

This can done later
```
echo "LC_ADDRESS=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_NAME=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_PAPER=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_TIME=it_IT.UTF-8" >> /etc/locale.conf
```

Update keymap for US International with accented chars support
```
echo KEYMAP=us-acentos >> /etc/vconsole.conf
```

Hostname & Hosts
```
echo archvirt > /etc/hostname
nano /etc/hosts

127.0.0.1	localhost
127.0.1.1	[your_hostname].localdomain [your_hostname]
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters
```

Network manager
```
pacman -S networkmanager 
systemctl enable NetworkManager
```

Create user and enable sudo
```
passwd 
useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/bash david
passwd david
EDITOR=nano visudo
```

GRUB
```
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
```

Only for virtualbox
```
mkdir /boot/efi/EFI/boot
cp /boot/efi/EFI/arch/grubx64.efi /boot/efi/EFI/boot/bootx64.efi
```

Reboot
```
exit
umount -a
reboot
```


# Arch [Xorg, LidhtDM, Qtile] 

```
sudo pacman -S xorg-server xorg-apps xorg-xinit xterm
sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm.service
sudo pacman -S qtile
mkdir -p ~/.config/qtile/
cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
```


# Arch [Xorg, LidhtDM, Qtile] 

```
sudo pacman -S xorg-server xorg-apps xorg-xinit xterm
sudo pacman -S sddm
sudo systemctl enable sddm.service
sudo pacman -S qtile
mkdir -p ~/.config/qtile/
cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
```