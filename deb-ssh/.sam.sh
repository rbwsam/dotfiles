#
# Sam's bash config
#

alias ls='lsd'
alias ll='ls -lA'
alias ip='ip -color=auto'
alias compose='docker-compose'
alias up='sudo apt update && sudo apt upgrade'
alias bat='bat -p'
alias wip='git commit -a --allow-empty-message -m "" && git push'

export EDITOR="vim"
export PS1="[\[\e[36m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\] \[\e[33m\]\W\[\e[m\]]\\$ "
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
