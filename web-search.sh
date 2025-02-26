#!/bin/bash

# Define paths to the other scripts
BOOKMARKS_SCRIPT="$HOME/scripts/web/bookmarks/bookmarks.sh"

# Rofi prompt to select action (search the web or open bookmarks)
action=$(echo -e "Search Web\nOpen Bookmarks" | rofi -dmenu -i -p "Choose Action")

# Action: Search Web
if [ "$action" == "Search Web" ]; then
    query=$(rofi -dmenu -p "Search the web:")

    # If the query is empty, exit
    if [ -z "$query" ]; then
        exit 1
    fi

    # Check if the query is a URL (contains '.' or starts with http)
    if [[ "$query" =~ ^https?://.* || "$query" =~ \. ]]; then
        # Open the URL in Firefox
        firefox "$query" &
    else
        # Construct the Google search URL and open it in Firefox
        search_url="https://www.google.com/search?q=$(echo "$query" | sed 's/ /+/g')"
        firefox "$search_url" &
    fi

# Action: Open Bookmarks
elif [ "$action" == "Open Bookmarks" ]; then
    # Run the bookmarks script
    "$BOOKMARKS_SCRIPT"
fi

