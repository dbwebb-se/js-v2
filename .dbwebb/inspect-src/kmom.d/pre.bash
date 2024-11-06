#!/usr/bin/env bash
#
# Script run BEFORE kmom specific scripts.
# Put tests here that applies to all kmoms.
#
# Available (and usable) data:
#   $COURSE
#   $KMOM
#   $ACRONYM
#   $REDOVISA_HTTP_PREFIX
#   $REDOVISA_HTTP_POSTFIX
#   eval "$BROWSER" "$url" &
#
printf ">>> -------------- Pre (all kmoms) ----------------------\n"

# # Open localhost:1337 in browser
# printf "Open localhost:1337/eshop/index in browser\n"
# eval "$BROWSER" "http://127.0.0.1:1337/eshop/index" &

# Open me/kmom01/redovisa
url="$REDOVISA_HTTP_PREFIX/~$ACRONYM/dbwebb-kurser/$COURSE/me/public"
printf "$url\n" 2>&1
eval "$BROWSER" "$url" &

if [[ "$KMOM" = "kmom01" ]] || [[ "$KMOM" = "kmom02" ]]; then
    url="$REDOVISA_HTTP_PREFIX/~$ACRONYM/dbwebb-kurser/$COURSE/me/$KMOM/jsdoc/index.html"
    printf "$url\n" 2>&1
    eval "$BROWSER" "$url" &
fi

# if [[ "$KMOM" = "kmom06" ]]; then
#     if [[ -f "me/public/data/words.json" ]]; then
#         mv "me/public/data/words.json" "me/public/data/words_temp.json"
#         echo "[\"Anka\", \"Blåbär\", \"Citron\", \"Drejskiva\", \"Elkontakt\"]" > "me/public/data/words.json"
#         cd me && npm run http-server &
#     else
#         echo "No such file :("
#     fi

#     local url="localhost:9001"
#     printf "$url\n" 2>&1
#     eval "$BROWSER" "$url" &
# fi
if [[ "$KMOM" != "kmom01" ]]; then
  url="$REDOVISA_HTTP_PREFIX/~$ACRONYM/dbwebb-kurser/$COURSE/me/public/jsdoc/index.html"
  printf "$url\n" 2>&1
  eval "$BROWSER" "$url" &
fi

# if [[ ! -f "package.json" ]] || [[ ! -f ".eslintrc.json" ]] || [[ ! -f "jsdoc.json" ]] || [[ ! -f ".stylelintrc.json" ]];then
#     read -p "Missing files. Should I fix it? [Y/n]" answer
#     if [[ "$answer" != "n" ]]; then
#         cp docs/example/configfiles/.eslintrc.json .
#         cp docs/example/configfiles/package.json .
#         cp docs/example/configfiles/jsdoc.json .
#         cp docs/example/configfiles/.stylelintrc.json .

#         npm install --silent || exit 0
#     else
#         exit 1
#     fi
# fi

# if [[ ! -d "node_modules" ]]; then
#     read -p "Missing folder npm_modules. Should I fix it? [Y/n]" answer
#     if [[ "$answer" != "n" ]]; then
#         npm install --silent
#     else
#         exit 1
#     fi
# fi
