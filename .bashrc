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

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias compose='docker-compose'

alias up="yay -Syu"
alias wip="git c -am WIP && git push"
alias pp="pipenv run python"

export VISUAL="subl"
export EDITOR="vim"
export GOPATH="$HOME/go"
export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \[\e[36m\]\W\[\e[m\]]\\$ "
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
