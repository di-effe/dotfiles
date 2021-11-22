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

Format EFI boot partitionmkf
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
mkfs.btrfs /dev/sda3
mount /dev/sda3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@var
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@.snapshots
umount -R /mnt

mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@ /dev/sda3 /mnt
mkdir /mnt/{boot,home,var,opt,tmp,.snapshots}
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@home /dev/sda3 /mnt/home
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@opt /dev/sda3 /mnt/opt
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@tmp /dev/sda3 /mnt/tmp
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@.snapshots /dev/sda3 /mnt/.snapshots
mount -o subvol=@var /dev/sda3 /mnt/var
mount /dev/sda1 /mnt/boot
```

## Update mirrors
```
pacman -Syy
```

## Install (AMD)
```
pacstrap /mnt base linux linux-firmware nano intel-ucode btrfs-progs
```

## Install (Intel)
```
pacstrap /mnt base linux linux-firmware nano amd-ucode btrfs-progs
```

## Install (VMs)
```
pacstrap /mnt base linux linux-firmware nano btrfs-progs
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
nano /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
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
echo KEYMAP=us-acentos > /etc/vconsole.conf
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


Create user and enable sudo
```
passwd 
useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/bash david
passwd david
pacman -S sudo
EDITOR=nano visudo
```

Install other packages
```
pacman -S grub grub-btrfs efibootmgr base-devel linux-headers networkmanager network-manager-applet 
pacman -S wpa_supplicant dialog os-prober mtools dosfstools reflector git snapper alacritty htop wget
pacman -S bluez bluez-utils xdg-utils xdg-user-dirs	
systemctl enable NetworkManager
systemctl enable bluetooth
reflector -c "IT" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

Adding btrfs module to mkinitcpio (MODULES=(btrfs)
```
nano /etc/mkinitcpio.conf
mkinitcpio -p linux
```

GRUB
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
```

Only for virtualbox
```
mkdir /boot/EFI/boot
cp /boot/EFI/Arch/grubx64.efi /boot/EFI/boot/bootx64.efi
```

Reboot
```
exit
umount -l /mnt
reboot
```







# Arch [KDE] 


For AMD video cards
```
sudo pacman -S xf86-video-amdgpu
```

For ATI video cards
```
sudo pacman -S xf86-video-ati
```
For Intel video cards
```
sudo pacman -S xf86-video-intel
```
For nVidia video cards
```
sudo pacman -S nvidia
```

Install xorg
```
sudo pacman -S xorg
```

Install KDE & Applications
5 13 14 44 48 49 51 52 53 58 106 132 142 145 153 170
```
sudo pacman -S plasma-meta
sudo pacman -S kde-applications
```

Enable SDDM
```
sudo systemctl enable sddm
```

Reboot


# Arch [Qtile] 


For AMD video cards
```
sudo pacman -S xf86-video-amdgpu
```

For ATI video cards
```
sudo pacman -S xf86-video-ati
```
For Intel video cards
```
sudo pacman -S xf86-video-intel
```
For nVidia video cards
```
sudo pacman -S nvidia
```

Install Qtile
```
sudo pacman -S xorg-server xorg-apps xorg-xinit xterm alacritty sddm
sudo systemctl enable sddm.service
sudo pacman -S qtile
mkdir -p ~/.config/qtile/
cp /usr/share/doc/qtile/default_config.py ~/.config/qtile/config.py
```



# Arch [Qtile] 


For AMD video cards
```
sudo pacman -S xf86-video-amdgpu
```

For ATI video cards
```
sudo pacman -S xf86-video-ati
```
For Intel video cards
```
sudo pacman -S xf86-video-intel
```
For nVidia video cards
```
sudo pacman -S nvidia
```

Install Awesome
```
sudo pacman -S xorg-server xorg-apps xorg-xinit xterm alacritty sddm
sudo systemctl enable sddm.service
sudo pacman -S awesome
mkdir -p ~/.config/awesome/
cp /etc/xdg/awesome/rc.lua ~/.config/awesome/
```