#!/bin/bash
# five.sh
#
# Count until five

echo $((0+1))
set -x
trap read DEBUG
echo $((0+2))
echo $((0+3))
trap "" DEBUG
set +x
echo $((0+4))
echo $((0+5))
