#!/bin/bash
#hyperpipe oneliner
function max_item {
 ls -l | grep '^-' |tail -n+2 | tr -s " " | cut -d" " -f9 | grep -E "^$1_[0-9]+$" | sed "s/${1}_//" | sort -n | tail -n1
}

function max_item2 {
  max=0
  for file in *
  do
    temp=$(echo $file | grep -E "^$1_[0-9]+$" | sed "s/${1}_//")
    [[ -f $file  ]] && [[ $max -lt $temp ]] && max=$temp
  done
  echo $max
}
max_item file_item 
max_item2 file_item
