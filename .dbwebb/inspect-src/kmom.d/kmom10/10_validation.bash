#!/usr/bin/env bash

. ../.dbwebb/inspect-src/kmom.d/colors.bash

function header {
    printf "\033[32;01m>>> -------------- %-20s -------------------------\033[0m\n" "$1"
}

function validation
{
  #echo "Running [npm run $2 --what=$1]"

  res=$(npm run --silent $2 --what="$1")

  [[ ! -z "$res" ]] && printf "$2 $1/ validates: ${RED}${ERROR}${NC} $res" || printf "$2 $1/ validates: ${GREEN}${CORRECT}${NC}"
  echo ""
}

validation "public" "eslint"
validation "public" "htmlhint"
validation "public" "stylelint"

printf "\n%s" "Press any key to proceed."
read

exit 0
