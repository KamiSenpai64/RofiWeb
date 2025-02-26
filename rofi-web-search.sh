
#!/bin/bash

query=$(rofi -dmenu -p "Search the web:") || exit 1

# Check if input is a URL (contains . or starts with http)
if [[ "$query" =~ ^https?://.* || "$query" =~ \. ]]; then
    flatpak run app.zen_browser.zen --new-window "$query" &
else
    search_url="https://www.google.com/search?q=$(echo "$query" | sed 's/ /+/g')"
    flatpak run app.zen_browser.zen --new-window "$search_url" &
fi
