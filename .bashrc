# eval "$(starship init bash)"
set -o vi

function gaa() {
  git add "$(git rev-parse --show-toplevel)"
}
alias ga.='git add .'
alias gcm='git commit'
alias gcl='git clone'
alias gl='git log'
alias gsw='git switch'
alias gp='git pull'
alias gP='git push'
alias gpr='git fetch && git rebase'
alias gpm='git fetch && git merge'

alias ll='ls -l'
alias la='ls -la'

export EDITOR=vim
