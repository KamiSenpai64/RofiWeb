#!/bin/bash

# Path to the bookmarks file
BOOKMARKS_FILE="$HOME/scripts/web/bookmarks/bookmarks.txt"

# Read the bookmarks from the file and show in rofi
selected_url=$(cat "$BOOKMARKS_FILE" | rofi -dmenu -i -p "Select Bookmark")

# If a URL is selected, open it in Firefox
if [ ! -z "$selected_url" ]; then
    firefox "$selected_url"
fi

