#!/bin/bash
# messages.sh
#
# Prints messages to show off control sequences
#
# Pedro, August 2025
#

# red text
echo -e '\033[31mIMPORTANT MESSAGE!!!\033[m'

# red text, light color
echo -e '\033[31;1mIMPORTANT MESSAGE!!!\033[m'

# blue blackground, red text, light color
echo -e '\033[44;31;1mIMPORTANT MESSAGE!!!\033[m'

# blue blackground, red text, light color, blinking
echo -e '\033[44;31;1;5mIMPORTANT MESSAGE!!!\033[m'

sleep 2
## Movement

echo -e '\033c\033[HH\033[4;7H.C\033[3DD\033[AA\033[GF\nG\nE\033[7GB'

sleep 5

echo -en '\033c'            # Clears the screen same as ESC[2J
sleep 1
echo -en '\033[HH'          # Puts cursor in the top left and print H
sleep 1
echo -en '\033[4;7H.'       # Put cursor in line 4 col 7 and print .
sleep 1
echo -en 'C'                # Put a C
sleep 1
echo -en '\033[3DD'         # Move 3 positions to the left
sleep 1
echo -en '\033[AA'          # Move 1 position up
sleep 1
echo -en '\033[GF'          # Move the beggining of the line
sleep 1
echo -en '\nG\nE'           # new line -> G -> new line -> E
sleep 1
echo -en '\033[7GB'         # Move 7 positions to the right
sleep 1
echo
