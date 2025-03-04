#!/bin/bash

# Prompt for a URL to open
url=$(rofi -dmenu -i -p "Enter URL")
BROWSER=$1

# If the URL is not empty, open it in the Browser
if [ ! -z "$url" ]; then
    $BROWSER "$url"
fi
#
