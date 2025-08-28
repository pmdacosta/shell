#!/bin/bash
# patterns.sh
#
# Some regex patterns to use with grep
#
# Pedro, August 2025
#

set -v

# ^ matches begging of a line
grep root passwd

grep ^root passwd

# $ matches the end of the line
grep bash$ passwd

# ^$ find empty lines
grep ^$ passwd

# using groups with []. [Cc]arlos will match both carlos or Carlos
grep carlos passwd

grep Carlos passwd

# find both
grep [Cc]arlos passwd

# find lines that start with vowels
grep '^[aeiou]' passwd

# match not in group with [^]. For example match lines not starting with vowels
grep '^[^aeiou]' passwd

# search lines containing numbers
grep '[0-9]' passwd

# search lines where the second character is a vowel. The first character can begging
# anything, for that we use the '.' charcter.
grep '^.[aeiou]' passwd

# use {n} for repetition. match a line containing exactly 27 characters
egrep '^.{27}$' passwd

# we can also search for lines containing between 20 and 40 characters
egrep '^.{20,40}$' passwd

# or we can search containing at least 40 characters
egrep '^.{40,}$' passwd

# match numbers with 3 or more digits
egrep '[0-9]{3,}' passwd

# search for users that start in a vowel and use bash
egrep '^[aeiou].*bash$' passwd

# OR with | (a|b|c) a or b or c
egrep '^(ana|carlos|acs):' passwd


