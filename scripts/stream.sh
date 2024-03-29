#!/bin/bash

# Start Xvfb
Xvfb :99 &

# Wait for Xvfb to start
sleep 2

# Set the DISPLAY environment variable
export DISPLAY=:99

# Start Xterm and connect to the tmux session
xterm -e "tmux attach -t session-01" &

# Wait for Xterm to start
sleep 2

# Check if the YouTube Stream Key is provided
if [ -z "$YT_STREAM_KEY" ]; then
    echo "Error: YouTube Stream Key is not set. Please provide the YouTube Stream Key through the YT_STREAM_KEY environment variable."
    exit 1
fi

# Capture the Xterm window and stream it to YouTube
ffmpeg -f x11grab -r 30 -s 1280x720 -i :99 -f flv -c:v libx264 -preset medium -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv "${YOUTUBE_URL}/${YT_STREAM_KEY}"
