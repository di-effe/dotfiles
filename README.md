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


```
# Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip ~/Downloads
mkdir ~/.local/share/fonts/nerd-fonts
unzip ~/Downloads/Meslo.zip -d ~/.local/share/fonts/nerd-fonts/
fc-cache -vf


# Fish config & Dracula theme
wget https://raw.githubusercontent.com/dracula/fish/master/conf.d/dracula.fish -P ~/.config/fish/conf.d/ 
ln -nfs ~/dotfiles/garuda/.config/fish/config.fish ~/.config/fish/config.fish
exec fish


# Alacritty config & Dracula theme
ln -nfs ~/dotfiles/garuda/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -nfs ~/dotfiles/garuda/.config/alacritty/dracula.yml ~/.config/alacritty/dracula.yml


# Starship prompt 
ln -nfs ~/dotfiles/garuda/.config/starship.toml ~/.config/starship.toml


# Macchina
git clone https://aur.archlinux.org/macchina-git.git
cd macchina
makepkg -si
cd
rm -rf macchina
mkdir ~/.config/macchina/themes
ln -nfs ~/dotfiles/garuda/.config/macchina/macchina.toml ~/.config/macchina/macchina.toml
ln -nfs ~/dotfiles/garuda/.config/macchina/themes/Dracula.toml ~/.config/macchina/themes/Dracula.toml


# VIM Dracula theme
sudo pacman -S vim
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
ln -nfs ~/dotfiles/garuda/.vimrc ~/.vimrc





# Random color scripts
cd ~/dotfiles/garuda/dt-shell-color-scripts 
makepkg -cf
sudo pacman -U *.pkg.tar.zst
```