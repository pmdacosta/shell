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
# v6: Add support for -r, --reverse, -u, --uppercase options,
#     and support reading multiple options. Renamed sort to
#     sorted to avoid conflict with the sort program.
#
# Pedro, August 2025
#

BASENAME="$(basename $0)"
USAGE_MSG="Usage: $BASENAME [OPTIONS]"
HELP_MSG="$USAGE_MSG

  -h, --help        Shows help message
  -r, --reverse     Show in reverse order
  -s, --sort        Sort list
  -u, --uppercase   Show list in uppercase
  -V, --version     Show version
"
INVALID_OPTION_MSG="$0: Invalid option: $1
Try '$0 -h' for more information."

# FLAGS
sorted=0      # sort output?
revert=0      # revert output order?
uppercase=0   # print uppercase output?

# Process command line options
while test -n "$1"
do
    case "$1" in
        # check options
        -r | --reverse) revert=1 ;;
        -s | --sort) sorted=1 ;;
        -u | --uppercase) uppercase=1 ;;
        -h | --help)
            echo "$HELP_MSG"
            exit 0
            ;;
        -V | --version)
            # Grabs the latest version from the header. xargs will trim the whitespace
            VERSION=$(grep '^# v' "$0" | tail -1 | cut -d : -f 1 | tr -d \# | xargs)
            echo "$BASENAME $VERSION"
            exit 0
            ;;
        *)
            # -n option tests if the length of the string is non zero
            echo "$INVALID_OPTION_MSG"
            exit 1
            ;;
    esac

    # shift command line arguments $2 -> $1
    shift
done

# Extract listing
list=$(cut -d : -f1,5 /etc/passwd)

# Process enabled options
test "$sorted" = 1 && list=$(echo "$list" | sort)           # sort
test "$revert" = 1 && list=$(echo "$list" | tac)            # reverse order
test "$uppercase" = 1 && list=$(echo "$list" | tr a-z A-Z)  # convert to uppercase

# Print result
echo "$list" | tr : \\t

