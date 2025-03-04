#!/bin/bash

# Define paths to the other scripts
SCRIPT_DIR=$(dirname "$0")
BOOKMARKS_SCRIPT="$SCRIPT_DIR/bookmarks/bookmarks.sh"

# Browser and Search Engine Selected
BROWSER=$1
SEARCH_ENGINE=$2

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
        # Open the URL in the BROWSER
        $BROWSER "$query" &
    else
        # Construct the search URL and open it in the BROWSER
        case $SEARCH_ENGINE in
        google)
            search_url="https://www.google.com/search?q=$(echo "$query" | sed 's/ /+/g')"
            ;;
        bing)
            search_url="https://www.bing.com/search?q=$(echo "$query" | sed 's/ /+/g')"
            ;;
        duckduckgo)
            search_url="https://duckduckgo.com/?q=$(echo "$query" | sed 's/ /+/g')"
            ;;
        yahoo)
            search_url="https://search.yahoo.com/search?p=$(echo "$query" | sed 's/ /+/g')"
            ;;
        startpage)
            search_url="https://www.startpage.com/sp/search?q=$(echo "$query" | sed 's/ /+/g')"
            ;;
        *)
            search_url="https://www.google.com/search?q=$(echo "$query" | sed 's/ /+/g')"
            ;;
        esac

        $BROWSER "$search_url" &
    fi

# Action: Open Bookmarks
elif [ "$action" == "Open Bookmarks" ]; then
    # Run the bookmarks script
    "$BOOKMARKS_SCRIPT" "$BROWSER"
fi

# test
