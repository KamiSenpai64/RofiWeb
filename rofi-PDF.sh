#!/bin/bash

BASE_DIR=~/LightNovels
LAST_OPENED_FILE=~/.config/last_opened_novel

declare -A ICONS=(
    [folder]='📂'
    [pdf]='📄'
    [epub]='📖'
    [star]='⭐'
    [back]='🔙'
)

navigate() {
    local current_dir="$1"

    while true; do
        # Get list of files and directories
        entries=()
        [ "$current_dir" != "$BASE_DIR" ] && entries+=("${ICONS[back]} ..") # Add back option

        # Find the last opened file
        last_opened=""
        [ -f "$LAST_OPENED_FILE" ] && last_opened=$(cat "$LAST_OPENED_FILE")

        # Get files and directories, sort them
        for entry in "$current_dir"/*; do
            [ -e "$entry" ] || continue
            name=$(basename "$entry")
            icon=""
            if [ -d "$entry" ]; then
                icon="${ICONS[folder]}"
            elif [[ "$entry" == *.pdf ]]; then
                icon="${ICONS[pdf]}"
            elif [[ "$entry" == *.epub ]]; then
                icon="${ICONS[epub]}"
            fi
            
            if [ "$entry" = "$last_opened" ]; then
                entries=("${ICONS[star]} $icon $name" "${entries[@]}")  # Highlight last opened file
            else
                entries+=("$icon $name")
            fi
        done

        [ ${#entries[@]} -eq 0 ] && exit  # If empty, exit

        # Use Rofi to select a file or directory
        chosen=$(printf "%s\n" "${entries[@]}" | rofi -dmenu -i -p "$(basename "$current_dir")")

        # Exit if nothing was chosen
        [ -z "$chosen" ] && exit

        # Handle back navigation
        if [[ "$chosen" == *"${ICONS[back]} .."* ]]; then
            current_dir=$(dirname "$current_dir")
            continue
        fi

        # Remove icon markers
        chosen="${chosen#${ICONS[star]} }"
        chosen="${chosen#${ICONS[folder]} }"
        chosen="${chosen#${ICONS[pdf]} }"
        chosen="${chosen#${ICONS[epub]} }"

        selected="$current_dir/$chosen"

        if [ -d "$selected" ]; then
            navigate "$selected"  # Recurse into directory
        elif [[ "$selected" == *.pdf || "$selected" == *.epub ]]; then
            echo "$selected" > "$LAST_OPENED_FILE"  # Save last opened file
            nohup okular "$selected" >/dev/null 2>&1 &
            exit
        fi
    done
}

navigate "$BASE_DIR"

