# dotfiles

I hate reconfiguring apps.

# For a new Ubuntu install

```bash
# Set up
sudo apt update && sudo apt install -y git
mkir -p ~/code/rbwsam && cd ~/code/rbwsam
git clone https://github.com/rbwsam/dotfiles.git

# Do the work
./scripts/packages.sh
sudo ./scripts/swappiness.sh
./scripts/ubuntu.sh
```


## Notes

### GoLand freezes when opening a markdown file

```bash
sudo apt-get install openjfx
```

Restart Goland.
