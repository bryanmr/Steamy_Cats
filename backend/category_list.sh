#!/bin/bash
mkdir -p ~/.config/Steamy_Cats/
echo "# List of all categories that games are assigned"
echo "# To skip over unwanted categories, save category names to ~/.config/Steamy_Cats/exclude.conf"
echo -n "# Lines with comments will be ignored."
grep -h -A100 \"tags\" /var/tmp/steamy_cats/* | grep -v -e "}" -e "{" -e "^--" | cut -d\" -f4 | sort -u
