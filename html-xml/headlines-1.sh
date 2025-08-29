#!/bin/bash
# headlines-1.sh
#
# Prints headlines from the br-linux website
#

URL="https://br-linux.org/"

# The pattern are the lines that start with uppercase
# Until the line 'Destaques de hoje'

lynx --dump --nolist "$URL" > br-linux.txt
iconv -f latin1 -t utf-8 br-linux.txt > br-linux-latin.txt

grep '^[A-Z]' br-linux-latin.txt   |
    sed '1,/^O BR-Linux/ d' |
    head -n 5



