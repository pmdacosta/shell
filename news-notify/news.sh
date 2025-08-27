#!/bin/bash
#
# news.sh
#
# Grabs the latest news headline from https://directory.sloop.nz/world-news/ 
# and displays it as a notification
#
# v0.1: Simple grab and dump, filter with grep and sed
#
# Pedro, August 2025
#

# news="$(cat page.html)"
news=$(lynx --dump "https://directory.sloop.nz/world-news/")

# grep -A 5 -e "\[5\]"      grabs the first 5 lines after matching [5]
# sed '/^$/q'               quits when matches an empty line
# sed 's/^\[[0-9]\+\]//'    removes the [5] from the begging of the line
news=$(echo "$news" | grep -A 5 -e "\[5\]" | sed '/^$/q' | sed 's/^\[[0-9]\+\]//')
notify-send "$news"
