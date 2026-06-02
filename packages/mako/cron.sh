#!/bin/bash

notify-send -c "go-to-sleep" "Bed time in 15 minutes" "Network cuts at 9:30"

sleep 600  # 10 minutes

notify-send -c "go-to-sleep" "Bed time in 5 minutes" "Wrap up what you're doing"

sleep 290  # 4 minutes 50 seconds

# countdown
for i in $(seq 10 -1 1); do
    notify-send -c "go-to-sleep" -t 999 "Shutting down in" "$i seconds..."
    sleep 1
done

notify-send -c "go-to-sleep" -t 0 "Shutting down"

shutdown now
