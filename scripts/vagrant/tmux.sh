#!/bin/bash

# TODO: Replace this script with a Tmux Session Manager such as tmuxinator? (https://github.com/tmuxinator/tmuxinator)

#region Constants
TMUX_CONFIGURATION_FILE="/etc/tmux.conf"
TMUX_SESSIONS_CONFIGURATION_DIR="/etc/.tmux"
# Session
TMUX_SESSION_NAME="python"
TMUX_SESSION_CONFIGURATION_FILE="${TMUX_SESSIONS_CONFIGURATION_DIR}/${TMUX_SESSION_NAME}"
#endregion

# Log message
echo "Configure tmux"

# Create tmux configuration file
cat <<EOF > $TMUX_CONFIGURATION_FILE
source-file $TMUX_SESSION_CONFIGURATION_FILE
EOF

# Create tmux session configuration dir
mkdir -p $TMUX_SESSIONS_CONFIGURATION_DIR

#region Create tmux sessions configuration files (https://wiki.archlinux.org/title/tmux#Session_initialization)
cat <<EOF > $TMUX_SESSION_CONFIGURATION_FILE
# Create tmux session
new-session -s $TMUX_SESSION_NAME

# Split window horizontally (in 2 panes: 0 | 1) and execute command in the right pane
split-window -h "docker exec -it vagrant_python_1 ipython"

# Select left pane
select-pane -t left

# Execute commands in the left pane
send-keys "cd /vagrant" Enter
send-keys "clear" Enter

# Split window vertically
split-window -v

# TODO: Try to fix this to not show the command (show only the output)
# Execute commands in the bottom pane
send-keys "docker logs vagrant_python_1 2>&1 | grep -o '[^ ]*127.0.0.1[^ ]*' | tail -n 1 | xargs -i printf '\n\n\n\nJupyterLab URL:\n{}\n\n\n\n\n'" Enter

# Select right pane
select-pane -t right
EOF
#endregion

# Log message
echo "Configured tmux"