#!/bin/bash

rm -rf /var/tmp/steamy_cats/
mkdir /var/tmp/steamy_cats/

# Reads from a filename passed to it
# No arguments available, just outputs something Bash can handle instead of VDF

# We skip the bracket and header
let BEGIN_APPS=$(grep -n \"Apps\" "$1" | cut -d: -f1)+2
# We skip the bracket
let END_APPS=$(grep -n $'^\t\t\t\t}' "$1" | cut -d: -f1 | head -n1)-1
# Fixing the count here
let COUNT_LINES=END_APPS-BEGIN_APPS+1

#grep -A1000000 '"Apps"' ~/.steam/steam/userdata//config/localconfig.vdf | awk 'NR==1,/^\t\t\t\t}$/' | grep $'^\t\t\t\t\t"' | cut -d\" -f2 | \
#	while read -r line
#	do
#		{
#			printf "\t\t\t\t\t\"%s\"\n" "$line"
#			printf "\t\t\t\t\t{\n"
#			printf "\t\t\t\t\t\t\"%s\"\n" "tags"
#			printf "\t\t\t\t\t\t{\n"
#		} > /var/tmp/steamy_cats/"$line"
#	done

echo "Begin processing $COUNT_LINES lines of configuration in $1"

APPS_SECTION=$(head -n "$END_APPS" "$1" | tail -$COUNT_LINES)
GAMES=$(echo "$APPS_SECTION" | grep $'^\t\t\t\t\t\"' | cut -d\" -f2)

function copyexisting
{
	OURSECTION=$(echo "$APPS_SECTION" | grep -A100 $'\t\t\t\t\t\"'"$1" |\
		awk 'NR==1,/^\t\t\t\t\t}$/' |\
	       	grep -vi -e $'^\t\t\t\t\t\t}' -e $'^\t\t\t\t\t}' \
		-e '"TAGS ' -e '"FLAGS ' -e '"APP ' -e '"ALL"'
	)

	if [ "$OURSECTION" == "" ]
	then
		echo Severe error, skipping "$1" since it would be empty
		exit 1
	fi

	echo "$OURSECTION" > /var/tmp/steamy_cats/"$1"

	# Sometimes games don't have tags but other configs
	# This adds the tags section at the end
	if ! echo "$OURSECTION" | grep -q $'\t\t\t\t\t\"tags\"'
	then
		{
			printf "\t\t\t\t\t\t\"%s\"\n" "tags"
			printf "\t\t\t\t\t\t{\n"
		} >> /var/tmp/steamy_cats/"$1"
	fi
}

for game in $GAMES
do
	copyexisting "$game" &
done
wait

# config/loginusers.vdf
