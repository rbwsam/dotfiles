alias kc="kubectl"
alias kc.all="kubectl get all --all-namespaces"
alias kc.all.watch="watch -n 3 kubectl get all --all-namespaces"
alias kc.dashboard="watch -n 3 kubectl get pods --all-namespaces"

alias up="sudo apt update && sudo apt upgrade"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export VISUAL="subl"
export EDITOR="vim"

export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]]\\$ "
