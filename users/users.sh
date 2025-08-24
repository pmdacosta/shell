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
#
# Pedro, August 2025
#

VERSION=2
HELP_MSG="Usage: $0 [-h|-V]

    -h      Shows help message
    -V      Show version
"

# Process command line options
if test "$1" = "-h"
then
    echo "$HELP_MSG"
    exit 0
fi

# Process
cut -d : -f1,5 /etc/passwd | tr : \\t

