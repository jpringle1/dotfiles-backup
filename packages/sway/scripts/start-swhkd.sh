#!/bin/bash

# Combine all config files in ~/.config/swhkd directory into one temporary file
cat "$HOME/.config/swhkd/"* > /tmp/swhkd_combined.conf

# Run swhkd using the combined config file with pkexec for root privileges
swhks &
#pkexec swhkd -c "$HOME/.config/swhkd/swhkdrc"
pkexec swhkd -c /tmp/swhkd_combined.conf
