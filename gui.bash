#!/usr/bin/env bash
#
# GUI for dbwebb inspect.
#
VERSION="v2.12.0 (2023-09-06)"

# Messages
MSG_OK="\033[0;30;42mOK\033[0m"
MSG_DONE="\033[1;37;40mDONE\033[0m"
MSG_WARNING="\033[43mWARNING\033[0m"
MSG_FAILED="\033[0;37;41mFAILED\033[0m"


# ---------------------------- Functions ------------------

#
# Press enter to continue
#
pressEnterToContinue()
{
    local void

    if [[ ! $YES ]]; then
        printf "\nPress enter to continue..."
        read void
    fi
}



#
# Read input from user supporting a default value for reponse.
#
# @arg1 string the message to display.
# @arg2 string the default value.
#
input()
{
    read -r -p "$1: "
    echo "${REPLY:-$2}"
}



#
# Read input from user replying with yY or nN.
#
# @arg1 string the message to display.
# @arg2 string the default value, y or n.
#
yesNo()
{

    read -r -p "$1 (y/n) [$2]: "
    echo "${REPLY:-$2}"
}



#
# Display information message and wait for user input to continue, exit if
# user presses 'q'.
#
# @arg1 string the message to display.
#
info()
{
    echo -e "\n$1"
    read -r -p ""
    case "$REPLY" in
        q)
            exit 1
            ;;
    esac
}



#
# Fail, die and present error message.
#
# @arg1 string the message to display.
# @arg2 string exit status (default 1).
#
die()
{
    local message="$1"
    local status="${2:1}"

    printf "$MSG_FAILED $message\n" >&2
    exit $status
}



#
# Set correct settings of the remote student files, populary called "potatoe".
#
# @arg1 string the acronym.
#
potatoe()
{
    local acronym
    local course="$COURSE"

    if [[ $2 = "false" ]]; then
        course=
    fi

    acronym=$( input "Uppdatera rättigheterna för denna student?" "$1" )
    dbwebb run "sudo /usr/local/sbin/setpre-dbwebb-kurser.bash $acronym $course"
    #dbwebb run "sudo /usr/local/sbin/setpre-dbwebb-kurser.bash $acronym"
}



#
# Use command (wget, curl, lynx) to download url and output to file.
# The variable OPTION_WITH_WGET_ALT can be used to specify the tool
# to use, wget is default and options are curl and lynx.
#
function getUrlToFile
{
    local cmd=
    local verbose=
    local url="$1"
    local filename="$2"
    local overwrite="$3"

    if [ -z "$OPTION_WITH_WGET_ALT" ] && hash wget 2>/dev/null; then
        verbose="--quiet"
        [[ $VERY_VERBOSE ]] && verbose="--verbose"
        cmd="wget $verbose -O \"$filename\" \"$url\""
    elif ([ -z "$OPTION_WITH_WGET_ALT" ] || [ "$OPTION_WITH_WGET_ALT" = "curl" ]) && hash curl 2>/dev/null; then
        cmd="curl --fail --silent $verbose \"$url\" -o \"$filename\""
    elif ([ -z "$OPTION_WITH_WGET_ALT" ] || [ "$OPTION_WITH_WGET_ALT" = "lynx" ]) && hash lynx 2>/dev/null; then
        cmd="lynx -source \"$url\" > \"$filename\""
    fi

    if [ -f "$filename" ] && [ -z "$overwrite" ]; then
        die "The file '$filename' already exists, please remove it before you download a new."
    fi
    [[ $OPTION_DRY ]] || bash -c "$cmd"
}



#
# Create a config file that are sourced each time the application starts.
#
createConfigFile()
{
    local url="https://raw.githubusercontent.com/dbwebb-se/inspect-gui/master/gui_config.bash"
    local source="/tmp/gui_config.bash$$"
    local reply=

    if [[ -f $DBWEBB_GUI_CONFIG_FILE ]]; then
        reply=$( yesNo "Du har redan en konfigurationsfil, vill du skriva över den?" "n" )
        case "$reply" in
            [yY]) ;;
            *) printf "Ignoring..." && return ;;
        esac
    fi

    install -d "$( dirname $DBWEBB_GUI_CONFIG_FILE )"

    getUrlToFile "$url" "$source" "overwrite" \
        && cp "$source" "$DBWEBB_GUI_CONFIG_FILE" \
        && printf "Konfigurationsfilen är nu skapad, redigera den i en texteditor.\n" \
        && ls -l "$DBWEBB_GUI_CONFIG_FILE"

    # shellcheck source=$HOME/.dbwebb.gui_config.bash
    [[ -f $DBWEBB_GUI_CONFIG_FILE ]] && source "$DBWEBB_GUI_CONFIG_FILE"
}



#
# Show and edit the configuration file.
#
showAndEditConfigFile()
{
    local editor=${EDITOR:-vi}
    $editor "$DBWEBB_GUI_CONFIG_FILE"

    # shellcheck source=$HOME/.dbwebb.gui_config.bash
    [[ -f $DBWEBB_GUI_CONFIG_FILE ]] && source "$DBWEBB_GUI_CONFIG_FILE"
}



#
# Goto directory and check its status on .git
# @arg1 string the path to move to.
#
check_dir_for_git()
{
    pushd $1
    if [ ! -d .git ]; then
        echo "No git-repo on highest level: $1"
        ls -l
        return
    fi

    # Show details
    git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short
    echo "$1"
    git remote -v
    git tag

    # Checkout version and set it up
    TAG=$( input "Checkout tag" "" )
    git checkout $TAG
    npm install
    popd
}



#
# Find the course repo file.
#
function findCourseRepoFile
{
    dir="$( pwd )/."
    while [ "$dir" != "/" ]; do
        dir=$( dirname "$dir" )
        found="$( find "$dir" -maxdepth 1 -name $DBW_COURSE_FILE_NAME )"
        if [ "$found" ]; then
            DBW_COURSE_DIR="$( dirname "$found" )"
            break
        fi
    done
}



#
# Get the name of the course as $DBW_COURSE
#
function sourceCourseRepoFile
{
    DBW_COURSE_FILE="$DBW_COURSE_DIR/$DBW_COURSE_FILE_NAME"
    if [ -f "$DBW_COURSE_FILE" ]; then
        # shellcheck source=$DBW_COURSE_DIR/$DBW_COURSE_FILE_NAME
        source "$DBW_COURSE_FILE"
    fi
}



#
# Check if all tools are available
#
function checkTool() {
    if ! hash "$1" 2> /dev/null; then
        printf "$MSG_FAILED Missing '$1'.\n$2\n"
        exit -1
    fi
}



#
# Open an url in the default browser
#
# @arg1 the url
#
function openUrl {
    local url="$1"

    printf "$url\n"
    eval "$BROWSER" "$url" &
    sleep 0.5
}



#
# Open an Git http or git@ url browser
#
# @arg1 the remote as https or git@gitxxx.com
#
function openGitUrl {
    local url="$1"
    #local re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"
    local re="^git@(.+):(.+)\/(.+)(\.git)?$"

    if [[ $url == https://* ]]; then
        openUrl "$url"
    elif [[ $url =~ $re ]]; then
        hostname=${BASH_REMATCH[1]}
        user=${BASH_REMATCH[2]}
        repo=${BASH_REMATCH[3]}
        gitUrl="https://$hostname/$user/$repo"
        openUrl "$gitUrl"
    fi
}



#
# Open a specific url in the default browser, but use a base url if it
# does not exists as a local relative path.
#
# @arg1 the base http adress
# @arg2 the base url to use
# @arg3 the specific url to try and use
#
function openSpecificUrl {
    local base="$1"
    local baseUrl="$2"
    local specificUrl="$3"
    local modified="$baseUrl/$specificUrl"

    #echo "TRYING: -f $modified"

    if [[ -f "$modified" || -d "$modified" ]]; then
        #echo "FILE/DIR: $modified"
        openUrl "$base/$modified"
        return
    fi

    modified=${modified%/*}

    #echo "TRYING: -d $modified"

    if [[ -d $modified ]]; then
        #echo "FOUND DIR: $modified"
        openUrl "$base/$modified"
        return
    fi

    #echo "USING BASE"
    openUrl "$base/$baseUrl"
}



#
# Check if the git tag is between two versions
# >=@arg2 and <@arg3
#
# @arg1 string the path to the dir to check.
# @arg2 string the lowest version number to check.
# @arg3 string the highest version number to check.
#
hasGitTagBetween()
{
    local where="$1"
    local low=
    local high=
    local semTag=

    low=$( getSemanticVersion "$2" )
    high=$( getSemanticVersion "$3" )
    #echo "Validate that tag exists >=$2 and <$3 ."

    local success=false
    local highestTag=0
    local highestSemTag=0

    if [ -d "$where" ]; then
        while read -r tag; do
            semTag=$( getSemanticVersion "$tag" )
            #echo "trying tag $tag = $semTag"
            if [ $semTag -ge $low -a $semTag -lt $high ]; then
                #echo "success with $tag"
                success=
                if [ $semTag -gt $highestSemTag ]; then
                    highestTag=$tag
                    highestSemTag=$semTag
                fi
            fi
        done < <( cd "$where" && git tag )
    fi

    if [ "$success" = "false" ]; then
        printf "$MSG_FAILED Failed to validate tag exists >=%s and <%s." "$2" "$3"
    fi

    echo $highestTag
}



#
# Convert version to a comparable string
# Works for 1.0.0 and v1.0.0
#
# @arg1 string the version to check.
#
function getSemanticVersion
{
    #local version=${1:1}
    local version=$( echo $1 | sed s/^[vV]// )
    echo "$version" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }'
}



# ---------------------------- Bootstrap ------------------
# Check needed utils is available
#
#
checkTool dialog "Install using your packet manager (apt-get|brew install dialog)."
#checkTool realpath "Install using your packet manager (brew install coreutils)."

# What is the directory of the current course repo, find recursivly up the tree
DBW_COURSE_FILE_NAME=".dbwebb.course"
findCourseRepoFile
[[ $DBW_COURSE_DIR ]] || die "You must run this command within a valid course repo."
DIR="$DBW_COURSE_DIR"
TENTAMEN_DIR="$DIR/exam"

# Get the name of the course as $DBW_COURSE
sourceCourseRepoFile
[[ $DBW_COURSE ]] || die "Your course repo does not seem to have a valid or correct '$DBW_COURSE_FILE_NAME'."
COURSE="$DBW_COURSE"

# Source the user config file if it exists
DBWEBB_GUI_CONFIG_FILE="$HOME/.dbwebb/gui_config.bash"
# shellcheck source=$HOME/.dbwebb.gui_config.bash
[[ -f $DBWEBB_GUI_CONFIG_FILE ]] && source "$DBWEBB_GUI_CONFIG_FILE"

# Save INSPECT_PID to be able to kill it
DBWEBB_INSPECT_PID=

# Preconditions
hash dialog 2>/dev/null \
    || die "You need to install 'dialog'."

# Preconditions
hash tree 2>/dev/null \
    || die "You need to install 'tree'."

# Where to store the logfiles
LOG_BASE_DIR="$DIR/.log/inspect"
install -d -m 0777 "$LOG_BASE_DIR"

LOG_DOCKER_REL=".log/inspect/docker.txt"
export LOG_DOCKER="$DIR/$LOG_DOCKER_REL"

LOGFILE="$LOG_BASE_DIR/gui-main.ansi"
LOGFILE_INSPECT="$LOG_BASE_DIR/gui-inspect.ansi"
LOGFILE_TEXT="$LOG_BASE_DIR/gui-feedback.ansi"

# Settings
BACKTITLE="dbwebb/$COURSE"
TITLE="Work with kmoms"

# OS specific default settings
BROWSER="firefox"
TO_CLIPBOARD="xclip -selection c"
OS_TERMINAL=""

if [[ "$(uname -r)" == *"microsoft"* ]]; then   # WSl on Unix
    OS_TERMINAL="wsl"
    TO_CLIPBOARD="clip.exe"
    BROWSER="wslview"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then   # Linux, use defaults
    OS_TERMINAL="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then   # Mac OSX
    OS_TERMINAL="macOS"
    TO_CLIPBOARD="iconv -t macroman | pbcopy"
    BROWSER="open"
elif [[ "$OSTYPE" == "cygwin" ]]; then    # Cygwin
    OS_TERMINAL="cygwin"
    TO_CLIPBOARD="cat - > /dev/clipboard"
    BROWSER="/cygdrive/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"
elif [[ "$OSTYPE" == "msys" ]]; then
    :
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
fi

# Use defaults or overwrite from configuration/environment settings
BROWSER=${DBWEBB_BROWSER:-$BROWSER}
TO_CLIPBOARD=${DBWEBB_TO_CLIPBOARD:-$TO_CLIPBOARD}
TEACHER_SIGNATURE=${DBWEBB_TEACHER_SIGNATURE:-"// XXX"}

# Set source dir for scripts and feedback
INSPECT_SOURCE_DIR="$DIR/.dbwebb/inspect-src"
INSPECT_SOURCE_DIR=${DBWEBB_INSPECT_SOURCE_DIR:-$INSPECT_SOURCE_DIR}
INSPECT_SOURCE_CONFIG_FILE="$INSPECT_SOURCE_DIR/config.bash"

[[ -d  "$INSPECT_SOURCE_DIR" ]] || die "The path to inspect source files does not exists:\n INSPECT_SOURCE_DIR='$INSPECT_SOURCE_DIR'."

# shellcheck source=$DIR/.dbwebb/inspect-src/config.bash
[[ -f $INSPECT_SOURCE_CONFIG_FILE ]] && source "$INSPECT_SOURCE_CONFIG_FILE"

# Useful defaults which are used within the application
# @TODO This is not really needed
dockerContainer="mysql"

# Remember last menu choice (or set defaults)
mainMenuSelected=1



# --------------------------- GUI functions ------------------------------

#
#
#
gui-firstpage()
{
    local message

    read -r -d "" message << EOD
README ($VERSION)
================================================

This is a graphical gui for working with inspect.

WARNING. All your files in 'me/' is overwritten on each download.

Prepare by this:
    * dbwebb update
    * dbwebb init-me
    * make install # For local inspects

The output from inspect is written to files in '.log/inspect'.

Review the admin menu for customizing and creating a configuration file where you can store customized settings.
 $DBWEBB_GUI_CONFIG_FILE

Basic feedback text is created from files in txt/kmom??.txt, add your own teacher signature through the configuration file (see Admin Menu).

/Mikael
EOD

    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --msgbox "$message" \
        24 80 \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
gui-show-configuration()
{
    local message

    read -r -d "" message << EOD
SETTINGS
================================================

These are your current settings that are currently used.

 BROWSER="$BROWSER"
 OS_TERMINAL="$OS_TERMINAL"
 TEACHER_SIGNATURE="$TEACHER_SIGNATURE"
 TO_CLIPBOARD="$TO_CLIPBOARD"

All these are set with default values (within the script) and you can override them by setting the following environment variabels, preferably using the configuration file.

 DBWEBB_BROWSER="$DBWEBB_BROWSER"
 DBWEBB_TEACHER_SIGNATURE="$DBWEBB_TEACHER_SIGNATURE"
 DBWEBB_TO_CLIPBOARD="$DBWEBB_TO_CLIPBOARD"

These are default settings for opening the browser.
 windows (cygwin): export BROWSER="/cygdrive/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"
 macOs:            export BROWSER="open /Applications/Firefox.app"
 linux:            export BROWSER="firefox"

These are the default settings for using the clipboard when the feedback text is available through ctrl-v/cmd-v.
 windows (cygwin): export TO_CLIPBOARD="cat - > /dev/clipboard"
 macOs:            export TO_CLIPBOARD="iconv -t macroman | pbcopy"
 linux:            export TO_CLIPBOARD="xclip -selection c"

/Mikael
EOD

    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --msgbox "$message" \
        24 80 \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
gui-main-menu()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --default-item "$mainMenuSelected" \
        --menu "Main menu" \
        24 80 \
        20 \
        "1" "Inspect kmom (download, docker)" \
        "2" "Inspect kmom (docker)" \
        "5" "Inspect kmom (download, local)" \
        "6" "Inspect kmom (local)" \
        "7" "Inspect tentamen (rsync, docker)" \
        "8" "Inspect tentamen (docker)" \
        "" "---" \
        "c" "Course menu" \
        "a" "Admin menu" \
        "q" "Quit" \
        3>&1 1>&2 2>&3 3>&-

        # "3" "Inspect kmom (download, no-docker)" \
        # "4" "Inspect kmom (no-docker)" \

        # TODO Clean upp this and remove from script
        #"" "---" \
        #"d" "Download student me/" \
        #"w" "Open student me/redovisa in browser" \
        #"p" "Potatoe student" \
        #"o" "Docker menu" \
}



#
#
#
gui-admin-menu()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --menu "Main » Admin menu" \
        24 80 \
        20 \
        "c" "Create a default configuration file ~/.dbwebb/gui_config.bash" \
        "e" "Show and edit the user configuration file ~/.dbwebb/gui_config.bash" \
        "s" "Show configuration settings" \
        "r" "View README" \
        "b" "Back" \
        3>&1 1>&2 2>&3 3>&-
}



# ----------------------------- stuff relates to database exam
#
#
#
gui-show-receipt()
{
    local acronym="$1"

    dialog \
        --backtitle "$BACKTITLE" \
        --title "Receipt for $acronym" \
        --msgbox "$( get-receipt $acronym )" \
        40 80 \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
get-receipt()
{
    local acronym="$1"
    local message=

    message=$(< "$TENTAMEN_DIR/$acronym/RECEIPT.md" )
    echo "$TENTAMEN_DIR/$acronym/RECEIPT.md"

    [[ -z $message ]] && message="No RECEIPT.md found for $acronym"

    echo "$message"
}



#
#
#
gui-read-seal-version()
{
    local acronym="$1"
    local path=

    select=$( cd "$TENTAMEN_DIR" && find "$acronym" -maxdepth 1 -mindepth 1 -type d | tail -1 )
    path="$TENTAMEN_DIR/$select"

    dialog \
        --backtitle "$BACKTITLE" \
        --title "Select sealed version ($acronym)" \
        --dselect "$path" \
        24 80 \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
printReceipt()
{
    local acronym="$1"

    header "Receipt" | tee -a "$LOGFILE"
    printf "\n%s\n\n" "$( get-receipt $acronym )" | tee -a "$LOGFILE"
}



#
# Make a validate using docker.
#
makeValidateDocker()
{
    local target="$1"

    header "dbwebb validate" "Do dbwebb validate in the background and write output to logfile." | tee -a "$LOGFILE"
    #header "dbwebb inspect" | tee -a "$LOGFILE"

    if [[ ! -z $DBWEBB_INSPECT_PID ]]; then
        # echo "Killing $DBWEBB_INSPECT_PID" | tee "$LOGFILE_INSPECT"
        kill -9 $DBWEBB_INSPECT_PID > /dev/null 2>&1
        DBWEBB_INSPECT_PID=
    fi

    if [ $OS_TERMINAL == "linux" ]; then
        setsid make docker-run what="make validate what=$target" > "$LOGFILE_INSPECT" 2>&1 &
        DBWEBB_INSPECT_PID="$!"
    else
        make docker-run what="make validate what=$target" > "$LOGFILE_INSPECT" 2>&1 &
        DBWEBB_INSPECT_PID="$!"
    fi

    # (cd "$COURSE_DIR" && make docker-run what="make validate what=$target" > "$LOGFILE_INSPECT" 2>&1 &)
    #(cd "$COURSE_DIR" && make docker-run what="make validate what=$target/" 2>&1  | tee -a "$LOGFILE")
}



# ----------------------------- END OF DATABASE EXAM

# #
# #
# #
# gui-database-menu()
# {
#     dialog \
#         --backtitle "$BACKTITLE" \
#         --title "$TITLE" \
#         --menu "Main » Database menu" \
#         24 80 \
#         20 \
#         "u" "Create users dbwebb:password and user:pass into docker mysql" \
#         "l" "Load standard kmom database dump into docker mysql" \
#         "1" "Load student skolan/reset_part1.bash into docker mysql" \
#         "2" "Load student skolan/reset_part2.bash into docker mysql" \
#         "3" "Load student skolan/reset_part3.bash into docker mysql" \
#         "4" "Load student skolan/skolan.sql into docker mysql" \
#         "b" "Back" \
#         3>&1 1>&2 2>&3 3>&-
# }



# #
# #
# #
# gui-docker-menu()
# {
#     dialog \
#         --backtitle "$BACKTITLE" \
#         --title "$TITLE" \
#         --menu "Main » Docker menu" \
#         24 80 \
#         20 \
#         "u" "Docker up -d [$dockerContainer]" \
#         "r" "Docker run [$dockerContainer] bash" \
#         "s" "Docker start [$dockerContainer]" \
#         "t" "Docker stop" \
#         "b" "Back" \
#         3>&1 1>&2 2>&3 3>&-
# }



#
#
#
gui-read-kmom()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --default-item "$kmom" \
        --menu "Select kmom" \
        24 80 \
        20 \
        "kmom01" "kmom01" \
        "kmom02" "kmom02" \
        "kmom03" "kmom03" \
        "kmom04" "kmom04" \
        "kmom05" "kmom05" \
        "kmom06" "kmom06" \
        "kmom10" "kmom10" \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
gui-read-acronym()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --inputbox "Select student acronym (ctrl-u to clear)" \
        24 80 \
        "$1" \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
gui-read-docker-container()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --inputbox "Select docker container" \
        24 80 \
        "$1" \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
main-admin-menu()
{
    local output

    while true; do
        output=$( gui-admin-menu )
        case $output in
            c)
                createConfigFile
                pressEnterToContinue
                ;;
            e)
                showAndEditConfigFile
                pressEnterToContinue
                ;;
            s)
                gui-show-configuration
                ;;
            r)
                gui-firstpage
                ;;
            b|"")
                return
                ;;
        esac
    done
}



#
#
#
gui-course-menu()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --menu "Main » Course menu" \
        24 80 \
        20 \
        "d" "databas" \
        "b" "Back" \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
main-course-menu()
{
    local output

    while true; do
        output=$( gui-course-menu )
        case $output in
            d)
                main-course-databas-menu
                ;;
            b|"")
                return
                ;;
        esac
    done
}



#
#
#
gui-course-databas-menu()
{
    dialog \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --menu "Main » Course » 'databas' menu" \
        24 80 \
        20 \
        "u" "Create users dbwebb:pass and user:pass into docker mysql" \
        "l" "Load standard kmom database dump into docker mysql" \
        "1" "Load student skolan/reset_part1.bash into docker mysql" \
        "2" "Load student skolan/reset_part2.bash into docker mysql" \
        "3" "Load student skolan/reset_part3.bash into docker mysql" \
        "4" "Load student skolan/skolan.sql into docker mysql" \
        "b" "Back" \
        3>&1 1>&2 2>&3 3>&-
}



#
#
#
main-course-databas-menu()
{
    local output
    local path

    while true; do
        output=$( gui-course-databas-menu )
        case $output in
            u)
                runSqlScript "example/sql/create-user-dbwebb.sql"
                runSqlScript "example/sql/create-user-user.sql" "dbwebb"
                runSqlScript "example/sql/check-env.sql" "dbwebb"
                pressEnterToContinue
                ;;
            l)
                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                for file in $INSPECT_SOURCE_DIR/kmom.d/$kmom/dump_*.sql; do
                    runSqlScript "$file" "dbwebb"
                done
                pressEnterToContinue
                ;;
            1)
                runSqlScript "example/sql/inspect/setup_skolan.sql" "dbwebb"
                make docker-run what="bash me/skolan/reset_part1.bash"
                pressEnterToContinue
                ;;
            2)
                runSqlScript "example/sql/inspect/setup_skolan.sql" "dbwebb"
                make docker-run what="bash me/skolan/reset_part2.bash"
                pressEnterToContinue
                ;;
            3)
                runSqlScript "example/sql/inspect/setup_skolan.sql" "dbwebb"
                make docker-run what="bash me/skolan/reset_part3.bash"
                pressEnterToContinue
                ;;
            4)
                path="me/skolan/skolan.sql"
                if [[ -f "$path" ]]; then
                    runSqlScript "example/sql/inspect/setup_skolan.sql" "dbwebb"
                    runSqlScript "$path" "dbwebb" "" "skolan"
                else
                    printf "The file '%s' does not exists.\n" "$path"
                fi
                pressEnterToContinue
                ;;
            b|"")
                return
                ;;
        esac
    done
}



#
# Drop and create the databases
#
# Arg 1: The file[.sql] to load
# Arg 2: Optional username
# Arg 3: Optional password
# Arg 4: Optional database
#
runSqlScript()
{
    local sql="$1"
    local user=${2:-root}
    local password=${3:-}
    local host="-hmysql"
    local database=${4:-}
    local container="mysql"

    if [[ ! -z $password ]]; then
        password="-p$password"
    fi

    if [[ ! -f "$sql" ]]; then
        printf "%s: The SQL file '%s' does not exists.\n" "${FUNCNAME[0]}" "$sql"
        exit 1
    fi

    printf "%s\n" "$sql"
    cat "$sql" \
        | make docker-run container="$container" what="mysql --table $host -u$user $password $database"
}



# #
# #
# #
# main-docker-menu()
# {
#     local output
#
#     while true; do
#         output=$( gui-docker-menu )
#         case $output in
#             u)
#                 dockerContainer=$( gui-read-docker-container "$dockerContainer" )
#                 make docker-up container="$dockerContainer"
#                 pressEnterToContinue
#                 ;;
#             r)
#                 dockerContainer=$( gui-read-docker-container "$dockerContainer" )
#                 make docker-run container="$dockerContainer" what="bash"
#                 pressEnterToContinue
#                 ;;
#             s)
#                 dockerContainer=$( gui-read-docker-container "$dockerContainer" )
#                 make docker-start container="$dockerContainer"
#                 pressEnterToContinue
#                 ;;
#             t)
#                 make docker-stop
#                 pressEnterToContinue
#                 ;;
#             b|"")
#                 return
#                 ;;
#         esac
#     done
# }



#
# Write a header with descriptive text.
#
header()
{
    printf "\n\033[0;30;42m>>> ======= %-25s =======\033[0m\n" "$1"

    if [[ $2 ]]; then
        printf "%s\n" "$2"
    fi
}



#
# Echo feedback text  to log and add to clipboard
#
initLogfile()
{
    local acronym="$1"
    local what="$2"

    header "GUI Inspect" | tee "$LOGFILE"

    printf "%s\n%s %s %s\n%s\nInspect GUI %s (%s)\n" "$( date )" "$COURSE" "$kmom" "$acronym" "$what" "$VERSION" "$OS_TERMINAL" | tee -a "$LOGFILE"
}



#
# Echo feedback text to log and add to clipboard
#
feedback()
{
    local baseDir="$INSPECT_SOURCE_DIR/text"
    local kmom="$1"
    local output

    header "Feedback" > "$LOGFILE_TEXT"
    output=$( eval echo "\"$( cat "$baseDir/$kmom.txt" )"\" )
    #output=$(< "$DIR/text/$kmom.txt" )
    printf "\n%s\n\n" "$output" >> "$LOGFILE_TEXT"
    printf "%s" "$output" | eval "$TO_CLIPBOARD"

    if [[ -f "$baseDir/${kmom}_extra.txt" ]]; then
        output=$(< "$baseDir/${kmom}_extra.txt" )
        printf "\n\033[32;01m---> Vanliga feedbacksvar\033[0m\n\n%s\n\n" "$output" >> "$LOGFILE_TEXT"
    fi

    if [[ -f "$baseDir/all.txt" ]]; then
        output=$(< "$baseDir/all.txt" )
        printf "\n\033[32;01m---> Bra att ha\033[0m\n\n%s\n\n" "$output" >> "$LOGFILE_TEXT"
    fi
}



#
# Download onlys parts of the student files
#
downloadParts()
{
    export ACRONYM="$1"
    local file="$2"

    while read -r part;
    do
       printf "$part...";
       dbwebb --force --yes --silent download "$part" "$ACRONYM" > /dev/null
       if (( $? )); then
           return 1
       fi
   done < "$file"
}



#
# Download student files and do potatoe if needed
#
downloadPotato()
{
    export KMOM="$1"
    export ACRONYM="$2"
    local path1="$INSPECT_SOURCE_DIR/kmom.d/download_parts.bash"
    local path2="$INSPECT_SOURCE_DIR/kmom.d/$KMOM/download_parts.bash"

    header "Download (and potato)" "" | tee -a "$LOGFILE"

    if [[ -f "$path1" || -f "$path2" ]]; then
        local res1=0
        local res2=0

        if [[ -f "$path1" ]]; then
            downloadParts "$ACRONYM" "$path1"
            res1=$?
        fi

        if [[ -f "$path2" ]]; then
            downloadParts "$ACRONYM" "$path2"
            res2=$?
        fi

        printf "\n";

        if (( $res1 + $res2 == 0 )); then
            return
        fi
    fi

    printf "me..."
    if ! dbwebb --force --yes download me $ACRONYM > /dev/null; then
        printf "\n\033[32;01m---> Doing a Potato\033[0m\n\033[0;30;43mACTION NEEDED...\033[0m\n" | tee -a "$LOGFILE"
        potatoe $ACRONYM
        if ! dbwebb --force --yes --silent download me $ACRONYM; then
            printf "\n\033[0;30;41mFAILED!\033[0m Doing a full potatoe, as a last resort...\n" | tee -a "$LOGFILE"
            potatoe $ACRONYM "false"
            if ! dbwebb --force --yes --silent download me $ACRONYM; then
                printf "\n\033[0;30;41mFAILED!\033[0m Doing a full potatoe, as a last resort...\n" | tee -a "$LOGFILE"
                exit 1
            fi
        fi
    fi
}



#
# Open redovisa in browser.
#
openRedovisaInBrowser()
{
    local acronym="$1"

    #printf "$REDOVISA_HTTP_PREFIX/~$acronym/dbwebb-kurser/$COURSE/$REDOVISA_HTTP_POSTFIX\n" 2>&1 | tee -a "$LOGFILE"

    #eval "$BROWSER" "$REDOVISA_HTTP_PREFIX/~$acronym/dbwebb-kurser/$COURSE/$REDOVISA_HTTP_POSTFIX" &
}



#
# Make a local inspect.
#
makeInspectLocal()
{
    local kmom="$1"

    #header "dbwebb inspect" "Do dbwebb inspect in the background and write output to logfile '$LOGFILE_INSPECT'." | tee -a "$LOGFILE"
    header "dbwebb inspect" | tee -a "$LOGFILE"

    #(make inspect options="--yes" what="$kmom" 2>&1 > "$LOGFILE_INSPECT" &)
    make inspect options="--yes" what="$kmom" 2>&1 | tee -a "$LOGFILE"
}



#
# Make a inspect using docker.
#
makeInspectDocker()
{
    local kmom="$1"

    [[ $NO_DBWEBB_INSPECT ]] && return

    header "dbwebb inspect" "Do dbwebb inspect in the background, using docker, and write output to logfile." | tee -a "$LOGFILE"
    # header "dbwebb inspect" "Do dbwebb inspect in the background and write output to logfile '$LOGFILE_INSPECT'." | tee -a "$LOGFILE"
    #header "dbwebb inspect" | tee -a "$LOGFILE"

    if [[ ! -z $DBWEBB_INSPECT_PID ]]; then
        # echo "Killing $DBWEBB_INSPECT_PID" | tee "$LOGFILE_INSPECT"
        kill -9 $DBWEBB_INSPECT_PID > /dev/null 2>&1
        DBWEBB_INSPECT_PID=
    fi

    if [ $OS_TERMINAL == "linux" ]; then
        #setsid make docker-run what="make inspect what=$kmom options='--yes'" > "$LOGFILE_INSPECT" 2>&1 &
        setsid docker-compose run --rm cli make inspect what=$kmom options='--yes' > "$LOGFILE_INSPECT" 2>&1 &
        DBWEBB_INSPECT_PID="$!"
    else
        #make docker-run what="make inspect what=$kmom options='--yes'" > "$LOGFILE_INSPECT" 2>&1 &
        docker-compose run --rm cli make inspect what=$kmom options='--yes' > "$LOGFILE_INSPECT" 2>&1 &
        DBWEBB_INSPECT_PID="$!"
    fi

    #make docker-run what="make inspect what=$kmom options='--yes'" 2>&1  | tee -a "$LOGFILE"
}



#
# Run extra testscripts using docker.
#
makeDockerRunExtras()
{
    local kmom="$1"
    local acronym="$2"
    local path="$INSPECT_SOURCE_DIR/kmom.d/run.bash"
    local script

    # Move to root to execute make
    cd "$DBW_COURSE_DIR" || exit

    # realpath not available on mac ventura (odd version) nor brew
    #script="$( realpath --relative-to="${PWD}" "$path" )"
    script=${path#"$PWD"}
    script=${script#"/"}

    # # Run the scripts using run.bash through make
    # header "Docker run ($kmom)" | tee -a "$LOGFILE"
    # echo 'make docker-run-server container="server" what="bash $script $kmom $acronym"' | tee -a "$LOGFILE"
    # make docker-run-server container="server" what="bash $script $kmom $acronym" 2>&1 | tee -a "$LOGFILE"

    header "Docker run scripts" | tee -a "$LOGFILE"

    # Only if there are scripts to execute for kmom
    local kmomScripts="$( dirname "$path" )/$kmom"
    if [[ ! -d "$kmomScripts" || -z "$(ls -A $kmomScripts)" ]]; then
       echo "No scripts to execute in docker for '$kmom'." | tee -a "$LOGFILE"
    else
        # Run the scripts using run.bash through docker-compose
        echo "docker-compose -f docker-compose.yaml run --rm --service-ports server bash $script $kmom $acronym $LOG_DOCKER_REL" | tee -a "$LOGFILE"
        docker-compose -f docker-compose.yaml run -it --rm --service-ports server bash $script $kmom $acronym $LOG_DOCKER_REL 2>&1 | tee -a "$LOGFILE"
    fi
}



#
# Run extra testscripts without using docker.
#
makeNoDockerRunExtras()
{
    local kmom="$1"
    local acronym="$2"
    local path="$INSPECT_SOURCE_DIR/kmom.d/run.bash"
    local script

    # Move to root to execute make
    cd "$DBW_COURSE_DIR" || exit

    # realpath not available on mac ventura (odd version) nor brew
    #script="$( realpath --relative-to="${PWD}" "$path" )"
    script=${path#"$PWD"}
    script=${script#"/"}

    # # Run the scripts using run.bash through make
    # header "Docker run ($kmom)" | tee -a "$LOGFILE"
    # echo 'make docker-run-server container="server" what="bash $script $kmom $acronym"' | tee -a "$LOGFILE"
    # make docker-run-server container="server" what="bash $script $kmom $acronym" 2>&1 | tee -a "$LOGFILE"

    header "No-Docker run scripts" | tee -a "$LOGFILE"

    # Only if there are scripts to execute for kmom
    local kmomScripts="$( dirname "$path" )/$kmom"
    if [[ ! -d "$kmomScripts" || -z "$(ls -A $kmomScripts)" ]]; then
       echo "No scripts to execute in docker for '$kmom'." | tee -a "$LOGFILE"
    else
        # Run the scripts using run.bash
        echo "bash $script $kmom $acronym $LOG_DOCKER_REL" | tee -a "$LOGFILE"
        bash $script $kmom $acronym $LOG_DOCKER_REL 2>&1 | tee -a "$LOGFILE"
    fi
}



#
# Run extra testscripts that are executed before download.
#
runPreDownload()
{
    export KMOM="$1"
    export ACRONYM="$2"
    local path1="$INSPECT_SOURCE_DIR/kmom.d/pre_download.bash"
    local path2="$INSPECT_SOURCE_DIR/kmom.d/$KMOM/pre_download.bash"

    header "Pre download $KMOM" | tee -a "$LOGFILE"

    if [[ -f "$path1" ]]; then
        # shellcheck source=.dbwebb/script/inspect/kmom.d/pre_download.bash
        source "$path1" 2>&1 | tee -a "$LOGFILE"
    fi

    if [[ -f "$path2" ]]; then
        # shellcheck source=.dbwebb/script/inspect/kmom.d/$KMOM/pre_download.bash
        source "$path2" 2>&1 | tee -a "$LOGFILE"
    fi
}



#
# Run extra testscripts that are executed before docker.
#
runPreExtras()
{
    export KMOM="$1"
    export ACRONYM="$2"
    local path1="$INSPECT_SOURCE_DIR/kmom.d/pre.bash"
    local path2="$INSPECT_SOURCE_DIR/kmom.d/$KMOM/pre.bash"

    header "Pre $KMOM" | tee -a "$LOGFILE"

    if [[ -f "$path1" ]]; then
        # shellcheck source=.dbwebb/script/inspect/kmom.d/pre.bash
        source "$path1" 2>&1 | tee -a "$LOGFILE"
    fi

    if [[ -f "$path2" ]]; then
        # shellcheck source=.dbwebb/script/inspect/kmom.d/$KMOM/pre.bash
        source "$path2" 2>&1 | tee -a "$LOGFILE"
    fi
}



#
# Run extra testscripts that are executed after docker.
#
runPostExtras()
{
    export KMOM="$1"
    export ACRONYM="$2"
    local path1="$INSPECT_SOURCE_DIR/kmom.d/post.bash"
    local path2="$INSPECT_SOURCE_DIR/kmom.d/$KMOM/post.bash"
    local output=
    local url=
    local baseDir="$INSPECT_SOURCE_DIR/text"

    header "Post $KMOM" | tee -a "$LOGFILE"

    if [[ -f "$path1" ]]; then
        # shellcheck source=.dbwebb/script/inspect/kmom.d/pre.bash
        source "$path1" 2>&1 | tee -a "$LOGFILE"
    fi

    if [[ -f "$path2" ]]; then
        # shellcheck source=.dbwebb/script/inspect/kmom.d/$KMOM/pre.bash
        source "$path2" 2>&1 | tee -a "$LOGFILE"
    fi

    url=$( publishLogFileToServer )

    feedback=$( eval echo "\"$( cat "$baseDir/$KMOM.txt" )"\" )
    [[ -f "$LOG_DOCKER" ]] && docker=$( eval echo "\"$( cat "$LOG_DOCKER" )"\" )
    if [[ -f "$LOG_DOCKER" ]]; then
        printf "%s\n\n-- Log --\n%s" "$feedback" "$docker" | eval $TO_CLIPBOARD
    else
        printf "%s\n%s" "$feedback" "$docker" | eval $TO_CLIPBOARD
    fi
}



#
# Publish the logfile to external server.
#
publishLogFileToServer()
{
    local server="ssh.student.bth.se"

    # header "Post $KMOM" | tee -a "$LOGFILE"
    #
    # if [[ -f "$path1" ]]; then
    #     # shellcheck source=.dbwebb/script/inspect/kmom.d/pre.bash
    #     source "$path1" 2>&1 | tee -a "$LOGFILE"
    # fi
    #
    # if [[ -f "$path2" ]]; then
    #     # shellcheck source=.dbwebb/script/inspect/kmom.d/$KMOM/pre.bash
    #     source "$path2" 2>&1 | tee -a "$LOGFILE"
    # fi
    #
    # [[ -f "$LOG_DOCKER_ABS" ]] && output=$( eval echo "\"$( cat "$LOG_DOCKER_ABS" )"\" )
    # #printf "\n%s\n\n" "$output" >> "$LOGFILE_TEXT"
    # printf "%s" "$output" | eval $TO_CLIPBOARD
}



#
# Main function
#
main()
{
    local acronym=

    gui-firstpage
    while true; do
        mainMenuSelected=$( gui-main-menu )
        case $mainMenuSelected in
            a)
                main-admin-menu
                ;;
            c)
                main-course-menu
                ;;
            # o)
            #     main-docker-menu
            #     ;;
            6)
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                initLogfile "$acronym" "local"
                # openRedovisaInBrowser "$acronym"
                feedback "$kmom"
                runPreExtras "$kmom" "$acronym"
                makeInspectLocal "$kmom"
                runPostExtras "$kmom" "$acronym"
                pressEnterToContinue
                ;;
            5)
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                initLogfile "$acronym" "download, local"
                # openRedovisaInBrowser "$acronym"
                feedback "$kmom"
                if ! downloadPotato "$acronym"; then
                    pressEnterToContinue;
                    continue
                fi
                runPreExtras "$kmom" "$acronym"
                makeInspectLocal "$kmom"
                runPostExtras "$kmom" "$acronym"
                pressEnterToContinue
                ;;
            2)
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                initLogfile "$acronym" "docker"
                # openRedovisaInBrowser "$acronym"
                feedback "$kmom"
                runPreExtras "$kmom" "$acronym"
                makeInspectDocker "$kmom"
                makeDockerRunExtras "$kmom" "$acronym"
                runPostExtras "$kmom" "$acronym"
                pressEnterToContinue
                ;;
            1)
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                initLogfile "$acronym" "download, docker"
                # openRedovisaInBrowser "$acronym"
                feedback "$kmom"
                runPreDownload "$kmom" "$acronym"
                if ! downloadPotato "$kmom" "$acronym"; then
                    pressEnterToContinue;
                    continue
                fi
                runPreExtras "$kmom" "$acronym"
                makeInspectDocker "$kmom"
                makeDockerRunExtras "$kmom" "$acronym"
                runPostExtras "$kmom" "$acronym"
                pressEnterToContinue
                ;;
            4)
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                initLogfile "$acronym" "docker"
                # openRedovisaInBrowser "$acronym"
                feedback "$kmom"
                runPreExtras "$kmom" "$acronym"
                makeInspectDocker "$kmom"
                makeNoDockerRunExtras "$kmom" "$acronym"
                runPostExtras "$kmom" "$acronym"
                pressEnterToContinue
                ;;
            3)
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                kmom=$( gui-read-kmom $kmom )
                [[ -z $kmom ]] && continue

                initLogfile "$acronym" "download, docker"
                # openRedovisaInBrowser "$acronym"
                feedback "$kmom"
                if ! downloadPotato "$acronym"; then
                    pressEnterToContinue;
                    continue
                fi
                runPreExtras "$kmom" "$acronym"
                makeInspectDocker "$kmom"
                makeNoDockerRunExtras "$kmom" "$acronym"
                runPostExtras "$kmom" "$acronym"
                pressEnterToContinue
                ;;
            7)
                #[[ -z $acronym ]] && acronym="abtl18"
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                gui-show-receipt $acronym

                seal=$( gui-read-seal-version $acronym )
                [[ -z $seal ]] && continue

                if [[ -d "$seal" ]]; then
                    printf "\n[$acronym] Using $seal as base directory."
                    rsync -a --delete "$seal/" "$DIR/me/tentamen/"
                else
                    printf "\n$MSG_FAILED Sealed version is not a directory."
                    pressEnterToContinue
                    continue
                fi

                initLogfile "$acronym" "tentamen"
                openRedovisaInBrowser "$acronym"
                printReceipt $acronym
                feedback "tentamen"
                runPreExtras "tentamen" "$acronym"
                #makeValidateDocker "tentamen"
                makeDockerRunExtras "tentamen" "$acronym"
                runPostExtras "tentamen" "$acronym"
                pressEnterToContinue
                ;;
            8)
                #[[ -z $acronym ]] && acronym="abtl18"
                acronym=$( gui-read-acronym $acronym )
                [[ -z $acronym ]] && continue

                initLogfile "$acronym" "tentamen"
                openRedovisaInBrowser "$acronym"
                printReceipt $acronym
                feedback "tentamen"
                runPreExtras "tentamen" "$acronym"
                #makeValidateDocker "tentamen"
                makeDockerRunExtras "tentamen" "$acronym"
                runPostExtras "tentamen" "$acronym"
                pressEnterToContinue
                ;;
            # d)
            #     acronym=$( gui-read-acronym $acronym )
            #     [[ -z $acronym ]] && continue
            #
            #     dbwebb --force --yes download me "$acronym"
            #     pressEnterToContinue
            #     ;;
            # w)
            #     acronym=$( gui-read-acronym $acronym )
            #     [[ -z $acronym ]] && continue
            #
            #     # openRedovisaInBrowser "$acronym"
            #     pressEnterToContinue
            #     ;;
            # p)
            #     potatoe $acronym
            #     pressEnterToContinue
            #     ;;
            q)
                exit 0
                ;;
        esac
    done
}



#
# Show helptext to exaplin usage of command
#
show_help()
{
    local txt=(
"Work with gui inspect."
"Usage: gui.bash [command]"
""
"Command:"
"  config         Maintain the user configuration file."
"  help           Print this help and usage message."
"  version        Print the current version."
    )
    printf "%s\n" "${txt[@]}"
}



# ----------------------------- Main loop
#
# Check options and then run main function
#
if (( $# > 0 )); then
    case "$1" in
        config)
            main-admin-menu;
            exit 0;
        ;;
        help)
            show_help;
            exit 0;
        ;;
        version)
            echo "$VERSION";
            exit 0;
        ;;
        *)
            die "Option/command not recognized.\nUse '$0 help' to get usage." 2
        ;;
    esac
fi
main
