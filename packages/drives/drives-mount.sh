#!/bin/bash

# Function to display usage information


SOURCE_FILE="~/.dotfiles/new-install-files/drive-mount-entries.fstab"
DEST_FILE="/etc/fstab"

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
  echo "Error: Source file '$SOURCE_FILE' does not exist."
  exit 1
fi

# Check if the destination file exists, and if not, create it
if [ ! -f "$DEST_FILE" ]; then
  echo "Destination file '$DEST_FILE' does not exist. Creating it."
  touch "$DEST_FILE"
fi

# Append the content of the source file to the destination file
cat "$SOURCE_FILE" >> "$DEST_FILE"

# Print success message
echo "Successfully appended the content of '$SOURCE_FILE' to '$DEST_FILE'."
