#!/bin/bash
# scrape.sh
#
# Scrape our sample pages in page[0-9].html
#
# Pedro, August 2025
#

# page1.html
echo "page1.html"
echo -e "--------------------------------------------"
fgrep Google page1.html | cut -d \" -f 2
echo -e "--------------------------------------------\n"

# page2.html
echo "page2.html"
echo -e "--------------------------------------------"
fgrep '>Google</a>' page2.html | sed 's/.*href="// ; s/".*//'
echo -e "--------------------------------------------\n"

# page3.html
echo "page3.html"
echo -e "--------------------------------------------"
fgrep -i '>Google</a>' page3.html | tr A-Z a-z | sed 's/.*href=// ; s/>.*//'
echo -e "--------------------------------------------\n"

# page2.html and page3.html
echo "page[23].html"
echo -e "--------------------------------------------"
fgrep -i '>Google</a>' page[23].html | tr A-Z a-z | tr -d \" | sed 's/.*href=// ; s/>.*//'
echo -e "--------------------------------------------\n"

# page4.html
echo "page4.html"
echo -e "--------------------------------------------"
tr '\n' ' ' < page4.html | awk 'gsub("<[^/]", "\n&")' | fgrep -i '>Google</a>' | tr A-Z a-z | tr -d \" | sed 's/.*href=// ; s/>.*//'
echo -e "--------------------------------------------\n"

