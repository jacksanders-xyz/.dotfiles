#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    # --print-query outputs the typed query on the first line
    # ctrl-o creates a new directory with the typed name
    result=$(find ~/code -mindepth 2 -maxdepth 4 -type d | fzf --print-query --bind 'ctrl-o:print-query+abort')

    query=$(echo "$result" | sed -n '1p')
    selected=$(echo "$result" | sed -n '2p')

    # If ctrl-o was pressed (selected is empty but query exists), create new dir
    if [[ -z $selected && -n $query ]]; then
        selected="$HOME/code/$query"
        mkdir -p "$selected"
        echo "Created: $selected"
    fi
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
