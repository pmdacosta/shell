#!/bin/bash
# headlines.sh
#
# Prints headlines from the br-linux website
#

# we'll skip this step
# lynx --dump -nolist https://br-linux.org/ > brlinux.txt

grep --text '^[A-Z]' brlinux.txt | sed '1,/^Destaques de hoje/ d' | head -n 5
