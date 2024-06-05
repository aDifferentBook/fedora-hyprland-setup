#!/bin/bash
clear
echo

# Colours
# 1. bold - Bold         # 2. dim - Dim or Dark
# 3. sitm - Italics      # 4. smul - Underlined
# 5. blink - Blinking    # 6. rev - Inverted or Reversed
# 7. invis - Invisible   # 8. smxx - Strike-through

# red=$(tput bold setaf 1)
green=$(tput bold setaf 2)
yellow=$(tput bold setaf 3)
# blue=$(tput bold setaf 14)
# magenta=$(tput bold setaf 5)
# cyan=$(tput bold setaf 6)
# white=$(tput bold setaf 7)
# white_dim=$(tput dim setaf 7)
normal=$(tput sgr0)

echo -e "${green}Updating and installing COPR repo -${normal}"
# Update system
sudo dnf update -y

# Install COPR repo
sudo dnf copr enable -y solopasha/hyprland
echo

echo -e "${green}Installing required packages -${normal}"
# Install hyprland
sudo dnf install -y hyprland network-manager-applet waybar dunst
echo

echo -e "${green}Downloading configration files -${normal}"
echo -e "${green}Downloading hyprland configration file -${normal}"
# hyprland config
if [[ -d ~/.config/hypr ]]; then
    echo -e "${yellow}Found hyprland config -${normal}"
    mv ~/.config/hypr ~/.config/hypr-old
    mkdir -p ~/.config/hypr
    curl -o ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/hyprwm/Hyprland/main/example/hyprland.conf
else
    mkdir -p ~/.config/hypr
    curl -o ~/.config/hypr/hyprland.conf https://raw.githubusercontent.com/hyprwm/Hyprland/main/example/hyprland.conf
fi

# waybar config
echo -e "${green}Downloading waybar configration file -${normal}"
if [[ -d ~/.config/waybar ]]; then
    echo -e "${yellow}Found waybar config -${normal}"
    mv ~/.config/waybar ~/.config/waybar-old
    mkdir -p ~/.config/waybar
    cp /etc/xdg/waybar/config/* ~/.config/waybar/
else
    mkdir -p ~/.config/waybar
    cp /etc/xdg/waybar/config/* ~/.config/waybar/
fi

echo -e "${green}Installing ZSH Shell -${normal}"
bash ./scripts/zsh-setup.sh

echo -e "${yellow}Do you want to reboot your system now? [y/n] (Recommended)${normal}"
read -r CHOICE
if [[ $CHOICE == Y ]] || [[ $CHOICE == y ]]; then
    echo -e "${yellow}Rebooting system...${normal}"
    sleep 2
    systemctl reboot
fi
