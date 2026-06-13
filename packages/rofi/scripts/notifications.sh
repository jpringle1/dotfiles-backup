#!/usr/bin/env bash

LOG_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/notification-history/history.jsonl"

if [ -n "$1" ]; then
    printf '%s' "$*" | wl-copy
    exit 0
fi

if [ ! -f "$LOG_FILE" ]; then
    printf 'No notification history yet\n'
    exit 0
fi

tac "$LOG_FILE" | while IFS= read -r line; do
    time=$(printf '%s' "$line" | jq -r '.time' | cut -c12-16)
    app=$(printf '%s' "$line" | jq -r '.app')
    summary=$(printf '%s' "$line" | jq -r '.summary')
    body=$(printf '%s' "$line" | jq -r '.body')

    display="$time"
    [ -n "$app" ] && display="$display  [$app]"
    [ -n "$summary" ] && display="$display  $summary"
    [ -n "$body" ] && display="$display — $body"

    printf '%s\n' "$display"
done
