#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
CYAN='\033[0;36m'
YELLOW='\033[33m'
NC='\033[0m' # No Color
CORRECT='✓'
ERROR='x'
KMOM="$1"
# STUD="$2"
# SOLUTIONPATH="../../.solutions/$KMOM"
KMOMPATH="../../me/$KMOM"
MEPATH="../../me"

SUCCESS=0

function header
{
    printf "\n\n"
    printf "${ORANGE}### %s ###${NC}\n\n\n" "Test suite for [$1] in the course [$3] for user [$2]"
}

function validation
{
  #echo "Running [npm run $2 --what=$1]"

  res=$(npm run --silent $2 --what="$1")

  [[ ! -z "$res" ]] && printf "$2 $1/ validates: ${RED}${ERROR}${NC} $res" || printf "$2 $1/ validates: ${GREEN}${CORRECT}${NC}"
  echo ""
}

function testKmom01If
{
    printf "\n${ORANGE}%s${NC}\n" "##### Testing if-numbers.js with argument $1 #####"
    # printf "\nArgument $1 should print:"
    printf "\n%s\n%s\n" "${@:2}"
    printf "${ORANGE}"
    node "if-numbers.js" "$1"
}

function testKmom01For
{
    printf "\n${ORANGE}%s${NC}\n" "##### Testing forloop.js with arguments $1 $2  #####"
    # printf "\nArguments $1 $2 should print:"
    printf "\n%s\n%s\n" "${@:3}"
    printf "${CYAN}"
    node "forloop.js" "$1" "$2"
}

function printYes
{
    printf "${GREEN}%s${NC}" "${CORRECT} Yes"
    printf "\n\n"
}

function printNo
{
    printf "${RED}%s${NC}" "${ERROR} No."
    printf "\n\n"
}

function printTest
{
    printf "${ORANGE}%s${NC}\n" "$1. $2"
}

function isSuccess {
    echo "$SUCCESS"
}

function checkIfFilesExist
{
    local counter=0
    local arr=("$@")
    for i in "${arr[@]}"; do
        (( counter++ ))
        printTest "$counter" "The file $i is present and have correct filename."

        if [[ -f "$MEPATH/$i" ]]; then
            printYes
        else
            printNo
            SUCCESS=1
        fi
    done
}


function checkDbwebbPort
{
    printTest "$1" "The environment variable DBWEBB_PORT is used in $2."
    used=$(cat "$KMOMPATH/$2" | grep "DBWEBB_PORT")

    if [[ ! -z "$used" ]]; then
        printYes
    else
        printNo
        SUCCESS=1
    fi
}

function checkForSudoKmom05
{
    printTest "6" "Docker can start without sudo."
    used=$(cat "$KMOMPATH/maze/kmom05.bash" | grep "sudo")

    if [[ -z "$used" ]]; then
        printYes
    else
        printNo
        SUCCESS=1
    fi
}

function checkForLoopTag
{
    printTest "3" ":loop tag used in docker-compose."
    used=$(cat "$KMOMPATH/maze2/docker-compose.yml" | grep ":loop")

    if [[ ! -z "$used" ]]; then
        printYes
    else
        printNo
        SUCCESS=1
    fi
}

function checkDockerHubLines
{
    printTest "4" "The file 'dockerhub.txt' contains only $2 row(s)."
    cat "$KMOMPATH/$1/dockerhub.txt" | wc -l
    lines=$(cat "$KMOMPATH/$1/dockerhub.txt" | wc -l)

    if [[ "$lines" -eq "$2" ]]; then
        printYes
    else
        printNo
        SUCCESS=1
    fi
}
