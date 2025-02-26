#!/bin/bash

# Prompt for a URL to open
url=$(rofi -dmenu -i -p "Enter URL")

# If the URL is not empty, open it in Firefox
if [ ! -z "$url" ]; then
    firefox "$url"
fi
#
