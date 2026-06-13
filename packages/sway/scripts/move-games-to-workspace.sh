#!/usr/bin/env bash

set -euo pipefail

TARGET_WORKSPACE="2"
MATCH_SUBSTRING="steamapps"
# MATCH_SUBSTRING="cemu"

move_window() {
    local pid="$1"

    swaymsg "[pid=$pid]" move to workspace "$TARGET_WORKSPACE" >/dev/null
    echo "Moved PID $pid to workspace $TARGET_WORKSPACE"
}

while true; do
swaymsg -t subscribe '["window"]' | jq -c '
    select(.change == "new" or .change == "focus") |
    { pid: .container.pid, title: .container.name }
' | while read -r event; do

    pid=$(jq -r '.pid' <<<"$event")
    title=$(jq -r '.title' <<<"$event")

    [[ "$pid" == "null" || -z "$pid" ]] && continue

    exe="/proc/$pid/exe"
    [[ ! -e "$exe" ]] && continue

    process_path=$(readlink -f "$exe" 2>/dev/null || true)

    if [[ "$process_path" == *"$MATCH_SUBSTRING"* ]]; then
        echo "Match: $title ($pid)"
        move_window "$pid"
    fi
done
done

