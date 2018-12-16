#!/bin/bash

NUMGAMES=$(find /var/tmp/steamy_cats/* | wc -l)
GAMESGOTTEN=$(find ~/.local/share/steam_store_api_json/* | wc -l)
echo "You have $NUMGAMES games that we are processing."
echo "There are $GAMESGOTTEN files already existing that we won't redownload."
echo "Expect 1 second per file download, since this is the rate limit Valve imposes."
echo

let NUMEXISTS=0

mkdir -p ~/.local/share/steam_store_api_json/

GAMEPROCESSED=0

for i in /var/tmp/steamy_cats/*
do 
	let GAMEPROCESSED=$GAMEPROCESSED+1
	APPID=$(head -n1 "$i" | cut -d\" -f2)
	DOWNLOAD_TAR="https://store.steampowered.com/api/appdetails/?appids=$APPID"
	if [ ! -e ~/.local/share/steam_store_api_json/"$APPID".html ]
	then
		if [ "$EXISTS" == "true" ]
		then
			EXISTS="false"
			echo
		fi
		curl -s -o ~/.local/share/steam_store_api_json/"$APPID".html "$DOWNLOAD_TAR"
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
	sleep 1
done

# jq '.[] | .data.categories' ./30.html
# grep -o "\"linux\":true" * | wc -l
# grep -o "\"linux\":false" * | wc -l
