# dotfiles

clone in ~/
```
/home/<user>/dotfiles
cd /home/<user>/dotfiles
```

## Garuda [restore] 

## Utilities
```
sudo pacman -S --needed stow fish exa bat wget alacritty neovim starship
```


## Nerd Fonts
```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip ~/Downloads
mkdir ~/.local/share/fonts/nerd-fonts
unzip ~/Downloads/Meslo.zip -d ~/.local/share/fonts/nerd-fonts/
fc-cache -vf
```

## DIR_COLORS
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
