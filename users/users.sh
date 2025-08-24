#!/bin/bash
# users.sh
# Based on Aurelio Vargas's usuarios.sh from the Shell Script Profissional Book
# Adapted to english
#
# Shows the usernames on the system
# Obs.: Reads from /etc
#
# Pedro, August 2025
#

cut -d : -f1,5 /etc/passwd | tr : \\t
