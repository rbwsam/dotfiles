set -e

tmpFile=$(mktemp /tmp/google-chrome-stable_current_amd64.XXXXXX.deb)
curl -o $tmpFile https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y $tmpFile
rm -f $tmpFile