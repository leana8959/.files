export PATH=$PATH:/opt/homebrew/bin

eval "$(starship init bash)"
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

alias v='vim'
export EDITOR=vim

bind -x '"\C-l": clear;'

# PS1='\[\e[38;5;203m\]\h\[\e[0m\]:\[\e[48;5;63m\]\w\n\[\e[0m\]$ '
