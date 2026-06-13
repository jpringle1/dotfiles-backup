#!/usr/bin/env bash

case "$1" in
    "󰐥 Shutdown")  systemctl poweroff ;;
    "󰜉 Reboot")    systemctl reboot ;;
    "󰒲 Sleep")     systemctl suspend ;;
    "󰤄 Hibernate") systemctl hibernate ;;
    "󰌾 Lock")      swaylock ;;
    *)
        echo "󰐥 Shutdown"
        echo "󰜉 Reboot"
        echo "󰒲 Sleep"
        echo "󰤄 Hibernate"
        echo "󰌾 Lock"
        ;;
esac
