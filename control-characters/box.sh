#!/bin/bash
# box.sh
#
# Draws a box around text from STDIN
#

# Config
box_width=60
box_col_start=5
box_line_start=5
text_max_lines=20
border_distance=1
box_color='33;1'
text_color='32'
#box_color='33;43'

#------------------------------------------------------------

### Dynamic config
box_col_end=$((box_col_start + box_width - 1))
text_col_start=$((box_col_start + border_distance + 1))
text_width=$((box_width - border_distance))
text=$(fmt -sw $text_width)
num_lines=$(echo "$text" | wc -l)
total_lines=$((num_lines+2))

### Check text size
if [ $num_lines -gt $text_max_lines ]; then
    echo "Text is too big, won't find in the box"
    exit 1
fi

### Build box horizontal line
# we do $box_width-2 because the corners will use '+'
for i in $(seq $((box_width-2))); do
    box_line="$box_line-"
done

### Clear screen
echo -ne '\033c'

### Draw box
echo -ne "\033[$box_line_start;0H"                  # jump to start line
echo -ne "\033[${box_color}m"                       # sets the color for the box
for i in $(seq $total_lines); do                    # for each line
    echo -ne "\033[${box_col_start}G"               # go to start pos for the column
    if [ $i -eq 1 -o $i -eq $total_lines ]; then    # first and last lines
        echo +$box_line+                            # print horizontal border
    else
        echo -e "|\033[${box_col_end}G|"            # vertical borders
    fi
done
echo -e '\033[m'                                    # turn off colors

### Puts text in the box
echo -ne "\033[$((box_line_start+1));0H"            # jump to start line for text
echo -ne "\033[${text_color}m"                      # set text color
echo "$text" | while read LINE; do
    echo -e "\033[${text_col_start}G$LINE"          # set text
done
echo -e '\033[m'                                    # turn off colors
echo
