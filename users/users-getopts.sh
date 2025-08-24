#!/bin/bash
# users-getopts.sh
# Based on Aurelio Vargas's usuarios.sh from the Shell Script Profissional Book
# Adapted to english
# getopts version
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
# v7: Add support for -d, --delimiter options
# v7g: Modified v7 to use getopts
#
# Pedro, August 2025
#

BASENAME="$(basename $0)"
USAGE_MSG="Usage: $BASENAME [OPTIONS]"
HELP_MSG="$USAGE_MSG

  -d C     Change default delimiter to C
  -h       Shows help message
  -r       Show in reverse order
  -s       Sort list
  -u       Show list in uppercase
  -V       Show version
"

# FLAGS
sorted=0      # sort output?
revert=0      # revert output order?
uppercase=0   # print uppercase output?
delim='\t'    # delimiter character
# Process command line options
while getopts ":hVd:rsu" opt
do
    case "$opt" in
        # check options
        r) revert=1 ;;
        s) sorted=1 ;;
        u) uppercase=1 ;;
        d) delim="$OPTARG" ;;
        h)
            echo "$HELP_MSG"
            exit 0
            ;;
        V)
            # Grabs the latest version from the header. xargs will trim the whitespace
            VERSION=$(grep '^# v' "$0" | tail -1 | cut -d : -f 1 | tr -d \# | xargs)
                echo "$BASENAME $VERSION"
            exit 0
            ;;
        \?)
            # -n option tests if the length of the string is non zero
            INVALID_OPTION_MSG="$0: Invalid option: $OPTARG
Try '$0 -h' for more information."
            echo "$INVALID_OPTION_MSG"
            exit 1
            ;;
        :)
            echo "Missing argument for option: -$OPTARG"
            exit 1
            ;;
    esac
done

# Extract listing
list=$(cut -d : -f1,5 /etc/passwd)

# Process enabled options
test "$sorted" = 1 && list=$(echo "$list" | sort)           # sort
test "$revert" = 1 && list=$(echo "$list" | tac)            # reverse order
test "$uppercase" = 1 && list=$(echo "$list" | tr a-z A-Z)  # convert to uppercase

# Print result
echo "$list" | tr : "$delim"

