#!/bin/sh

PERIOD_DURATION="$1"

command_exist=$(command -v hypryaml; echo $?)

if [ ! command_exist ]; then
    exit_with_error "can't run script: hypryaml is not found"
fi

while true; do
    ~/.config/hypr/utils/apply_random_theme.sh 
    sleep "$PERIOD_DURATION"
done
