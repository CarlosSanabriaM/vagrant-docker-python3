#!/bin/bash

# Constants
COWSAY_FILES_ARRAY=("default" "three-eyes" "bud-frogs" "sheep" "moofasa" "moose" "tux")
MOTD_FIGLET_HEADER="Vagrant VM"
MOTD_TMUX_COMMANDS="Attach to the tmux session using the following command:
$ tmux attach -t python"

# Suppress `dpkg-preconfigure` warning related to stdin for `apt-get install`
#  https://serverfault.com/a/670688
export DEBIAN_FRONTEND=noninteractive

# Install packages
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

#  Welcome banner created with `figlet` and `lolcat`
figlet -t "$MOTD_FIGLET_HEADER" | # print header using `figlet`
  lolcat --spread 1.5 --force > /etc/motd # add rainbow coloring
#  Tmux commands for attaching to sessions created with `cowsay`
echo "$MOTD_TMUX_COMMANDS" |
  cowsay -n -f "$cowsayFile" | # print message using `cowsay` and the randomly selected cowfile
  perl -pe 's/\$ ([^>|\/\\]+)/\e[1;35m\$ \e[1;36m$1\e[0m/' >> /etc/motd # use regex to add coloring to tmux command

# Log message
echo "Message Of The Day (MOTD) updated with cowsay file: $cowsayFile"
