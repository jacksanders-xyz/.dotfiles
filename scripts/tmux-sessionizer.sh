#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/code ~/personal ~/code/maximo ~/code/Mcdonalds/ code/DirectTV ~/code/nbcu-maximo/WILSON-67.228.221.82 ~/code/SOULMACHINE_2 ~/code/SOULMACHINE_LAUNCHPAD/SMLP-TechZone ~/code/Tmobile/wd_json_servers ~/code/Tmobile/ ~/code/Tmobile/ ~/code/Verizon/ ~/code/MWC-AVATAR/ ~/ ~/VimWiki ~/VimWiki/jacks_brain/ ~/VimWiki/work_content/ -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t $selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
