#!/usr/bin/env bash

options="Power Off\nRestart\nSuspend\nLock\nLogout"
choice=$(echo -e "$options" | walker --dmenu --placeholder "Power:")

case "$choice" in
  "Power Off") systemctl poweroff ;;
  "Restart") systemctl reboot ;;
  "Suspend") systemctl suspend ;;
  "Lock") hyprlock ;;
  "Logout") hyprctl dispatch exit ;;
esac
