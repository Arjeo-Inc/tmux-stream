#!/bin/bash

# Start Xvfb with the desired screen size
Xvfb :99 -screen 0 1280x800x24 &

# Wait for Xvfb to start
sleep 2

# Set the DISPLAY environment variable
export DISPLAY=:99

# Set the desired font and font size
xterm_font="Roboto Mono:size=12"

# Start Xterm with the specified font and connect to the tmux session
xterm -fa "$xterm_font" -fs 12 -geometry 124x39 -e "tmux attach -t session-01" &

# Wait for Xterm to start
sleep 2

# Capture the Xterm window and write the output to stdout
ffmpeg -f x11grab -r 30 -s 1280x800 -i :99 -f lavfi -i anullsrc -c:v libx264 -preset faster -pix_fmt yuv420p -r 30 -g 60 -b:v 4500k -f flv -
