#!/usr/bin/env bash
# shellcheck disable=SC1091
. "functions.bash"

declare -a files=(
    "public/jsdoc/index.html"
    "public/kmom05.html"
    "public/js/kmom05.js"
    )

# Print the header for the testsuite
header "$1" "$2" "$3"

# CHeck if the files exists and have correct filename
checkIfFilesExist "${files[@]}"

exit "$(isSuccess)"
