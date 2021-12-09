# dotfiles

```
git clone in git@github.com:di-effe/dotfiles.git ~
cd ~/dotfiles
```

## Garuda/Arch [restore] 

## Utilities
```
pacman -Syu
sudo pacman -S --needed stow fish fisher exa bat wget alacritty neovim starship git base-devel feh dmenu polybar blueman rofi xdg-user-dirs-gtk mate-polkit xfce4-settings xfce4-power-manager mate-power-manager mate-settings-daemon network-manager-applet pulseaudio thunar gvfs gvfs-smb pavucontrol lxappearance bleachbit lxtask pamixer betterlockscreen
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## LeftWM

Window Manager
```
yay -S --needed leftwm
mkdir -p ~/.config/leftwm/themes
```

Theme
```
yay -S picom-ibhagwan-git
TBD

```



## Nerd Fonts
```
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
```

## .config
- alacritty
- fish
- nvim
- starship
```
stow config
```

## x11
- .xinitrc
```
stow x11
```

