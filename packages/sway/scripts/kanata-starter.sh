#!/bin/bash

dict_lookup() {
    local key="$1"
    
    if [[ -n "${game_layer_dict[$key]}" ]]; then
        echo "${game_layer_dict[$key]}"
    else
        echo "default"
    fi
}

changeLayer() {
	local chosen_layer="$1"

	echo "chosen layer = " $chosen_layer

	# echo -e "{\"ChangeLayer\": { \"new\": \"$chosen_layer\"}}" | nc 127.0.0.1 4039 &
	echo "{\"ChangeLayer\": { \"new\": \"$chosen_layer\"}}" >&"${KANATA_CONN[1]}"
}

subscriber() {
    echo "l23: kanata - subscription"

    currentLayer="no-game-default"

    while true; do
        while read -r event; do
		# get all window and mode events
	    echo "$event" | jq -e > /dev/null || continue

	    focused=$(swaymsg -t get_tree | jq '.. | select(.focused? == true)')

            window_name=$(echo "$focused" | jq -r '.window_properties.class // ""')
            pid=$(echo "$focused" | jq -r '.pid // ""')
	    commandPath=$(readlink -f "/proc/$pid/exe")

	    echo "window name = $window_name"
	    echo "pid = $pid"
	    echo "commandPath = $commandPath"
	    # echo "focused = $focused"

            # if [[ "$commandPath" == *"steamapps"* ]]; then
	    if [[ "$commandPath" == *"steamapps"* || "$commandPath" == *"Steam/compatibilitytools.d"* ]]; then
		echo "matched"
                chosen_layer=$(dict_lookup "$window_name")
                changeLayer "$chosen_layer"
		currentLayer="$chosen_layer"
	    else
                changeLayer "no-game-default"
		currentLayer="$chosen_layer"
            fi
        done < <(swaymsg -t subscribe '["window", "mode"]')

        echo "subscriber died, restarting immediately"
    done
}

main() {
    local user="$1"

    declare -A game_layer_dict

    while IFS=':' read -r key value; do
        game_layer_dict["$key"]="$value"
    done < ~/.dotfiles/sway/scripts/game_layer_dict.conf

    echo "kanata starter started with user:" $user

    if [[ "$user" == "gaming" ]]; then
        # Check if kanata is already running
        # if ! pgrep -x kanata > /dev/null; then
	kanata_log_file=/tmp/kanata.log
        kanata -c ~/.dotfiles/kanata/gaming.kbd -p 4039 > $kanata_log_file 2>&1 &

        # Wait for "Starting kanata proper" log message to appear
        while ! tail -f $kanata_log_file | grep -m 1 "Starting kanata proper"; do
            sleep 0.5
        done

        # Kanata is now fully initialized, so start the connection
        coproc KANATA_CONN { nc 127.0.0.1 4039; }

        subscriber
        # fi
    fi
}

main $1
