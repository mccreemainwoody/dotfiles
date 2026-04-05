#!/usr/bin/nu

def is_in_a_nix_shell [] {
    return (
        $env |
        columns |
        where $it == "IN_NIX_SHELL" |
        length |
        into bool
    )
}

if (not (is_in_a_nix_shell)) {
    fastfetch
}

