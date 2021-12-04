# dotfiles

```
clone in git@github.com:di-effe/dotfiles.git ~
cd ~/dotfiles
```

## Garuda/Arch [restore] 

## Utilities
```
pacman -Syu
sudo pacman -S --needed stow fish fisher exa bat wget alacritty neovim starship git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```



## Nerd Fonts
```
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
```

## dir_colors
```
stow dir_colors
```

## .config
- alacritty
- fish
- nvim
- starship
```
stow config
```
