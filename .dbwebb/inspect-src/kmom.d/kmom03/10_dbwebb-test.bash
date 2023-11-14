#!/usr/bin/env bash

function header {
    printf "\033[32;01m>>> -------------- %-20s -------------------------\033[0m\n" "$1"
}

dbwebb test kmom03 || exit 1

printf "\n%s" "Press any key to proceed."
read

exit 0
