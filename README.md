# dotfiles

I hate repeating myself, so my config lives here.

## Platforms

### Arch i3 (Desktop/Laptop)

```bash
sudo pacman -Syu && sudo pacman -S --needed git
mkdir -p ~/code/rbwsam && cd ~/code/rbwsam
git clone https://github.com/rbwsam/dotfiles.git && cd dotfiles

./arch-i3/setup.sh
```

### Debian SSH (Server)

```bash
sudo apt update && sudo apt install git
mkdir -p ~/code/rbwsam && cd ~/code/rbwsam
git clone https://github.com/rbwsam/dotfiles.git && cd dotfiles

./deb-ssh/setup.sh
```

## Guides

### Create an SSH key

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

```bash
# If you have the pbcopy alias

cat ~/.ssh/id_ed25519.pub | pbcopy
```

Add public key to GitHub: [https://github.com/settings/keys](https://github.com/settings/keys)
