#!/usr/bin/env bash
# shellcheck disable=SC1091
. "functions.bash"

declare -a files=(
    "public/jsdoc/index.html"
    "public/kmom06.html"
    "public/js/kmom06.js"
    "public/data/words.json"
    )

# Print the header for the testsuite
header "$1" "$2" "$3"

# CHeck if the files exists and have correct filename
checkIfFilesExist "${files[@]}"

exit "$(isSuccess)"
