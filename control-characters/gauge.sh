#!/bin/bash
# gauge.sh
#
# Progess bar using control-characters
#
#   [
#   10 20 30 40 50 60 70 80 90 100
#   0  5  10 15 20 25 30 35 40 45

# empty bar
echo -n '[.................................................]  0%'

step='#####'

for i in {1..10}; do
    sleep 1
    pos=$(((i-1)*5))            # calculate current position on the bar
    echo -ne '\033[G'           # go to the start of the line
    echo -ne "\033[${pos}C"     # go to the current position
    echo -ne "$step"            # fill a step
    echo -ne '\033[53G'         # go to percentage position
    echo -n  "$((i*10))%"       # show current percentage
done
echo
