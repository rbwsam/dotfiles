# dotfiles

I hate reconfiguring apps.

## For a new Arch Linux install

```bash
# Set up
sudo pacman -Syu && sudo pacman -S --needed git
mkdir -p ~/code/rbwsam && cd ~/code/rbwsam
git clone https://github.com/rbwsam/dotfiles.git && cd dotfiles

# Run scripts
./arch-desktop.sh
```

## Create an SSH key

```
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | pbcopy
```

Go to GitHub and paste the new key: [https://github.com/settings/keys](https://github.com/settings/keys)

## Configure git email

```
git config --global --replace-all user.email YOU@YOUREMAIL.COM
```
