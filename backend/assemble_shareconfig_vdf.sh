#!/bin/bash

echo "Creating final configuration"

let BEGIN_APPS=$(grep -n \"Apps\" "$1" | cut -d: -f1)+1
let END_APPS=$(grep -n $'^\t\t\t\t}' "$1" | cut -d: -f1 | head -n1)

echo "Adding the top of the configuration"
head -n"$BEGIN_APPS" "$1" > /var/tmp/newconfig.vdf

echo "Compiling the Steam applications and categories"
if [ -f ~/.config/Steamy_Cats/exclude.conf ]
then
	rm -f /var/tmp/Steamy_Cats_Excludes
	grep -v "^#" ~/.config/Steamy_Cats/exclude.conf | while read -r line
	do
		echo "$line" >> /var/tmp/Steamy_Cats_Excludes
	done
	echo "We are skipping the below categories:"
	cat /var/tmp/Steamy_Cats_Excludes
	grep -hvf /var/tmp/Steamy_Cats_Excludes /var/tmp/steamy_cats/* >> /var/tmp/newconfig.vdf
else
	cat /var/tmp/steamy_cats/* >> /var/tmp/newconfig.vdf
fi

echo "Attaching the bottom of the configuration"
tail -n+"$END_APPS" "$1" >> /var/tmp/newconfig.vdf

less /var/tmp/newconfig.vdf
