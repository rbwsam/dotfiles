#
# Sam's bash config
#

# Start X
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

# Export ssh auth socket
if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

complete -cf sudo

alias ls='lsd'
alias ll='ls -lA'
alias ip='ip -color=auto'
alias lock='loginctl lock-session'
alias sus='sudo systemctl suspend'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias compose='docker-compose'
alias up='yay -Syu'
alias batp='bat -p'
alias wip='git commit -a --allow-empty-message -m "" && git push'
alias pr='pipenv run'
alias status='sudo systemctl status'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'

alias bluestatus='systemctl status bluetooth'
alias blueon='sudo systemctl start bluetooth'
alias blueoff='sudo systemctl stop bluetooth'

alias backup='brightnessctl s +10%'
alias backdown='brightnessctl s 10%-'
alias backmax='brightnessctl s 100%'

export EDITOR="vim"
export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]]\\$ "
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

