#!/bin/bash

add_cron() {
    (crontab -l 2>/dev/null; echo "$1") | crontab -
}

bedtime_netoff="30 21 * * * nmcli networking off"
bedtime_shutdown='15 21 * * * /home/joep/.config/cron/bedtime-shutdown-job.sh'

add_cron "$bedtime_shutdown"
