set -e

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update && sudo apt install -y sublime-text
mkdir -p ~/.config/sublime-text-3/Packages/User
cat <<EOT > ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
{
    "hot_exit": false
}
EOT
