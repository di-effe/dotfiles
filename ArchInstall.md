# Arch [UEFI install] 

Ref: https://www.ordinatechnic.com/distribution-specific-guides/Arch/an-arch-linux-installation-on-a-btrfs-filesystem-with-snapper-for-system-snapshots-and-rollbacks

## Init
``` 
timedatectl set-ntp true
timedatectl status
pacman-key --init  
pacman-key --populate archlinux
pacman -Syy
pacman -S btrfs-progs nano which tree
```

## Create partitions
Check disk device name 
This guide will use /dev/sda as an example and will create 4 partitions:
- EFI boot (500Mb~1GB)
- Swap
- Root (btrfs)
- Home (ext4)

Check disk device name 
```
fdisk -l
```
Erase disk
```
wipefs -a /dev/sda
```
Partition disk
```
cfdisk /dev/sda
```


Format partitions
```
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.btrfs -L ROOT -f -n 32k /dev/sda3
mkfs.ext4 -L HOME /dev/sda4
```


## Create volumes 
```
mount /dev/sda3 /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@/.snapshots
mkdir /mnt/@/.snapshots/1
btrfs subvolume create /mnt/@/.snapshots/1/snapshot
mkdir /mnt/@/boot
btrfs subvolume create /mnt/@/boot/grub
btrfs subvolume create /mnt/@/opt
btrfs subvolume create /mnt/@/root
btrfs subvolume create /mnt/@/srv
btrfs subvolume create /mnt/@/tmp
mkdir /mnt/@/usr
btrfs subvolume create /mnt/@/usr/local
mkdir /mnt/@/var
btrfs subvolume create /mnt/@/var/cache
btrfs subvolume create /mnt/@/var/log
btrfs subvolume create /mnt/@/var/spool
btrfs subvolume create /mnt/@/var/tmp
```

## Snapper config

Create the metadata required by Snapperfor the initial installation snapshot.
```
nano /mnt/@/.snapshots/1/info.xml
```
Replace date and time (date +"%Y-%m-%d %H:%M:%S")
```
<?xml version="1.0"?>
<snapshot>
	<type>single</type>
	<num>1</num>
	<date>2021-11-01 21:56:17</date>
	<description>First Root Filesystem Created at Installation</description>
</snapshot>
```

Set default volume to the initial installation snapshot
```
btrfs subvolume get-default /mnt
```
Make the initial snapshot subvolume, /@/mnt/.snapshots/1/snapshot, the default subvolume.
```
btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/1/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt
```
Check output
```
btrfs subvolume get-default /mnt
```

Enable quota
```
btrfs quota enable /mnt
```

Disable copy-on-write for the /@/var subvolumes this will require the nodatacow mount option, which will disable compression for these subvolumes.
```
chattr +C /mnt/@/var/cache
chattr +C /mnt/@/var/log
chattr +C /mnt/@/var/spool
chattr +C /mnt/@/var/tmp
```

## Mount volumes

Unmount the Btrfs filesystem.
```
umount /mnt
```

Mount the Btrfs Filesystem
```
mount -o compress=zstd /dev/sda3 /mnt

mkdir /mnt/{.snapshots,opt,root,srv,tmp,home}
mkdir -p /mnt/boot/grub
mkdir -p /mnt/usr/local
mkdir -p /mnt/var/cache
mkdir -p /mnt/var/log
mkdir -p /mnt/var/spool
mkdir -p /mnt/var/tmp

mount -o subvol=@/.snapshots,compress=zstd /dev/sda3 /mnt/.snapshots
mount -o subvol=@/opt,compress=zstd /dev/sda3 /mnt/opt
mount -o subvol=@/root,compress=zstd /dev/sda3 /mnt/root
mount -o subvol=@/srv,compress=zstd /dev/sda3 /mnt/srv
mount -o subvol=@/tmp,compress=zstd /dev/sda3 /mnt/tmp
mount -o subvol=@/usr/local,compress=zstd /dev/sda3 /mnt/usr/local
mount -o subvol=@/var/cache,nodatacow /dev/sda3 /mnt/var/cache
mount -o subvol=@/var/log,nodatacow /dev/sda3 /mnt/var/log
mount -o subvol=@/var/spool,nodatacow /dev/sda3 /mnt/var/spool
mount -o subvol=@/var/tmp,nodatacow /dev/sda3 /mnt/var/tmp

mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

```

## Install base and kernels 

AMD
```
pacstrap /mnt base linux linux-firmware intel-ucode
```

INTEL
```
pacstrap /mnt base linux linux-firmware amd-ucode
```

VM
```
pacstrap /mnt base linux linux-firmware 
```


## Extra packages
```
pacstrap /mnt grub grub-btrfs btrfs-progs os-prober efibootmgr
pacstrap /mnt base-devel linux-headers 
pacstrap /mnt snapper snap-pac
pacstrap /mnt sudo nano vim neovim fish starship reflector git alacritty curl wget htop bat exa fd feh 
pacstrap /mnt adobe-source-code-pro-fonts adobe-source-sans-fonts otf-font-awesome ttf-ubuntu-font-family ttf-dejavu ttf-liberation noto-fonts
pacstrap /mnt man-db man-pages texinfo
pacstrap /mnt networkmanager network-manager-applet bluez bluez-utils wpa_supplicant dialog mtools dosfstools
pacstrap /mnt xorg-server xorg-xinit xorg-apps xdg-utils xdg-user-dirs lxappearance lxsession xdotool xterm

```

## fstab & brtfs related fixes


Remove the subvolume identifier mount options (subvolid=258,subvol=/@/.snapshots/1/snapshot) on the line where / is the target.

```
genfstab -U /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab
```


Edit the files /etc/grub.d/10_linux and /etc/grub.d/20_linux_xen and in both files remove
*rootflags=subvol=${rootsubvol}*
```
nano /mnt/etc/grub.d/10_linux
nano /mnt/etc/grub.d/20_linux_xen
```


## Complete base config
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
```
```
127.0.0.1	localhost
127.0.1.1	[your_hostname].localdomain [your_hostname]
::1        	localhost ip6-localhost ip6-loopback
ff02::1    	ip6-allnodes
ff02::2    	ip6-allrouters
```


Create user and enable sudo
```
passwd 
useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/bash david
passwd david
EDITOR=nano visudo
```

Enable services and set mirrors
```
systemctl enable NetworkManager
systemctl enable bluetooth
reflector -c "IT" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

Adding btrfs module to mkinitcpio (MODULES=(btrfs)
```
nano /etc/mkinitcpio.conf
mkinitcpio -p linux
```



Configure snapper
```
umount /.snapshots
rm -r /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod 750 /.snapshots

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


## Boot into Arch & complete config
```
exit
umount -l /mnt
reboot
```

Change user shell

```
chsh -s /usr/bin/fish
```

## Video drivers
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
For VMs
```
sudo pacman -S xf86-video-vmware virtualbox-guest-utils theme
sudo systemctl enable vboxservice.service
```


Configure Paru
```
mkdir AUR
cd AUR
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -sic
```

Configure Yay
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

Install Snap pac grub integration
```
paru -Sa snap-pac-grub
```

Enable snapper scrubbing
```
sudo systemctl enable fstrim.timer
lsblk -o UUID /dev/sda3
sudo systemd-escape --template btrfs-scrub@.timer --path /dev/disk/by-label/ROOT
sudo systemctl enable <out previous command>
sudo systemctl start <out previous command>
```

Edit snapper config
```
sudo nano /etc/snapper/configs/root 
```
QGROUP="1/0"
NUMBER_LIMIT="10-35"
NUMBER_LIMIT_IMPORTANT="15-25"
TIMELINE_LIMIT_HOURLY="5"
TIMELINE_LIMIT_DAILY="5"
TIMELINE_LIMIT_WEEKLY="2"
TIMELINE_LIMIT_MONTHLY="3"
TIMELINE_LIMIT_YEARLY="0"

Enable snapper timeline
```
sudo systemctl enable snapper-timeline.timer
sudo systemctl start snapper-timeline.timer
sudo systemctl enable snapper-cleanup.timer
sudo systemctl start snapper-cleanup.timer
```



# LeftWM


## Xorg and tools (should be already installed)
```
sudo pacman -S --needed networkmanager network-manager-applet bluez bluez-utils wpa_supplicant 
sudo pacman -S --needed xorg-server xorg-xinit xorg-apps xdg-utils xdg-user-dirs lxappearance lxsession xdotool 
```

## LeftWM
```
?? curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
paru -S --needed leftwm polybar picom-ibhagwan-git
sudo pacman -S --needed dmenu rofi feh
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```
Edit ~/.xinitrc removing default stuff in the end and adding
```
exec dbus-launch leftwm
```

```
mkdir ~/Git
cd ~/Git
git clone https://github.com/di-effe/amber.git
mkdir ~/.config/leftwm/themes
cp -r ./amber/ ~/.config/leftwm/themes/
ln -s ~/.config/leftwm/themes/amber ~/.config/leftwm/themes/current
cp ~/.config/leftwm/themes/amber/config.toml ~/.config/leftwm/
sudo reboot now
```

## Nerd fonts

```
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
```



## Browser & widevine rdm
sudo pacman -S brave
git clone https://aur.archlinux.org/chromium-widevine.git
makepkg -si














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
sudo pacman -S plasma-meta kde-applications kde-utilities kde-system dolphin-plugins kde-graphics
```

Enable SDDM
```
sudo systemctl enable sddm
```

Reboot





