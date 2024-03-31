#!/bin/bash

export DISPLAY=:99
# The first argument is the YouTube Live Chat ID
CHAT_ID=$1
# Open the YouTube live chat in google-chrome-stable with specified DISPLAY
google-chrome-stable --no-sandbox --force-device-scale-factor=1.5 "https://www.youtube.com/live_chat?is_popout=1&v=$CHAT_ID" &
CHROME_PID=$!

# Pause for a bit to allow chrome to open and load the page
sleep 5

# Get the window id of chrome
WID=$(xdotool search --onlyvisible --name "youtube.com/live_chat" | head -1)

# Take a screenshot of the window
import -window "$WID" screenshot.png

# If the second argument is "stop", kill the chrome process
echo Creating and viewing the screen shot
if [ "\$2" = "stop" ]; then
    kill $CHROME_PID
fi
