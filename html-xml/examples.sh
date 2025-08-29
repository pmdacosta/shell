#!/bin/bash
# examples.sh
#
# Examples from the book
#
# Pedro, August 2025
#

set -v
# removing tags from text
text='<p><b><i>bold and italic</i></b></p>'
echo "$text" | sed 's/<[^>]*>//g'

# we need the [^>]* instead of .* because '*' is "greedy"
echo "$text" | sed 's/<.*>//g'

