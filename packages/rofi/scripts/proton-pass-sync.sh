#!/usr/bin/env bash

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/proton-pass"
CACHE_FILE="$CACHE_DIR/items.json"
INTERVAL="${1:-1800}"

mkdir -p "$CACHE_DIR"

sync_once() {
    local tmp
    tmp=$(mktemp "$CACHE_DIR/items.tmp.XXXXXX")

    pass-cli vault list --output json 2>/dev/null \
        | jq -r '.vaults[].name' \
        | while read -r vault; do
            pass-cli item list "$vault" \
                --filter-type login \
                --output json 2>/dev/null \
            | jq --arg v "$vault" '[.items[]? | {title: .title, vault: $v, id: .id}]'
          done \
        | jq -s 'add // []' > "$tmp"

    # Only overwrite cache if we got real data (guards against auth failures)
    if jq -e 'length > 0' "$tmp" > /dev/null 2>&1; then
        mv "$tmp" "$CACHE_FILE"
    else
        rm -f "$tmp"
    fi
}

while true; do
    sync_once
    sleep "$INTERVAL"
done
