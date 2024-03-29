#
# ~/.bashrc
#

# Start ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Start X
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

complete -cf sudo

alias ip='ip -color=auto'
alias lock='loginctl lock-session'
alias sus='sudo systemctl suspend'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias compose='docker-compose'
alias bat='bat -p'

alias up="yay -Syu"
alias wip="git c -am WIP && git push"

export VISUAL="subl"
export EDITOR="vim"
export GOPATH="$HOME/go"
export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]]\\$ "
export PATH="$HOME/bin:$GOPATH/bin:$HOME/.local/bin:$PATH"

