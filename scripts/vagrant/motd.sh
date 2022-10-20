#!/bin/bash

# Constants
COWSAY_FILES_ARRAY=("default" "three-eyes" "bud-frogs" "sheep" "moofasa" "moose" "tux")
MOTD_FIGLET_HEADER="Vagrant VM"
MOTD="Attach to the tmux session using the following command:
$ tmux attach -t python"

# Log message
echo "Configure MOTD"

# Update package manager and install packages
#sudo apt-get update
apt-get install -y cowsay
apt-get install -y figlet

# Get array size
cowsayFilesArraySize=${#COWSAY_FILES_ARRAY[@]}

# Get last array index
cowsayFilesArrayLastIndex=$((cowsayFilesArraySize-1))

# Generate random value in the range [0, cowsayFilesArrayLastIndex]
cowsayFilesArrayRandomIndex=$(shuf -i 0-$cowsayFilesArrayLastIndex -n 1)

# Get value from the array, using the random index
cowsayFile=${COWSAY_FILES_ARRAY[$cowsayFilesArrayRandomIndex]}

# Create a message of the day that will be displayed on login, storing it in /etc/motd
figlet -t "$MOTD_FIGLET_HEADER" > /etc/motd
printf "%s" "$MOTD" | /usr/games/cowsay -n -f "$cowsayFile" >> /etc/motd

# Log message
echo "Message Of The Day (MOTD) updated with cowsay file: $cowsayFile"
