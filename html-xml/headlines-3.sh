#!/bin/bash
# headlines-3.sh
#
# Prints headlines from the br-linux website RSS feed
#
# Pedro, August 2025

URL="https://br-linux.org/feed"

# The pattern to match are the headlines surrounded by <title>
# sed removes the tags, restores the quotes and deletes the spaces at the begging of the line
# head limits the numbers of headlines to 5
# lynx -source "$URL" |
#     grep '<title>' 

lynx -source "$URL" |
    grep '<title>' |
    sed '
    1d
    s/<[^\[]*\[CDATA\[// 
    s/\].*$// 
    s/&quot;/"/g 
    s/^\t*//' |
    head -n5
