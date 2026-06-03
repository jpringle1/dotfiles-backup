#!/bin/bash

script_dir=$1

add_cron_if_missing() {
    if ! crontab -l 2>/dev/null | grep -qF "$1"; then
        (crontab -l 2>/dev/null; echo "$1") | crontab -
    fi
}


add_sudo_cron_if_missing() {
    if ! sudo crontab -l 2>/dev/null | grep -qF "$1"; then
        (sudo crontab -l 2>/dev/null; echo "$1") | sudo crontab -
    fi
}

# bedtime_netoff="30 21 * * * nmcli networking off"
bedtime_shutdown_timer="00 21 * * * $script_dir/cron.sh"
bedtime_shutdown="15 21 * * * /usr/sbin/shutdown now"

add_cron_if_missing "$bedtime_shutdown_timer"
add_sudo_cron_if_missing "$bedtime_shutdown"
