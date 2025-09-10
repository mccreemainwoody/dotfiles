#!/bin/sh

set -e

export PACKAGE_MANAGER="undefined"

if command -v emerge > /dev/null 2>&1; then
    export PACKAGE_MANAGER="emerge"
elif command -v pacman > /dev/null 2>&1; then
    export PACKAGE_MANAGER="pacman"
elif command -v nixos-rebuild > /dev/null 2>&1; then
    export PACKAGE_MANAGER="nixos"
elif command -v home-manager > /dev/null 2>&1; then
    export PACKAGE_MANAGER="home-manager"
elif command -v nix > /dev/null 2>&1; then
    export PACKAGE_MANAGER="nix"
elif command -v dnf > /dev/null 2>&1; then
    export PACKAGE_MANAGER="dnf"
elif command -v apt > /dev/null 2>&1; then
    export PACKAGE_MANAGER="apt"
fi
