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
alias bat='bat -p'
alias wip='git commit -a --allow-empty-message -m "" && git push'

alias backup='brightnessctl s +10%'
alias backdown='brightnessctl s 10%-'
alias backmax='brightnessctl s 100%'

export EDITOR="vim"
export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]]\\$ "
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Force virsh and other libvirt clients to connect to the system-wide KVM instance
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Disable Claude Code auto memory saving
export CLAUDE_CODE_DISABLE_AUTO_MEMORY=1

# direnv
eval "$(direnv hook bash)"
