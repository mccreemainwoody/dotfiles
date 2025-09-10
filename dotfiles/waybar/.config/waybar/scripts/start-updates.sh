#!/bin/sh

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/check-updates.sh

command_to_run='echo'
args='Package manager could not be found. Please write down the update command yourself!'

case "$system" in
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

kitty --hold "$command_to_run" $args

