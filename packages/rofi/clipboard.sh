#!/usr/bin/env bash

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/cliphist-rofi"
mkdir -p "$cache_dir"

if [ -z "$1" ]; then
    cliphist list | while IFS=$'\t' read -r id rest; do
        if [[ "$rest" == *"[[ binary data"* ]]; then
            cache_file="$cache_dir/$id"
            if [ ! -f "$cache_file" ]; then
                printf '%s\t%s' "$id" "$rest" | cliphist decode > "$cache_file" 2>/dev/null
            fi
            printf '%s\t%s\0icon\x1f%s\n' "$id" "$rest" "$cache_file"
        else
            printf '%s\t%s\n' "$id" "$rest"
        fi
    done
else
    echo "$@" | cliphist decode | wl-copy
fi
