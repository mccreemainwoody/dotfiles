#!/bin/sh

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/detect-package-manager.sh"

kitty_args=""
command_to_run='echo'
args='Package manager could not be found. Please write down the update command yourself!'

case "$PACKAGE_MANAGER" in
    'emerge')
        command_to_run='sudo'
        args='emerge -uDN @world'
        ;;
    'pacman')
        command_to_run='sudo'
        args='pacman -Su'
        ;;
    'nixos')
        command_to_run='nixos-rebuild '
        args='--switch'
        ;;
    'home-manager')
        command_to_run='home-manager'
        args='switch'
        ;;
    'nix')
        command_to_run='nix'
        args='profile upgrade --impure --all'
        ;;
    'dnf')
        command_to_run='sudo'
        args='dnf upgrade'
        ;;
    'apt')
        command_to_run='sudo'
        args='apt update'
        ;;
esac

if [ "$command_to_run" == "echo" ]; then
    kitty_args="--hold $kitty_args"
fi

kitty $kitty_args "$command_to_run" $args

