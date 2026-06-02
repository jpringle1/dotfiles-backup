#!/bin/bash
# Usage message function
usage() {
    echo "Usage: $0 [-f] [-a] [-s] [-w]"
    echo "    -f  : Full screen"
    echo "    -a  : Capture selected area"
    echo "    -s  : Capture selected window"
    echo "    -w  : Capture focused window"
    exit 1
}

function get_selected_window() {
    swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp
}

function get_focused_window() {
    swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"'
}

function sc_full() {
    grim - | wl-copy
}

function sc_selected_window() {
    get_selected_window | grim -g- - | wl-copy
}

function sc_selected_area() {
    slurp | grim -g- - | wl-copy
}

function sc_focused_window() {
    get_focused_window | grim -g- - | wl-copy
}

# Parse flags using getopts
while getopts "fasw" opt; do
  case ${opt} in
    f )
      flag_full=1
      ;;
    a )
      flag_area=1
      ;;
    s )
      flag_selected_window=1
      ;;
    w )
      flag_focused_window=1
      ;;
    \? )
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Execute the appropriate functions based on flags
if [[ $flag_full -eq 1 ]]; then
    sc_full
fi

if [[ $flag_area -eq 1 ]]; then
    sc_selected_area
fi

if [[ $flag_selected_window -eq 1 ]]; then
    sc_selected_window
fi

if [[ $flag_focused_window -eq 1 ]]; then
    sc_focused_window
fi
