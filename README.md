# dotfiles

clone in ~/
```
/home/<user>/dotfiles
```

## WSL2 Ubuntu [restore]
```
ln -nfs ~/dotfiles/wslUbuntu/.config/starship.toml ~/.config/starship.toml 
ln -nfs ~/dotfiles/wslUbuntu/.config/colorls/dark_colors.yaml ~/.config/colorls/dark_colors.yaml
ln -nfs ~/dotfiles/wslUbuntu/.config/fish/config.fish ~/.config/fish/config.fish
ln -nfs ~/dotfiles/wslUbuntu/.config/macchina/macchina.toml ~/.config/macchina/macchina.toml
ln -nfs ~/dotfiles/wslUbuntu/.config/macchina/themes/Dracula.toml ~/.config/macchina/themes/Dracula.toml
```

## Garuda [restore] 



## Nerd Fonts
```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip ~/Downloads
mkdir ~/.local/share/fonts/nerd-fonts
unzip ~/Downloads/Meslo.zip -d ~/.local/share/fonts/nerd-fonts/
fc-cache -vf
```

## Fish config & Dracula theme
```
wget https://raw.githubusercontent.com/dracula/fish/master/conf.d/dracula.fish -P ~/.config/fish/conf.d/ 
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/spark.fish
sudo pacman -S lolcat
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
ln -nfs ~/dotfiles/garuda/.config/fish/config.fish ~/.config/fish/config.fish
exec fish
```

## Alacritty config & Dracula theme
```
mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.bak
ln -nfs ~/dotfiles/garuda/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -nfs ~/dotfiles/garuda/.config/alacritty/dracula.yml ~/.config/alacritty/dracula.yml
```

## Starship config & Dracula theme
```
mv ~/.config/starship.toml ~/.config/starship.toml.bak
ln -nfs ~/dotfiles/garuda/.config/starship.toml ~/.config/starship.toml
```

## Macchina
```
git clone https://aur.archlinux.org/macchina-git.git
cd macchina
makepkg -si
cd
rm -rf macchina
mkdir ~/.config/macchina/themes
ln -nfs ~/dotfiles/garuda/.config/macchina/macchina.toml ~/.config/macchina/macchina.toml
ln -nfs ~/dotfiles/garuda/.config/macchina/themes/Dracula.toml ~/.config/macchina/themes/Dracula.toml
```

## VIM Dracula theme
```
sudo pacman -S vim
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
ln -nfs ~/dotfiles/garuda/.vimrc ~/.vimrc
```


## Arch [UEFI install] 

timedatectl set-ntp true
timedatectl status
fdisk -l
wipefs -a /dev/sda
cfdisk /dev/sda

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda1 /mnt


pacman -Syy
pacman -S reflector 
reflector -c "IT" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone Europe/Rome
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc
pacman -S nano
nano /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LC_ADDRESS=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_NAME=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_NUMERIC=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_PAPER=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE=it_IT.UTF-8" >> /etc/locale.conf
echo "LC_TIME=it_IT.UTF-8" >> /etc/locale.conf

echo archvirt > /etc/hostname
nano /etc/hosts
- 127.0.0.1	localhost
- ::1		localhost
- 127.0.1.1	[your_hostname].localdomain [your_hostname]
pacman -S networkmanager 
systemctl enable Network Manager

passwd 
useradd -m david
passwd david
usermod -aG wheel,audio,video,storage,optical david
pacman -S sudo
EDITOR=nano visudo

NON UEFI
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/brug.cfg

UEFI
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg


exit
umount /mnt
reboot