#!/bin/bash

# Path to the bookmarks file
SCRIPT_DIR=$(dirname "$0")
BOOKMARKS_FILE="$SCRIPT_DIR/bookmarks.txt"
BROWSER=$1

# Read the bookmarks from the file and show in rofi
selected_url=$(cat "$BOOKMARKS_FILE" | rofi -dmenu -i -p "Select Bookmark")

# If a URL is selected, open it in Firefox
if [ ! -z "$selected_url" ]; then
    $BROWSER "$selected_url"
fi
