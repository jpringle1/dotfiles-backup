#!/usr/bin/env bash

FILE="prefs.js"
KEYS_ONLY=false
RAW_LINES=false
USE_IGNORE=false
IGNORE_FILE=".pref-ignore"

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        -k|--keys)
            KEYS_ONLY=true
            shift
            ;;
        -r|--raw)
            RAW_LINES=true
            shift
            ;;
        -i|--ignore)
            USE_IGNORE=true
            shift
            ;;
        *)
            FILE="$1"
            shift
            ;;
    esac
done

# Get added prefs from unstaged git diff
DIFF_LINES=$(
    git diff -- "$FILE" |
    grep '^+user_pref(' |
    grep -v '^+++'
)

# Output formatting
if $RAW_LINES; then
    OUTPUT=$(echo "$DIFF_LINES" | sed 's/^+//')
elif $KEYS_ONLY; then
    OUTPUT=$(
        echo "$DIFF_LINES" |
        sed -E 's/^\+user_pref\("([^"]+)",[[:space:]]*(.*)\);$/\1/'
    )
else
    OUTPUT=$(
        echo "$DIFF_LINES" |
        sed -E 's/^\+user_pref\("([^"]+)",[[:space:]]*(.*)\);$/\1 = \2/'
    )
fi

# Apply ignore filter
if $USE_IGNORE && [[ -f "$IGNORE_FILE" ]]; then
    OUTPUT=$(
        echo "$OUTPUT" |
        grep -v -F -f "$IGNORE_FILE"
    )
fi

echo "$OUTPUT"
