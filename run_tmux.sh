#!/usr/bin/sh

if [ -z "$1" ]; then
  echo "No command provided"
  exit 1
fi

if [ -z "${TMUX}" ]; then
  eval "$@"
else
  tmux split-window -d -p 20 "$@"
fi
