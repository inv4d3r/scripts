#!/bin/bash

#monitors=($(xrandr --listmonitors | awk '{ print  $4 }'))
monitors=($(xrandr | grep " connected" | awk '{ print $1 }'))
#echo "$monitors"

mon_num=${#monitors[@]}
#echo $mon_num

if [ $mon_num -eq 1 ]
then
  echo "Only 1 monitor detected. No changes needed"
  exit 0
fi

if [ $mon_num -gt 1 ]
then
  echo "External monitor(s) detected ("$mon_num"): "
  #for mon in ${monitors[@]}; do
    #echo "$mon"
  #done

  #for i in {0..${#monitors[@]}}
  let end=$mon_num-1
  for i in $(seq 0 $end)
  do
    echo $i : ${monitors[$i]}
  done

  # 2 monitors - set external as primary
  #if [ $mon_num -eq 2 ]
  #then
    #command="xrandr --output "${monitors[1]}" --off"
    #echo "$command"
    #eval "$command"
    #command="xrandr --output "${monitors[1]}" --auto --primary"
    #echo "$command"
    #eval "$command"
    #command="xrandr --output "${monitors[0]}" --auto --right-of "${monitors[1]}""
    #echo "$command"
    #eval "$command"
  #fi

  # 2 or more monitors - let's duplicate first external
  if [ $mon_num -gt 1 ]
  then
    command="xrandr --output "${monitors[1]}" --off"
    echo "$command"
    eval "$command"
    command="xrandr --output "${monitors[1]}" --auto --same-as "${monitors[0]}""
    echo "$command"
    eval "$command"
    for i in $(seq 2 $end)
    do
      command="xrandr --output "${monitors[$i]}" --off"
      echo "$command"
      eval "$command"

      let prev=$i-1
      command="xrandr --output "${monitors[$i]}" --auto --right-of "${monitors[$prev]}""
      echo "$command"
      eval "$command"
    done
  fi
fi

setxkbmap -option caps:escape
