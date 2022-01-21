#!/bin/bash
active_num=$(yabai -m query --spaces | jq -re '. | length')
space_names=("home" "web" "term" "discord" "text" "spotify" "mail" "todo" "misc")
# active_num=3

for ((i=$active_num+1; i<=8; i++)); do
  $(yabai -m space --create && yabai -m space $i --label ${space_names[$i]})
  # echo ${space_names[$i]};
  # echo $i;
done

