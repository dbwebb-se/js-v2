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

# #!/usr/bin/env bash

# function header {
#     printf "\033[32;01m>>> -------------- %-20s -------------------------\033[0m\n" "$1"
# }



# if [[ ! -f "package.json" ]] || [[ ! -f ".eslintrc.json" ]]; then
#     read -p "Missing files. Should I fix it? [Y/n]" answer
#     if [[ "$answer" != "n" ]]; then
#         cp example/environment/.eslintrc.json .
#         cp example/environment/package.json .
#         npm install
#     else
#         exit 1
#     fi
# fi

# if [[ ! -d "node_modules" ]]; then
#     read -p "Missing folder npm_modules. Should I fix it? [Y/n]" answer
#     if [[ "$answer" != "n" ]]; then
#         npm install
#     else
#         exit 1
#     fi
# fi

# npm run linter "me/kmom03/" --silent || exit 1

# read -p "All good. Done? "

# exit 0
