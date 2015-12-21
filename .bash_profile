# For OS X

# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\u@\h \W]\\$ \[$(tput sgr0)\]"

alias ls='ls -G'
alias vup='vagrant up'
alias vssh='vagrant ssh'
alias vsuspend='vagrant suspend'
alias vprov='vagrant provision'
alias progress='git commit -a -m "Progress" && git push'
