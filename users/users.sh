#!/bin/bash
# users.sh
# Based on Aurelio Vargas's usuarios.sh from the Shell Script Profissional Book
# Adapted to english
#
# Shows the usernames and their full name on the system
# Obs.: Reads from /etc/passwd
#
# v1: Show system username and full names separated by TAB.
# v2: Add support for -h option.
# v3: Add support for -V option and invalid option.
# v4: Fix bug when no option is passed, add basename instead
#     of $0 for the program name, -V extracts from header,
#     add options for --help and --version.
# v5: Add support for -s, --sort option.
#
# Pedro, August 2025
#

BASENAME="$(basename $0)"
USAGE_MSG="Usage: $BASENAME [OPTION]"
HELP_MSG="$USAGE_MSG

  -h, --help        Shows help message
  -s, --sort        Sort list
  -V, --version     Show version
"
INVALID_OPTION_MSG="$0: Invalid option: $1
Try '$0 -h' for more information."

# FLAGS
sort=0      # sort output?

# Process command line options
case "$1" in
    -h | --help)
        echo "$HELP_MSG"
        exit 0
        ;;
    -V | --version)
        # Grabs the latest version from the header. xargs will trim the whitespace
        VERSION="$(grep '^# v' "$0" | tail -1 | cut -d : -f 1 | tr -d \# | xargs)"
        echo "$BASENAME $VERSION"
        exit 0
        ;;
    -s | --sort)
        sort=1
        ;;
    *)
        # -n option tests if the length of the string is non zero
        if test -n "$1"
        then
            echo "$INVALID_OPTION_MSG"
            exit 1
        fi 
        ;;
esac

# Extract listing
list=$(cut -d : -f1,5 /etc/passwd)

# Order listing (if enabled)
if test "$sort" = 1
then
    list=$(echo "$list" | sort)
fi

# Print result
echo "$list" | tr : \\t

