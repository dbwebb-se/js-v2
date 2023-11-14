#!/usr/bin/env bash
# shellcheck disable=SC1091
. "functions.bash"

declare -a files=(
    "kmom02/animals.js"
    "kmom02/kmom02.js"
    "kmom02/jsdoc/index.html"
    "public/index.html"
    "public/kmom02.html"
    "public/js/kmom02.js"
    "public/js/modules/kmom02/animals.js"
    "public/js/modules/kmom02/greeting.js"

    )

# Print the header for the testsuite
header "$1" "$2" "$3"

# Check if the files exists and have correct filename
checkIfFilesExist "${files[@]}"

# cd "../../me/"

# Validate parts
# validation "kmom02" "eslint"
# validation "public" "eslint"
# validation "public" "htmlhint"
# validation "public" "stylelint"

# cp "kmom02.test.js" "$KMOMPATH/" && npm run test --what=kmom02
# rm "$KMOMPATH/kmom02.test.js"
# if [[ "$4" = "animals" ]]; then
#     cp "kmom02_main.mjs" "$KMOMPATH/" && node "$KMOMPATH/kmom02_main.mjs"
# fi

exit "$(isSuccess)"
