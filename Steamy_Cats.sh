#!/bin/bash
echo "Possible users to make Steam categories for:"
NAMES=$(grep PersonaName ~/.steam/steam/userdata/*/config/localconfig.vdf | cut -d\" -f4)
let NUMCYCLE=1
for i in $NAMES
do
	echo -n "$NUMCYCLE"": "
	echo "$i"
	let NUMCYCLE=$NUMCYCLE+1
done

read -rp "Who do you want to use? Answer: " WHICHSTEAM

echo -n "We are using: "
echo "$NAMES" | sed -n "$WHICHSTEAM"p

WHICH_CONFIG=$(grep PersonaName ~/.steam/steam/userdata/*/config/localconfig.vdf | sed -n 2p | cut -d: -f1)
let COUNT_SLASHES=$(echo "$WHICH_CONFIG" | grep -o "/" | wc -l)-1
OUR_CONFIG=$(echo "$WHICH_CONFIG" | cut -d/ -f1-$COUNT_SLASHES)"/7/remote/sharedconfig.vdf"
echo "Our config file is: $OUR_CONFIG"

if [ ! -e "$OUR_CONFIG" ]
then
	echo "We can't find the config file."
	echo "This is important, so we are quitting."
	exit
fi

./backend/steam_categories.sh "$OUR_CONFIG" || exit
./backend/download_store_details.sh --front
./backend/download_store_details.sh --api
./backend/make_new_categories.sh "$OUR_CONFIG"
./backend/assemble_shareconfig_vdf.sh "$OUR_CONFIG"

echo "If you are happy with this, run the below command:"
echo "cp /var/tmp/newconfig.vdf $OUR_CONFIG"
