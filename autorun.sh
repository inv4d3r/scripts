#!/usr/bin/env bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run pidgin
#run evolution
run firefox
run qutebrowser
#run boostnote
run spotify
run megasync
