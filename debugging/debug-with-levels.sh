#!/bin/bash
# debug-with-levels.sh
#
# Example of debug with debug levels
#

DEBUG=${1:-0}       # Grabs debug level from $1, if not passed defaults to 0

debug() {
    # $1 is the level
    # only shows if $1 is less than or equal to the debug level
    [ $1 -le $DEBUG ] && shift && echo "{DEBUG}: $*"
}

debug 1 "Start of the program"

i=0
max=5
echo "Count until $max"

debug 2 "Entering WHILE loop"

while [ $i -ne $max ]; do
    debug 3 "Value of \$i before incrementing: $i"
    let i=$i+1
    debug 3 "Value of \$i after incrementing: $i"

    echo "$i..."
done

debug 2 "left WHILE loop"

echo "Done!"

debug 1 "end of the program"
