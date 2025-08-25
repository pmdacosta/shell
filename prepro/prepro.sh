#!/bin/bash
# prepro.sh
#
# help manage the preprocess rotation
#
# v0.1: basic functionality implemented
#
# Pedro, August 2025 
#

BASENAME=$(basename $0)
FILENAME="names"                            # The name of the file to store the names
HELP_MSG="Usage: $BASENAME [COMMAND] [NAME]

    add <name>      add <name> to the rotation
    remove <name>   remove <name> from the rotation
    clear           clear the list
    list            show the current list
    help            show this message
" 

add_user () {
    if test -f "$FILENAME"
    then
        names=$(cat "$FILENAME")
        names=($names)
        names=("$1" ${names[*]})
    else
        names=("$1")
    fi
    echo ${names[@]} > "$FILENAME"
}

remove_user () {
    if test -f "$FILENAME"
    then
        names=$(cat "$FILENAME")
        names=($names)
    else
        echo "$BASENAME: No file exists."
        exit 1
    fi
    index=-1
    for i in "${!names[@]}"
    do
        if test "${names[i]}" = "$1"
        then
            index=$i
        fi
    done
    if test $index -ne -1
    then
        unset names[$index]
        echo ${names[@]} > "$FILENAME"
    else
        echo "$BASENAME: name $1 not found"
        exit 1
    fi
}

get_next () {
    names=$(cat "$FILENAME")
    names=($names)
    next="${names[0]}"
    echo "$next"
    names=(${names[@]:1})   # remove head
    names+=("$next")      # put first at end of list
    echo ${names[@]} > "$FILENAME"
}

declare -a names

while test -n "$1"
do
    case "$1" in
        add)
            shift

            if test -z "$1"
            then
                echo "$BASENAME: missing name for command add."
                exit 1
            fi
            add_user "$1"
            echo "added user $1"
            
            ;;
        remove)
            shift

            if test -z "$1"
            then
                echo "$BASENAME: missing name for command remove."
                exit 1
            fi
            remove_user "$1"
            echo "removed user $1"
            ;;
        next)
            get_next
            ;;
        clear)
            if test -f "$FILENAME"
            then
                rm "$FILENAME"
            fi
            ;;
        list)
            if test -f "$FILENAME"
            then
                cat "$FILENAME" | tr ' ' '\n'
            fi
            ;;
        help)
            echo "$HELP_MSG"
            exit 0
            ;;
        *) 
            echo "Invalid command: $1"
            echo "Try '$BASENAME help' for more information."
            exit 1
            ;;
    esac
    shift
done

