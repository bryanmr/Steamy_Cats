#!/bin/bash

if [ "$1" == "--front" ]
then
	DLOC="$HOME/.local/share/steam_store_frontend/"
	TLOC="https://store.steampowered.com/app/"
elif [ "$1" == "--api" ]
then
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
echo

let NUMEXISTS=0

GAMEPROCESSED=0

for i in /var/tmp/steamy_cats/*
do 
	let GAMEPROCESSED=$GAMEPROCESSED+1
	APPID=$(head -n1 "$i" | cut -d\" -f2)
	DOWNLOAD_TAR="$TLOC$APPID"
	if [ ! -e "$DLOC""$APPID".html ]
	then
		if [ "$EXISTS" == "true" ]
		then
			EXISTS="false"
			echo
		fi
		curl -s -o "$DLOC""$APPID".html "$DOWNLOAD_TAR"
		tput cuu 1 && tput el # Using this to overwrite previous line
		echo "Downloading file number: $GAMEPROCESSED"
	else
		let NUMEXISTS=$NUMEXISTS+1
		if [ "$EXISTS" == "false" ]
		then
			echo "Download already exists, there have been $NUMEXISTS others so far."
			echo
		else
			tput cuu 1 && tput el # Using this to overwrite previous line
			echo "$NUMEXISTS files already existing, not redownloading."
		fi
		EXISTS=true
		continue
	fi
	sleep .2
done

# jq '.[] | .data.categories' ./30.html
# grep -o "\"linux\":true" * | wc -l
# grep -o "\"linux\":false" * | wc -l
# grep -A1 InitAppTagModal ./281990.html | tail -1 | jq '.[] | .name' 2> /dev/null | cut -d\" -f2
