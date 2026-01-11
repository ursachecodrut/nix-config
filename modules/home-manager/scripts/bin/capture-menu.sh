#!/usr/bin/env bash

options="Copy to Clipboard\nSave to File\nOCR Text\nRecord Video"

choice=$(echo -e "$options" | walker --dmenu --placeholder "Capture:")

case "$choice" in
  "Copy to Clipboard")
    $HOME/.local/bin/screen-shot.sh copy
    ;;
  "Save to File")
    $HOME/.local/bin/screen-shot.sh save
    ;;
  "OCR Text")
    $HOME/.local/bin/screen-shot.sh ocr
    ;;
  "Record Video")
    $HOME/.local/bin/screen-record.sh
    ;;
esac
