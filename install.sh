#!/bin/bash

# Color variables for pretty output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Function to check if a command succeeded
check_command() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: $1 failed. Please check the logs for details.${RESET}"
        exit 1
    fi
}

# Log file location
LOG_FILE="$HOME/.scripts/install_log.txt"

# Function to log actions
log_action() {
    echo "$(date) - $1" >> "$LOG_FILE"
}

# Clear screen for better view
clear

echo -e "${BLUE}Starting installation...${RESET}"

# Create ~/.scripts directory if it doesn't exist
if [ ! -d "$HOME/.scripts" ]; then
  echo -e "${YELLOW}Creating ~/.scripts directory...${RESET}"
  mkdir "$HOME/.scripts"
  check_command "Creating ~/.scripts"
  log_action "Created ~/.scripts directory."
else
  echo -e "${GREEN}~/.scripts directory already exists.${RESET}"
fi

# Copy RofiWeb directory from the current Git repo to ~/.scripts if not already there
if [ ! -d "$HOME/.scripts/RofiWeb" ]; then
  if [ -d "$PWD/RofiWeb" ]; then
    echo -e "${YELLOW}Copying RofiWeb directory to ~/.scripts...${RESET}"
    cp -r "$PWD/RofiWeb" "$HOME/.scripts/RofiWeb"
    check_command "Copying RofiWeb"
    log_action "Copied RofiWeb directory to ~/.scripts."
  else
    echo -e "${RED}RofiWeb directory not found in the current repository location.${RESET}"
    exit 1
  fi
else
  echo -e "${GREEN}RofiWeb is already in ~/.scripts.${RESET}"
fi

# Ask if the user wants to add a keybind for RofiWeb
read -p "$(echo -e ${BLUE}Would you like to add a keybind for RofiWeb? (yes/no): ${RESET}) " add_keybind

if [ "$add_keybind" == "no" ]; then
  echo -e "${GREEN}Thank you for using RofiWeb!${RESET}"
  exit 0
fi

# Ask for the keybind input
read -p "$(echo -e ${BLUE}What keybind would you like to use? (example: \$mod+l): ${RESET}) " keybind

# Backup i3 config before making any changes
I3_CONFIG="$HOME/.config/i3/config"
if [ -f "$I3_CONFIG" ]; then
  echo -e "${YELLOW}Backing up i3 config to i3_config_backup_$(date +%F_%T).bak...${RESET}"
  cp "$I3_CONFIG" "$HOME/.config/i3/i3_config_backup_$(date +%F_%T).bak"
  check_command "Backing up i3 config"
  log_action "Backed up i3 config."
else
  echo -e "${RED}i3 config not found, skipping backup.${RESET}"
fi

# Add the keybind to the i3 config
echo "bindsym $keybind exec --no-startup-id $HOME/.scripts/RofiWeb/web-search.sh" >> "$I3_CONFIG"
check_command "Adding keybind to i3 config"
log_action "Added keybind $keybind to i3 config."

# Success message
echo -e "${GREEN}Thank you for using RofiWeb!${RESET}"

# Log completion
log_action "RofiWeb installation complete."

# https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar
