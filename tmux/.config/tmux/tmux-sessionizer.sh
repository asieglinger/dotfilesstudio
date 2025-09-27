#!/usr/bin/env bash

# Tmux Sessionizer - Fuzzy find and create tmux sessions
# Inspired by ThePrimeagen's tmux-sessionizer

# Define directories to search for projects
# You can customize these paths
search_dirs=(
    ~/projects
    ~/work
    ~/personal
    ~/dotfiles
    ~/Documents
    ~/Desktop
    ~/.config
)

# Get all directories (max depth 2) from search directories
get_directories() {
    for dir in "${search_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            find "$dir" -mindepth 0 -maxdepth 2 -type d 2>/dev/null
        fi
    done
}

# If an argument is provided, use it as the selected directory
if [[ $# -eq 1 ]]; then
    selected=$1
else
    # Use fzf to select a directory
    selected=$(get_directories | fzf --height=40% --reverse --border --prompt="Select project: ")
fi

# Exit if no selection was made
if [[ -z $selected ]]; then
    exit 0
fi

# Get the name of the session from the directory path
selected_name=$(basename "$selected" | tr . _)

# Check if we're inside tmux
tmux_running=$(pgrep tmux)

# If we're not in tmux and tmux is not running
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

# Create session if it doesn't exist
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

# Switch to session
if [[ -z $TMUX ]]; then
    # If we're outside tmux, attach to the session
    tmux attach-session -t $selected_name
else
    # If we're inside tmux, switch to the session
    tmux switch-client -t $selected_name
fi