#!/bin/sh

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

throw_error() {
    message=$1

    echo "$message"

    exit 1
}

throw_not_implemented_error() {
    throw_error "package retrieving from $package_manager is not yet implemented" >2
}

source "$SCRIPT_DIR/detect-package-manager.sh"

upgradable_packages=""
upgradable_packages_formatted=""
total_updates=0

case "$PACKAGE_MANAGER" in
    'emerge')
        upgradable_packages=$(
            eix --world --upgrade --compact \
                | grep "[U]" \
                | grep -Eo "[a-zA-Z_-]+/[a-zA-Z_-]+" \
            || true
        )
        total_updates=$(eix --world --upgrade --compact | grep "[U]" | wc -l)
        ;;
    'pacman')  # Not implemented
        throw_not_implemented_error "pacman"
        ;;
    'nixos')
        throw_not_implemented_error "NixOS"
        ;;
    'home-manager')
        throw_not_implemented_error "Nix home-manager"
        ;;
    'nix')
        throw_not_implemented_error "Nix"
        ;;
    'dnf')
        throw_not_implemented_error "dnf"
        ;;
    'apt')
        throw_not_implemented_error "apt"
        ;;
    *)
        throw_error "unexpected package manager name : $PACKAGE_MANAGER"
esac


css_class=""

if [ "$total_updates" -ge 18 ]; then
    css_class="purple"
elif [ "$total_updates" -ge 12 ]; then
    css_class="red"
elif [ "$total_updates" -ge 7 ]; then
    css_class="yellow"
elif [ "$total_updates" -ge 1 ]; then
    css_class="green"
fi


if [ -n "$upgradable_packages" ]; then
    upgradable_packages_formatted=$(
        echo $upgradable_packages | sed "s/ /\\\\n/g"
    )
else
    upgradable_packages_formatted="System is up to date! :D"
fi

printf \
    '{ "text": "%d", "alt": "%s", "class": "%s" }' \
    "$total_updates" \
    "$upgradable_packages_formatted" \
    "$css_class"
