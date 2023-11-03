#!/usr/bin/env bash

# Credit
# https://github.com/samoshkin/tmux-config/blob/master/tmux/yank.sh

set -eu

is_app_installed() {
  which "$1" &>/dev/null
}

# get data either form stdin or from file
buf=$(cat "$@")

# Resolve copy backend: pbcopy (OSX), reattach-to-user-namespace (OSX), xclip/xsel (Linux)
if is_app_installed pbcopy; then
  copy_backend="pbcopy"
elif is_app_installed reattach-to-user-namespace; then
  copy_backend="reattach-to-user-namespace pbcopy"
elif [ -n "${DISPLAY-}" ] && is_app_installed xsel; then
  copy_backend="xsel -i --clipboard"
elif [ -n "${DISPLAY-}" ] && is_app_installed xclip; then
  copy_backend="xclip -i -f -selection primary | xclip -i -selection clipboard"
else
  exit 1
fi

printf "%s" "$buf" | eval "$copy_backend"
