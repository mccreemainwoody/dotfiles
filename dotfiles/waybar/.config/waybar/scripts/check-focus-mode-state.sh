#!/bin/sh

FOCUS_MODE_FILE="/tmp/.focus-mode-state"

RETURN_FORMAT='{ "text": "%s", "alt": "%s", "class": "%s" }'

return_json() {
    printf "$RETURN_FORMAT" "$1" "$2" "$3"
}

if [ '!' -f "$FOCUS_MODE_FILE" ]; then
    return_json "?" "No focus mode file found" "unknown"
    exit
fi

focus_mode_state="$(cat $FOCUS_MODE_FILE)"

state_color="inactive"
state_text=""

if [ "$focus_mode_state" -eq 1 ]; then
    state_color="active"
    state_text="󰈈"
fi

return_json "$state_text" "" "$state_color"
