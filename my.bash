source ~/.fzf.bash
source ~/poetry.bash

alias la="ls -a"
alias vim="nvim"
alias reload="source ~/.bashrc"
alias ds="docker-compose ps"

#enter bash of the docker container
enter_container() {
  if [ ! -n "$1" ]; then
    echo "please specify container name"

    return
  fi

  if [ -z `docker-compose ps -q $1` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q $1)` ]; then
    echo "container with such name is not running"

    return
  fi

  docker-compose exec $1 /bin/bash
}


HISTSIZE=5000
HISTFILESIZE=5000

# my fancy propmpt
PS1='\[\e[0;38;5;152m\]\u\[\e[0;97m\][\[\e[0;38;5;142m\]\W\[\e[0m\]]\[\e[0m\]: \[\e[0m\]'

# run tmux by default
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

export PATH="~/bin:$PATH"

# ignore node_modules
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

#NVM install
export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

