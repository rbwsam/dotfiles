# dotfiles

I hate reconfiguring apps.

## For a new Ubuntu install

```bash
# Set up
sudo apt update && sudo apt install -y git
mkdir -p ~/code/rbwsam && cd ~/code/rbwsam
git clone https://github.com/rbwsam/dotfiles.git && cd dotfiles

# Install packages
./scripts/packages.sh

# Configure system
sudo ./scripts/swappiness.sh
./scripts/ubuntu.sh

# Configure bash
echo -e "\nsource ~/code/rbwsam/dotfiles/config.sh" >> ~/.bashrc
```

## Create an SSH key

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | pbcopy
```

Go to GitHub and paste the new key: [https://github.com/settings/keys](https://github.com/settings/keys)

## Configure git

```
cp ~/code/rbwsam/dotfiles/.gitignoreglobal ~/
cp ~/code/rbwsam/dotfiles/.gitconfig ~/
git config --global --replace-all user.email YOU@YOUREMAIL.COM
```

## Notes

### GoLand freezes when opening a markdown file

```bash
sudo apt-get install openjfx
```

Restart Goland.
