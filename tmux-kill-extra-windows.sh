#!/bin/bash

# Kill any "extra" windows (more than 10 or $1)
# bound to C-t C-k in my config (but you might need to change the path)

max_tmux_windows=${1:-10} # default is 10

function get-last-tmux-window() {
    last_tmux_window_col=$(tmux list-windows | tail -n 1 | cut -f 1 -d ' ')
    last_tmux_window=${last_tmux_window_col:0:-1}
    echo $last_tmux_window
}

function kill-tmux-extra-windows() {
    last_tmux_window=$(get-last-tmux-window)
    while [ $last_tmux_window -gt $max_tmux_windows ];
    do
        tmux kill-window -t $last_tmux_window
        echo "killing extra tmux window $last_tmux_window"
        last_tmux_window=$(get-last-tmux-window)
    done
}

if [[ $(get-last-tmux-window) -gt $max_tmux_windows ]]; then
    echo "Yes, too many windows (over $max_tmux_windows)"
    kill-tmux-extra-windows
else
    echo "An okay number of windows (less than $max_tmux_windows). Doing nothing."
fi

exit 0
