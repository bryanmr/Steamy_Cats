#!/bin/bash

# mkdir -p /var/tmp/steamy_cats_api_raw/
# 
# for i in ~/.local/share/steam_store_api_json/*
# do
# 	STEAMY_ID=$(echo "$i" | rev | cut -d/ -f1 | rev | cut -d. -f1)
# 	jq '.[] | .data.categories' "$i" | grep description | cut -d\" -f4 > /var/tmp/steamy_cats_api_raw/"$STEAMY_ID"
# done

# for i in *; do echo $i; cat $i | grep -v -e \{ -e \} -e tags -e LastPlayed -e cloudenabled -e Hidden -e category -e preloadsell; echo ----; done | less
# for i in *; do echo $i; cat $i | grep -B 100 $'^\t\t\t\t\t\t{' ; echo ----; done | less

cd /var/tmp/steamy_cats/ || exit

#for i in ~/.local/share/steam_store_api_json/*
for i in *
do
	if [ ! -e "$HOME"/.local/share/steam_store_api_json/"$i".html ]
	then
		rm -f /var/tmp/steam_cats/"$i"
		echo "Game not available on the store, ID $i so we are skipping"
		continue
	fi
	#STEAMY_ID=$(echo "$i" | rev | cut -d/ -f1 | rev | cut -d. -f1)
	let VALNUM=0
	CATS=$(jq '.[] | .data.categories' "$HOME/.local/share/steam_store_api_json/$i.html" | grep description | cut -d\" -f4)
	echo "$CATS" | while read -r line
	do
		if [ "$line" == "" ]
		then
			printf "\t\t\t\t\t\t\t\"%s\"\t\t\"%s\"\n" "$VALNUM" "No Flags" >> /var/tmp/steamy_cats/"$i"
		else
			printf "\t\t\t\t\t\t\t\"%s\"\t\t\"%s\"\n" "$VALNUM" "$line" >> /var/tmp/steamy_cats/"$i"
		fi
		let VALNUM=$VALNUM+1
	done

	if grep -q '"linux":true' "$HOME/.local/share/steam_store_api_json/$i.html"
	then
		printf "\t\t\t\t\t\t\t\"%s\"\t\t\"Linux Native\"\n" "100" >> /var/tmp/steamy_cats/"$i"
	else
		printf "\t\t\t\t\t\t\t\"%s\"\t\t\"Not Native\"\n" "100" >> /var/tmp/steamy_cats/"$i"
	fi
	printf "\t\t\t\t\t\t}\n" >> /var/tmp/steamy_cats/"$i"
	printf "\t\t\t\t\t}\n" >> /var/tmp/steamy_cats/"$i"

#	# Logic eventually for when the category retain option is added
#	echo /var/tmp/steamy_cats/"$STEAMY_ID"
#	if [ "$(wc -l /var/tmp/steamy_cats/"$STEAMY_ID" | awk '{ print $1 }')" -gt 2 ]
#	then
#		tail -n -1 /var/tmp/steamy_cats/"$STEAMY_ID" | cut -d\" -f2
#	fi
done
