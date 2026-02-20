#!/bin/sh

set -e

exit_with_error() {
    echo "$1"
    exit 1
}

CONFIG_DIR="$HOME/.config/hypr/hypryaml"

command_exist=$(command -v hypryaml; echo $?)

if [ ! command_exist ]; then
    exit_with_error "can't run script: hypryaml is not found"
fi

chosen_config=$(ls "$CONFIG_DIR" | sort -R | head -n 1)

hypryaml apply "$CONFIG_DIR/$chosen_config"
