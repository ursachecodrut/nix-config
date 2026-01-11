#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
NAME="Screenshot-$(date +%Y-%m-%d-%H%M%S_grim.png)"
FILE_PATH="$DIR/$NAME"

if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

GEOMETRY=$(slurp)
if [ -z "$GEOMETRY" ]; then
    exit 1
fi

case $1 in
    "save")
        grim -g "$GEOMETRY" "$FILE_PATH"
        notify-send "Screenshot Saved" "Path: $FILE_PATH" -i "$FILE_PATH"
        ;;
        
    "copy")
        grim -g "$GEOMETRY" - | wl-copy
        notify-send "Screenshot" "Copied to Clipboard" 
        ;;
    "ocr")
        grim -g "$GEOMETRY" - | tesseract stdin stdout -l "eng+ron" | tr -d '\f' | wl-copy
        notify-send "OCR" "Text extracted to clipboard"
        ;;
        
    *)
        echo "Usage: ./screenshot.sh [save|copy|ocr]"
        exit 1
        ;;
esac
