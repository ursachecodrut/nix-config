#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
NAME="Screenshot-$(date +%Y-%m-%d-%H%M%S_grim.png)"
FILE_PATH="$DIR/$NAME"

check_dep() {
    local cmd=$1
    local pkg=$2
    if ! command -v "$cmd" &> /dev/null; then
        notify-send -u critical "Screenshot Error" "Missing dependency: '$pkg'. Please install it."
        echo "Error: $pkg is not installed."
        exit 1
    fi
}

check_dep "grim" "grim"
check_dep "slurp" "slurp"
check_dep "notify-send" "libnotify"

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
        check_dep "wl-copy" "wl-clipboard"

        grim -g "$GEOMETRY" - | wl-copy
        notify-send "Screenshot" "Copied to Clipboard" 
        ;;
    "ocr")
        check_dep "wl-copy" "wl-clipboard"
        check_dep "tesseract" "tesseract-ocr"

        grim -g "$GEOMETRY" - | tesseract stdin stdout -l "eng+ron" | tr -d '\f' | wl-copy
        notify-send "OCR" "Text extracted to clipboard"
        ;;
        
    *)
        echo "Usage: ./screenshot.sh [save|copy|ocr]"
        exit 1
        ;;
esac
