#!/bin/bash
set -e

if [[ $EUID -ne 0 ]]; then
    echo "You Stupid Idiot, Thank past me for fixing your idiocy"
    sleep 5
    exec sudo "$0" "$@"
fi

# Installing Apps
pacman -Syu --noconfirm
pacman -S --needed --noconfirm hyprland swaybg firefox hyprpicker zed rust base-devel git qt5ct qt6ct qt5-wayland qt6-wayland kvantum mako yazi ffmpeg p7zip jq poppler fd ripgrep fzf zoxide imagemagick wl-clipboard libreoffice-fresh xdg-desktop-portal-hyprland polkit-kde-agent ollama dolphin ffmpegthumbs kdegraphics-thumbnailers kdenetwork-filesharing kio-admin

cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

git clone https://github.com/google/fonts.git
cp fonts/ofl/vt323/VT323-Regular.ttf ~/.local/share/fonts/
fc-cache

paru -S --noconfirm spotify hyprshot albafetch-bin visual-studio-code-bin android-studio

# Importing Themes
cd /tmp
git clone https://github.com/catppuccin/Kvantum.git
cp Kvantum/themes/catppuccin-macchiato-blue -r ~/.config/Kvantum/

# Creating Wayland Flags

FLAGS=$'--enable-features=UseOzonePlatform\n--ozone-platform=wayland'

echo "$FLAGS" >| ~/.config/code-flags.conf
echo "$FLAGS" >| ~/.config/spotify-flags.conf
echo "$FLAGS" >| ~/.config/electron-flags.conf

# Downloading dotfiles
cd /tmp
git clone https://github.com/AConcrnedCitizen/dotfiles
cp dotfiles/hypr -r ~/.config/
cp dotfiles/alacritty -r ~/.config/
cp dotfiles/mako -r ~/.config/
cp dotfiles/rofi -r ~/.config/
cp dotfiles/neofetch -r ~/.config/
cp dotfiles/waybar -r ~/.config/


cp *.sh ~/

echo "Time to reboot"
