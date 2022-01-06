# -------------
# Try to get close to normal colors in tmux
# -------------
set -g default-terminal "screen-256color"

# -------------
# start with window 1 (instead of 0)
# -------------
set -g base-index 1

# -------------
# start with pane 1
# -------------
set -g pane-base-index 1

# -------------
# status line
# -------------
set -g status-utf8 on
set -g status-justify-style left
set -g status-bg-style black
set -g status-fg-style white
set -g status-interval-style 4

# -------------
# window status
# -------------
setw -g window-status-format-style "#[fg=black]#[bg=colour7] #I #[fg=black]#[bg=colour15] #W "
setw -g window-status-current-format-style "#[fg=colour8]#[bg=white] #I #[bg=colour60]#[fg=white] #W "
setw -g window-status-current-bg-style black
setw -g window-status-current-fg-style yellow
setw -g window-status-current-attr-style bold
setw -g window-status-bg-style black
setw -g window-status-fg-style blue
setw -g window-status-attr-style default
setw -g window-status-content-bg-style black
setw -g window-status-content-fg-style blue
setw -g window-status-content-attr-style bold

# -------------
# Info on left (no session display)
# -------------
set -g status-left ''
set -g status-right-length 150
set -g status-right '#[fg=colour60] %m/%d - %l:%M '
set -g status-utf8 on

# -------------
# Mouse mode on
# -------------
set -g mouse-utf8 on
set -g mouse on
