#!/usr/bin/env bash

# Fetch applications
apps=$(rofi -show drun -dump)
# Fetch calculator results (you might need to adjust the command)
calc=$(rofi -show calc -dump)

# Display apps, add separator, and then display calc results
{
    echo "$apps"
    echo "--------------------------" # This is your separator
    echo "$calc"
} | rofi -dmenu -i
