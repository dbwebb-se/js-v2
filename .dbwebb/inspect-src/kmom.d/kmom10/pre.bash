#!/usr/bin/env bash

function header {
    printf "\033[32;01m>>> -------------- %-20s -------------------------\033[0m\n" "$1"
}

cd me || exit 1

header "OPENING FILES IN VSCode"
code public
