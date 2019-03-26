alias kubectl.all="kubectl get all --all-namespaces"
alias kubectl.all.watch="watch kubectl get all --all-namespaces"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\][\u@\h \W]\\$ \[$(tput sgr0)\]"

export GOPATH=$HOME/go
export GOROOT=$HOME/.go1.11.6
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Necessary on Arch Linux for tab ccomplete of commands starting with sudo
complete -cf sudo

