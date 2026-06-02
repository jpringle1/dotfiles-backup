#!/bin/bash

notify-send -c "go-to-sleep" "Bed time in 15 minutes"

sleep 600  # 10 minutes

notify-send -c "go-to-sleep" "Bed time in 5 minutes"

sleep 240  # 4 minutes

notify-send -c "go-to-sleep" "Bed time in 1 minute"

sleep 50  # 50 seconds

# countdown
for i in $(seq 10 -1 1); do
    notify-send -c "go-to-sleep" -t 999 "Shutting down in" "$i seconds..."
    sleep 1
done

notify-send -c "go-to-sleep" -t 0 "Shutting down"

shutdown now
