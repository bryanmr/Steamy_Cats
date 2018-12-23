#!/bin/bash

if [ "$1" == "--front" ]
then
	EXITMESSAGE="Steam Store User Readable Page"
	DLOC="$HOME/.local/share/steam_store_frontend/"
	TLOC="https://store.steampowered.com/app/"
elif [ "$1" == "--api" ]
then
	EXITMESSAGE="Steam Store API"
	TLOC="https://store.steampowered.com/api/appdetails/?appids="
	DLOC="$HOME/.local/share/steam_store_api_json/"
else
	echo "This script takes one argument."
	echo "Supply --front for frontend download or --api for API"
	exit
fi

mkdir -p "$DLOC"

NUMGAMES=$(find /var/tmp/steamy_cats/* | wc -l)
GAMESGOTTEN=$(find "$DLOC"* | wc -l)
echo "You have $NUMGAMES games that we are processing."
echo "There are $GAMESGOTTEN files already existing that we won't redownload."
echo "Expect 1 second per file download, since this is the rate limit Valve imposes."

let NUMEXISTS=0
EXISTS=false
GAMEPROCESSED=0

cd /var/tmp/steamy_cats || exit
for i in *
do 
	let GAMEPROCESSED=$GAMEPROCESSED+1
	APPID=$i
	if [ ! -e "$DLOC""$APPID".html ]
	then
		if [ "$EXISTS" == "true" ]
		then
			EXISTS="false"
			echo "We found $NUMEXISTS files so far. Starting downloads of new files now."
			echo
		fi
		curl -s -o "$DLOC""$APPID".html "$TLOC$APPID"
		tput cuu 1 && tput el # Using this to overwrite previous line
		echo "Downloading file number: $GAMEPROCESSED"
	else
		let NUMEXISTS=$NUMEXISTS+1
		if [ "$EXISTS" == "false" ]
		then
			echo "Processing list of existing files saved."
			EXISTS=true
			continue
		else
			continue
		fi
	fi
	sleep .2
done

echo "Downloads complete for the $EXITMESSAGE."

# jq '.[] | .data.categories' ./30.html
# grep -o "\"linux\":true" * | wc -l
# grep -o "\"linux\":false" * | wc -l
# grep -A1 InitAppTagModal ./281990.html | tail -1 | jq '.[] | .name' 2> /dev/null | cut -d\" -f2
