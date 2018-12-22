#!/bin/bash

rm -rf /var/tmp/steamy_cats/
mkdir /var/tmp/steamy_cats/

# Reads from a filename passed to it
# No arguments available, just outputs something Bash can handle instead of VDF
# We move the values slightly, so we skip the brackets

let BEGIN_APPS=$(grep -n \"Apps\" "$1" | cut -d: -f1)-1
let END_APPS=$(grep -n $'^\t\t\t\t}' "$1" | cut -d: -f1 | head -n1)
let COUNT_LINES=END_APPS-BEGIN_APPS-2
PREV_LINE=0

echo "Begin processing $COUNT_LINES lines of configuration in $1"

for i in $(head -n "$END_APPS" "$1" | tail -$COUNT_LINES | grep -n $'^\t\t\t\t\t{' | cut -d: -f1)
do
	if [ "$PREV_LINE" == "0" ]
	then
		PREV_LINE=$i
		continue
	fi

	let SEC_END_SPOT=$i+$BEGIN_APPS
	let SEC_START_SPOT=$i-$PREV_LINE
	OURSECTION=$(head -n "$SEC_END_SPOT" "$1" | tail -"$SEC_START_SPOT" |\
	       	grep -vi -e $'^\t\t\t\t\t\t}' -e $'^\t\t\t\t\t}' \
		-e '"TAGS ' -e '"FLAGS ' -e '"APP ' -e '"ALL"'
	)
	FILENAME=$(echo "$OURSECTION" | head -n1 | cut -d\" -f2)
	echo "$OURSECTION" > /var/tmp/steamy_cats/"$FILENAME"
	PREV_LINE=$i
done

# Catching the last game, since the for loop cannot
let SEC_END_SPOT=$END_APPS-1
let SEC_START_SPOT=$SEC_END_SPOT-$(head -n "$END_APPS" "$1" | grep -n $'^\t\t\t\t\t{' | cut -d: -f1 | tail -n 1)
OURSECTION=$(head -n "$SEC_END_SPOT" "$1" | tail -"$SEC_START_SPOT" |\
	grep -vi -e $'^\t\t\t\t\t\t}' -e $'^\t\t\t\t\t}' \
	-e '"TAGS ' -e '"FLAGS ' -e '"APP ' -e '"ALL"'
)
FILENAME=$(echo "$OURSECTION" | head -n1 | cut -d\" -f2)

echo "$OURSECTION" > /var/tmp/steamy_cats/"$FILENAME"

# ~/.steam/steam/userdata/*/config/localconfig.vdf
