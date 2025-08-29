#!/bin/bash
# feed.sh
#
# Grab headlines from an RSS feed
# Pass the URL as the first argument
#
# Pedro, August 2025
#

lynx -source "$1" |
    grep '<title>' |
    tr -d \\t |
    sed '
        s/ *<[^>]*>//g
        s/&quot;/"/g;
        1d'
