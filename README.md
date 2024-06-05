# Fedora Hyprland Setup -

Bare minimum hyprland setup script for `Fedora 40 KDE Plasma Spin`, user needs to configure everything at his own and install more packages as per his taste and confg.

>Note -
>
>1. Take backup using timeshift before installing, no uninstallation script.
>2. This is minimum setup script with no configs (everything is default)
>3. Work in progress

## Setup -

Clone the repo and launch `setup.sh` script

```bash
git clone --depth=1 https://github.com/aDifferentBook/fedora-hyprland-setup.git
cd fedora-hyprland-setup
chmod +x setup.sh
./setup.sh
```

## Mannual  setup -

1. Install COPR repo -

```bash
# Update system
sudo dnf update -y

# Install COPR repo
sudo dnf copr enable -y solopasha/hyprland
```

2. Install necessary packages -

```bash
# Install hyprland
sudo dnf install -y hyprland network-manager-applet waybar dunst
```

3. Copy default config files -

```bash
# hyprland config
mkdir -p ~/.config/hypr
cd ~/.config/hypr
curl -o hyprland.conf https://raw.githubusercontent.com/hyprwm/Hyprland/main/example/hyprland.conf

# waybar config
mkdir -p ~/.config/waybar
cp /etc/xdg/waybar/config/* ~/.config/waybar/
```

4. Basic settings -

- hyprland config - Open `~/.config/hypr/hyprland.conf` file and do following changes.

```bash
# PolicyKit
exec-once = dunst & /usr/libexec/kf6/polkit-kde-authentication-agent-1 & nm-applet --indicator & waybar 
```

> Note -
>
> For KDE Plasma 5 -
>
> exec-once = dunst & /usr/libexec/kf5/polkit-kde-authentication-agent-1 & nm-applet --indicator & waybar
>

- waybar config - Open `~/.config/waybar/config` and uncomment/remove `//` from the following line

```json
//"layer": "top", // Waybar at top layer

to (like this)

"layer": "top", // Waybar at top layer
```

5. Install ZSH Shell -

```bash
# Install packages
sudo dnf install -y zsh powerline-fonts

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```

6. Reboot system and choose `HYPRLAND` in login manager/SDDM.
