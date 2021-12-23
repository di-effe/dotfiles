# dotfiles
* ArcolinuxB LeftWM* 

```
git clone in git@github.com:di-effe/dotfiles.git ~
cd ~/dotfiles
```

## Garuda/Arch [restore] 

## Utilities
```
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))

mkdir ~/Git
cd ~/Git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

paru -S --needed font-manager-git greetd-git greetd-tuigreet lemonbar-xft-git nerd-fonts-complete starship-git 
```

## .config
- alacritty
- fish
- nvim
- starship

```
mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.back
mv ~/.config/fish ~/.config/fish.bak
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.config/starship.toml ~/.config/nvstarship.toml.bak
mv ~/.config/zsh ~/.config/zsh.bak
mv ~/.zshenv ~/.zshenv.bak
stow config
```

