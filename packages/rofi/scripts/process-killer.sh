#!/usr/bin/env bash

selected=$(ps -eo pid=,comm= --sort=-pid 2>/dev/null \
    | while read -r pid name; do
        printf '%d\t%s\0icon\x1f%s\n' "$pid" "$name" "$name"
      done \
    | rofi \
        -dmenu \
        -show-icons \
        -kb-custom-1 "ctrl+shift+k" \
        -mesg "enter: copy pid  |  ctrl+shift+k: kill" \
        -p "")

code=$?
[ -z "$selected" ] && exit 0

pid=$(printf '%s' "$selected" | awk -F'\t' '{print $1}')
[ -z "$pid" ] && exit 0

if [ "$code" -eq 0 ]; then
    printf '%s' "$pid" | wl-copy
elif [ "$code" -eq 10 ]; then
    if kill "$pid" 2>/dev/null; then
        notify-send "Killed" "PID $pid"
    else
        notify-send -u critical "Kill failed" "Cannot kill PID $pid"
    fi
fi
