#!/usr/bin/env bash

VIDEODIR="$HOME/Videos"
DATE_FORMAT="+%Y-%m-%d_%H-%M-%S"

if ! pgrep "wf-recorder" >/dev/null; then
    if [ ! -d "$VIDEODIR" ]; then
        mkdir -p "$VIDEODIR"
    fi
    FILENAME="$VIDEODIR/Screen-Recording-$(date --utc "$DATE_FORMAT").mp4"
    
    # Start recording + Notification
    notify-send "Recording Started" "Saving to $FILENAME" -t 3000
    wf-recorder -f "$FILENAME" -g "$(slurp)" &>/dev/null &
else
    # Stop recording + Notification
    killall -s SIGINT wf-recorder
    notify-send "Recording Saved" "Video stopped" -t 3000
fi
