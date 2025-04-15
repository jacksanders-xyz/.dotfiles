#!/usr/bin/env bash

# Wait a fraction of a second so tmux finishes creating the new window
sleep 0.1

# Make sure we select the newly created window
tmux select-window -t=

# Now do your splits. Adjust indexes if using base-index 1.
tmux split-window -h -p 75
tmux select-pane -R     # or tmux select-pane -t 2 if you're using base-index=1
tmux split-window -h -p 66
tmux select-pane -L     # or tmux select-pane -t 2
