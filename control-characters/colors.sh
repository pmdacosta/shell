#!/bin/bash
# cores.sh
#
# Shows are the color combinations in bash
#
# Pedro, August 2025
#

for letter in {0..7}; do
    for light in '' ';1'; do
        for background in {0..7}; do
            seq="4$background;3$letter"
            echo -en "\033[$seq${light}m"
            echo -en " $seq${light:-  } "
            echo -en "\033[m"
        done; echo
    done
done
