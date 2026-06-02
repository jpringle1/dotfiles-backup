#!/bin/bash

script_dir=$1

add_cron_if_missing() {
    if ! crontab -l 2>/dev/null | grep -qF "$1"; then
        (crontab -l 2>/dev/null; echo "$1") | crontab -
    fi
}

# bedtime_netoff="30 21 * * * nmcli networking off"
bedtime_shutdown="15 21 * * * $script_dir/cron.sh"

add_cron_if_missing "$bedtime_shutdown"
