#!/bin/bash
# scream.sh
# Based on Aurelio Vargas's grita.sh from the Shell Script Profissional Book
# Adapted to english
#
# Shows a word ($TXT) in uppercase and with exclamation marks
# Example: foo -> !!!!!FOO!!!!!
#

DEBUG=1

debug() {
    [ "$DEBUG" = 1 ] && echo -e "{DEBUG}: $*"
}

TXT="scream"
TXT="     $TXT     "            # Adds 5 spaces around

debug "TXT with whitespaces   : [$TXT]"
TXT=$(echo $TXT | tr ' ' '!')   # Switch spaces for exclamation marks
debug "TXT with exclamation   : [$TXT]"

TXT=$(echo $TXT | tr a-z A-Z)   # Change text to uppercase
echo "$TXT"

