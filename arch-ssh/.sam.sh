#
# Sam's bash config
#

# Export ssh auth socket
if [[ -z "${SSH_CONNECTION}" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

complete -cf sudo

alias ls='lsd'
alias ll='ls -lA'
alias ip='ip -color=auto'
alias compose='docker-compose'
alias up='yay -Syu'
alias bat='bat -p'
alias wip='git commit -a --allow-empty-message -m "" && git push'

export EDITOR="vim"
export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]]\\$ "
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Force virsh and other libvirt clients to connect to the system-wide KVM instance
export LIBVIRT_DEFAULT_URI="qemu:///system"

# direnv
eval "$(direnv hook bash)"
