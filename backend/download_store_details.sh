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
find "$DLOC" -empty -type f -delete

NUMGAMES=$(find /var/tmp/steamy_cats/* | wc -l)
GAMESGOTTEN=$(find "$DLOC"* | wc -l)
echo "You have $NUMGAMES games that we are processing."
echo "There are $GAMESGOTTEN files already existing that we won't redownload."
echo "Starting downloads!"

let NUMEXISTS=0
let GAMEPROCESSED=0
let DOWNLOADED=0

cd /var/tmp/steamy_cats || exit
for i in *
do 
	let GAMEPROCESSED=$GAMEPROCESSED+1
	APPID=$i
	if [ ! -e "$DLOC""$APPID".html ]
	then
		curl --cookie "mature_content=1 ; birthtime=-729000000" -s -o "$DLOC""$APPID".html "$TLOC$APPID"
		let DOWNLOADED=$GAMEPROCESSED-$NUMEXISTS
		tput cuu 1 && tput el # Using this to overwrite previous line
		echo "Downloaded: $DOWNLOADED ~~ Existing: $NUMEXISTS"
	else
		let NUMEXISTS=$NUMEXISTS+1
		tput cuu 1 && tput el # Using this to overwrite previous line
		echo "Downloaded: $DOWNLOADED ~~ Existing: $NUMEXISTS"
		continue
	fi
	sleep .2
done

echo "Downloads complete for the $EXITMESSAGE."

# jq '.[] | .data.categories' ./30.html
# grep -o "\"linux\":true" * | wc -l
# grep -o "\"linux\":false" * | wc -l
# grep -A1 InitAppTagModal ./281990.html | tail -1 | jq '.[] | .name' 2> /dev/null | cut -d\" -f2
