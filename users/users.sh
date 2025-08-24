#!/bin/bash
# users.sh
# Based on Aurelio Vargas's usuarios.sh from the Shell Script Profissional Book
# Adapted to english
#
# Shows the usernames and their full name on the system
# Obs.: Reads from /etc
#
# v1: Show system username and full names separated by TAB
# v2: Add support for -h option
# v3: Add support for -V option and invalid option
#
# Pedro, August 2025
#

VERSION=2
USAGE_MSG="Usage: $0 [-h | -V]"
HELP_MSG="$USAGE_MSG

  -h      Shows help message
  -V      Show version
"

# Process command line options
case "$1" in
    -h)
        echo "$HELP_MSG"
        exit 0
        ;;
    -V)
        echo "$0 version $VERSION"
        exit 0
        ;;
    *)
        echo "$0: Invalid option: $1
Try '$0 -h' for more information."
        exit 1
        ;;
esac

# Process
cut -d : -f1,5 /etc/passwd | tr : \\t

