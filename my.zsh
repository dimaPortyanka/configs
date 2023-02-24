# History
export HISTSIZE=10000000
export HISTFILESIZE=$HISTSIZE
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

# fzf settings
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix ".git" .'
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude \".git\" ."
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'

function _fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    vim)          fzf "$@" --preview 'cat {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}

# ohmyzsh
ZSH_THEME="arrow"

plugins=(
  nvm
  git
  docker
  docker-compose
  npm
  fzf
  colorize
  thefuck
  aliases
)

source $ZSH/oh-my-zsh.sh

# aliases
alias node_docker="docker run -v $(pwd):/root -it node /bin/bash"

alias test="npm run test || echo 'cant run tests'"
alias diff="git diff"

function commit {
  if [[ $# -eq 0 ]]; then
    return
  fi

  branch_name=$(git rev-parse --abbrev-ref HEAD | grep -oe '\w\+-\d\+')

  message=''
  if [ -z "$branch_name" ]
  then
    message=$1
  else
    message="$branch_name: $1"
  fi

  git commit -am $message
}

function _openNvim {
  if [[ $# -eq 0 ]] ; then
      nvim .

      return
  fi

  nvim $1
}

alias vim="_openNvim"
#
function send {
  if [[ $# -eq 0 ]]; then
    return
  fi

  git add --all
  commit $1
  git push origin HEAD
}

alias reload="source ~/.zshrc"