#/bin/sh

LOCKER_FILE=/tmp/.locker-state

locker_on=1

get_locker_state() {
    if [ '!' -f "$LOCKER_FILE" ]; then
        return
    fi

    locker_state="$(cat $LOCKER_FILE)"

    if [ "$locker_state" -eq 1 ]; then
        locker_on=0
    fi
}

get_locker_state

if [ "$locker_on" -eq 0 ]; then
    echo "Not disabling : hyprlock is disabled"
    exit
fi

loginctl lock-session
