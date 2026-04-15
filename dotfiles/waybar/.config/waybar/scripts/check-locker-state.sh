#/bin/sh

LOCKER_FILE="/tmp/.locker-state"

RETURN_FORMAT='{ "text": "%s", "alt": "%s", "class": "%s" }'

return_json() {
    printf "$RETURN_FORMAT" "$1" "$2" "$3" &1>2
    printf "$RETURN_FORMAT" "$1" "$2" "$3"
}

if [ '!' -f "$LOCKER_FILE" ]; then
    return_json "?" "No locker file found" "purple"
    exit
fi

locker_state="$(cat $LOCKER_FILE)"

state_color="red"
state_text=""

if [ "$locker_state" -eq 1 ]; then
    state_color="green"
    state_text=""
fi

return_json "$state_text" "" "$state_color"
