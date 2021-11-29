# dotfiles

clone in ~/
```
/home/<user>/dotfiles
```

## Garuda [restore] 



## Nerd Fonts
```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip ~/Downloads
mkdir ~/.local/share/fonts/nerd-fonts
unzip ~/Downloads/Meslo.zip -d ~/.local/share/fonts/nerd-fonts/
fc-cache -vf
```

## DIR_COLORS
ln -sr ~/dotfiles/garuda/.dir_colors ~/.dir_colors


## Fish config (Nord theme)
```
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
ln -nfs ~/dotfiles/garuda/.config/fish/config.fish ~/.config/fish/config.fish
exec fish
```

## Alacritty config (Nord theme)
```
mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.bak
ln -nfs ~/dotfiles/garuda/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -nfs ~/dotfiles/garuda/.config/alacritty/nord.yml ~/.config/alacritty/nord.yml
```


## NEOVIM Nord theme
```
sudo pacman -S neovim
mkdir -p ~/.config/nvim
ln -nfs ~/dotfiles/garuda/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -nfs ~/dotfiles/garuda/.config/nvim/colors/ ~/.config/nvim/colors
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