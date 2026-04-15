#/bin/sh

LOCKER_FILE=/tmp/.locker-state

if [ '!' -f "$LOCKER_FILE" ]; then
    touch $LOCKER_FILE
    locker_state=0
else
    locker_state="$(cat $LOCKER_FILE)"
fi

locker_new_state=1

if [ "$locker_state" -eq 1 ]; then
    locker_new_state=0
fi

echo "$locker_new_state" > $LOCKER_FILE
