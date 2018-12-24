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

# Download the Community Profile
echo "Downloading your community profile, if public, and then getting full list of games you own"
curl -s -o /var/tmp/Steamy_Cats_Community_Profile https://steamcommunity.com/profiles/"$(cat /var/tmp/Steamy_Cats_ACCNUM)"/games/?tab=all

# Find the JSON containing our games, then extract the APP ID with JQ
grep "var rgGames" /var/tmp/Steamy_Cats_Community_Profile | \
	sed -e 's/var rgGames \= \[//' -e 's/\]\;//' -e 's/\,[{]/\n\{/g' | jq '.appid' | \
	while read -r appid
	do
		{
                       printf "\t\t\t\t\t\"%s\"\n" "$appid"
                       printf "\t\t\t\t\t{\n"
                       printf "\t\t\t\t\t\t\"%s\"\n" "tags"
                       printf "\t\t\t\t\t\t{\n"
               } > /var/tmp/steamy_cats/"$appid"

	done

echo "Begin processing $COUNT_LINES lines of configuration in $1"

APPS_SECTION=$(head -n "$END_APPS" "$1" | tail -$COUNT_LINES)
GAMES=$(echo "$APPS_SECTION" | grep $'^\t\t\t\t\t\"' | cut -d\" -f2)

function copyexisting
{
	OURSECTION=$(echo "$APPS_SECTION" | grep -A100 $'^\t\t\t\t\t\"'"$1"\" |\
		awk 'NR==1,/^\t\t\t\t\t}$/' |\
	       	grep -vi -e $'^\t\t\t\t\t\t}' -e $'^\t\t\t\t\t}' \
		-e '"TAGS ' -e '"FLAGS ' -e '"APP ' -e '"ALL"'
	)

	if [ "$OURSECTION" == "" ]
	then
		echo Severe error, skipping "$1" since it would be empty, we are working on the below section:
		echo "$APPS_SECTION" | grep -A100 $'\t\t\t\t\t\"'"$1" | awk 'NR==1,/^\t\t\t\t\t}$/'
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
