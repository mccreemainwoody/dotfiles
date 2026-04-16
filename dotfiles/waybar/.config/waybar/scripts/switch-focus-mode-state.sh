#/bin/sh

FOCUS_MODE_FILE=/tmp/.focus-mode-state

if [ '!' -f "$FOCUS_MODE_FILE" ]; then
    touch $FOCUS_MODE_FILE
    focus_mode_state=0
else
    focus_mode_state="$(cat $FOCUS_MODE_FILE)"
fi

focus_mode_new_state=1

if [ "$focus_mode_state" -eq 1 ]; then
    focus_mode_new_state=0
fi

echo "$focus_mode_new_state" > $FOCUS_MODE_FILE
