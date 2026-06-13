#!/usr/bin/env bash

CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/proton-pass/items.json"

list_items() {
    if [ ! -f "$CACHE_FILE" ]; then
        printf 'No cache — proton-pass-sync not running?\n'
        return
    fi

    jq -r '.[] | "\(.title)\t\(.vault)\t\(.id)"' "$CACHE_FILE" \
        | while IFS=$'\t' read -r title vault id; do
            printf '%s\t[%s]\0info\x1f%s/%s\0icon\x1fpassword\n' \
                "$title" "$vault" "$vault" "$id"
          done
}

copy_field() {
    local field="$1"
    local vault="${ROFI_INFO%%/*}"
    local item_id="${ROFI_INFO#*/}"
    local value
    value=$(pass-cli item view \
        --vault-name "$vault" \
        --item-id "$item_id" \
        --field "$field" 2>/dev/null \
        | tr -d '\n')
    notify-send "pass-debug" "vault='$vault' len=${#value}"
    printf '%s' "$value" | setsid wl-copy
    notify-send "pass-debug" "wl-copy exit=$?"
}

case "${ROFI_RETV:-0}" in
    0) list_items ;;
    1) printenv > /tmp/rofi-env.txt; copy_field password ;;
    10) copy_field username ;;
esac
