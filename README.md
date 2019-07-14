# Steamy Cats
A Steam Game Category Sorter Written in Bash. This script will output the user tags, review score, release year, store flags, [Proton DB](https://www.protondb.com/) scores, and if a game is Linux native to a new Steam Configuration file.

Run the script and select a user. You may also run with --help to see more options.

Requires jq, Steam, and other common utilities to be installed. This script assumes Steam is located in the ~/.steam/ folder and has not been setup with Flatpaks, yet.
## Installation
Just download the Steamy_Cats script and run it.

For more help, check out this [Steamy Cats article on Addictive Tips](https://www.addictivetips.com/ubuntu-linux-tips/categorize-steam-games-on-linux-with-steamycats/)
## Help Output
```
Steamy Cats is a script to categorize and organize Steam games
	Options include:
	--debug : Turn on lots of things to exit on error and show commands being ran
	  You should also consider --sequential with --debug for more meaningful output
	--sequential : Runs commands one at a time instead of in parallel
	--profiler : Prepends timestamp and shows all commands ran
	  Intended to be redirected to file for profiling of code
	--ignore-old-categories : Gets rid of all category configuration while retaining favorites
	--clear-whole-config : Preserves nothing from old configuration
	--clean-dls : Gets rid of failed downloads and tries again
	--category-list : Returns the list of categories available
	--vdf-file : Name of a VDF configuration to use instead of the script discovered one
	  Usage: --vdf-file=/path/to/file.vdf
	--steam-user-id : The numeric USER ID for your Steam account
	  Usage: --steam-user-id=77777777777777777
	--comm-html : Download your own community page instead of making it public
	  Usage: --comm-html=/path/to/steamcommunity.html
	--user : User number to execute the script with, instead of inputting after running
	  Usage: --user=$USERNUM
	--include-file : Location of the file containing a list of categories to include
	  Usage: --include-file=$FILENAME
	--exclude-file : Location of the file containing a list of categories to exclude
	  Usage: --exclude-file=$FILENAME

```
## Disclaimer
This script works on my Ubuntu 18.04 installation. I have not tested it elsewhere.

Valve and Steam are trademarks of the Valve corporation. They have not endorsed or sanctioned the creation or usage of this script or of these trademarks.
## Image of Generated Library
![Example Image of Steam Library](Example.png?raw=true "Example Image")
## Example Output of Successful Run
```
bryan@Ace:~/git/Steamy_Cats$ ./Steamy_Cats
4 possible users to make Steam categories for:
1 : USER
2 : USER
3 : USER
4 : USER
Enter the number for the user you want to use. Answer: 2
We are using: USER :: 77777777777777
Our config file is: /home/bryan/.steam/steam/userdata/00000000/7/remote/sharedconfig.vdf
Downloading your community profile, if public, and then getting full list of games you own
Created 1903 files :: Preserved configuration for 1903 games.
All downloads completed already, run with --clean-dls if you want to force redownload
Most recent ProtonDB file appears to be: ./reports_jan1_2019.tar.gz
Adding new category tags to the games!
Creating final configuration
PDB Platinum Ratings: 462 :: Native Games: 789
Old config backed up to /var/tmp/oldconfig.vdf
New config written. To apply, run the below command:
cp /var/tmp/newconfig.vdf /home/bryan/.steam/steam/userdata/00000000/7/remote/sharedconfig.vdf
```
## Sample VDF Output
```
"10"
{
	"tags"
	{
		"101"		"SFLAGS Online Multi-Player"
		"102"		"SFLAGS Local Multi-Player"
		"301"		"APP NATIVE LINUX"
		"340"		"RELEASE 2000"
		"200"		"TAGS Action"
		"201"		"TAGS FPS"
		"202"		"TAGS Multiplayer"
		"203"		"TAGS Shooter"
		"204"		"TAGS Classic"
		"205"		"TAGS Team-Based"
		"206"		"TAGS First-Person"
		"207"		"TAGS Competitive"
		"208"		"TAGS Tactical"
		"209"		"TAGS 1990's"
		"210"		"TAGS e-sports"
		"211"		"TAGS PvP"
		"212"		"TAGS Military"
		"213"		"TAGS Strategy"
		"214"		"TAGS Score Attack"
		"215"		"TAGS Survival"
		"216"		"TAGS Old School"
		"217"		"TAGS Assassin"
		"218"		"TAGS 1980s"
		"219"		"TAGS Violent"
		"350"		"REVIEW Overwhelmingly Positive"
		"330"		"ALL"
	}
}
"500"
{
	"tags"
	{
		"102"		"SFLAGS Co-op"
		"104"		"SFLAGS Full controller support"
		"301"		"PDB MODE Borked"
		"302"		"PDB MEAN Bronze"
		"340"		"RELEASE 2008"
		"200"		"TAGS Zombies"
		"201"		"TAGS Co-op"
		"202"		"TAGS FPS"
		"203"		"TAGS Multiplayer"
		"204"		"TAGS Action"
		"205"		"TAGS Shooter"
		"206"		"TAGS Online Co-Op"
		"207"		"TAGS Team-Based"
		"208"		"TAGS First-Person"
		"209"		"TAGS Horror"
		"210"		"TAGS Survival"
		"211"		"TAGS Post-apocalyptic"
		"212"		"TAGS Singleplayer"
		"213"		"TAGS Adventure"
		"214"		"TAGS Atmospheric"
		"215"		"TAGS Tactical"
		"216"		"TAGS Competitive"
		"217"		"TAGS Moddable"
		"218"		"TAGS Female Protagonist"
		"219"		"TAGS Replay Value"
		"350"		"REVIEW Very Positive"
		"330"		"ALL"
	}
}
```
