#!/bin/bash

# Define the start and end markers
START_MARKER="## Local - Start ##"
END_MARKER="## Local - End ##"

# Extract the current block between the markers
CURRENT_BLOCK=$(awk "/$START_MARKER/,/$END_MARKER/" /etc/hosts | grep -v "$START_MARKER" | grep -v "$END_MARKER")

# Check if the block is entirely commented
if echo "$CURRENT_BLOCK" | grep -qv '^#'; then
    echo -e "\033[1;32mCurrently in Prod mode.\033[0m" # Lines are uncommented
    MODE="Prod"
else
    echo -e "\033[1;31mCurrently in Local mode.\033[0m" # Lines are commented
    MODE="Local"
fi

# Prompt the user
read -p "Switch to $( [ "$MODE" == "Local" ] && echo "Prod" || echo "Local" ) mode? (Y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Backup the current hosts file
    sudo cp /etc/hosts /etc/hosts.bak
    echo -e "\033[1;34mBackup created at /etc/hosts.bak\033[0m"

    # Toggle comments in the block
    sudo awk -v start="$START_MARKER" -v end="$END_MARKER" -v mode="$MODE" '
        BEGIN {in_block=0}
        {
            if ($0 ~ start) {print; in_block=1; next}
            if ($0 ~ end) {in_block=0; print; next}
            if (in_block) {
                if (mode == "Local") {print substr($0, 2)} # Uncomment lines
                else {print "#" $0}                       # Comment lines
            } else {
                print
            }
        }
    ' /etc/hosts > /tmp/hosts

    # Replace the original hosts file with the modified one
    sudo mv /tmp/hosts /etc/hosts
    echo -e "\033[1;32mSwitched to $( [ "$MODE" == "Local" ] && echo "Prod" || echo "Local" ) mode!\033[0m"
else
    echo -e "\033[1;33mNo changes made.\033[0m"
fi
