#!/bin/bash
# headlines-2.sh
#
# Prints headlines from the br-linux website
#
# Pedro, August 2025

# The pattern to match are the headlines surrounded by <h1><a> tags
# sed removes the tags, restores the quotes and deletes the spaces at the begging of the line
# head limits the numbers of headlines to 5
grep '<h1><a style' brlinux.html | 
    sed '
        s/<[^>]*>//g
        s/&quot;/"/g
        s/^ *//' |
    head -n5

