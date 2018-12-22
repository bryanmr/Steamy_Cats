#!/bin/bash

cd /var/tmp/steamy_cats/ || exit

echo "Adding new category tags to the games!"

for i in *
do
	let VALNUM=100
	CATS=$(jq '.[] | .data.categories' "$HOME/.local/share/steam_store_api_json/$i.html" | grep description | cut -d\" -f4)
	echo "$CATS" | while read -r line
	do
		if [ "$line" == "" ]
		then
			printf "\t\t\t\t\t\t\t\"%s\"\t\t\"%s\"\n" "$VALNUM" "FLAGS NONE" >> /var/tmp/steamy_cats/"$i"
		else
			printf "\t\t\t\t\t\t\t\"%s\"\t\t\"FLAGS %s\"\n" "$VALNUM" "$line" >> /var/tmp/steamy_cats/"$i"
		fi
		let VALNUM=$VALNUM+1
	done

	# This is basically the same as the flags above, but making it a function complicates things a bit IMO
	let VALNUM=200
	TAGS=$(grep -A1 InitAppTagModal "$HOME/.local/share/steam_store_frontend/$i.html" | tail -1 | jq '.[] | .name' 2> /dev/null | cut -d\" -f2)
	echo "$TAGS" | while read -r line
        do
                if [ "$line" == "" ]
                then
                        printf "\t\t\t\t\t\t\t\"%s\"\t\t\"%s\"\n" "$VALNUM" "TAGS NONE" >> /var/tmp/steamy_cats/"$i"
                else
                        printf "\t\t\t\t\t\t\t\"%s\"\t\t\"TAGS %s\"\n" "$VALNUM" "$line" >> /var/tmp/steamy_cats/"$i"
                fi
                let VALNUM=$VALNUM+1
        done

	if grep -q '"linux":true' "$HOME/.local/share/steam_store_api_json/$i.html"
	then
		printf "\t\t\t\t\t\t\t\"%s\"\t\t\"APP NATIVE\"\n" "300" >> /var/tmp/steamy_cats/"$i"
	fi

	if grep -q $'\t\t\t\t\t"Hidden"\t\t"1"' /var/tmp/steamy_cats/"$i"
	then
		grep -hv $'\t\t\t\t\t"Hidden"' /var/tmp/steamy_cats/"$i" > /var/tmp/Steamy_Cats_Rewrite
		cp /var/tmp/Steamy_Cats_Rewrite /var/tmp/steamy_cats/"$i"
		{
                        printf "\t\t\t\t\t\t\t\"%s\"\t\t\"ALL\"\n" "301"
                        printf "\t\t\t\t\t\t}\n"
			printf "\t\t\t\t\t\t\"Hidden\"\t\t\"1\"\n"
                        printf "\t\t\t\t\t}\n"
                } >> /var/tmp/steamy_cats/"$i"
	else
		{
			printf "\t\t\t\t\t\t\t\"%s\"\t\t\"ALL\"\n" "301"
			printf "\t\t\t\t\t\t}\n"
			printf "\t\t\t\t\t}\n"
		} >> /var/tmp/steamy_cats/"$i"
	fi
done
