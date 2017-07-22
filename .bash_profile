### LINUX ONLY ###
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
### END ###

# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\u@\h \W]\\$ \[$(tput sgr0)\]"

alias ls='ls -G'
alias progress='git commit -a -m "Progress" && git push'
