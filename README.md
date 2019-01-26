# Steamy Cats
A Steam Game Category Sorter Written in Bash. This script will output the user tags, review score, release year, store flags, [Proton DB](https://www.protondb.com/) scores, and if a game is Linux native to a new Steam Configuration file.

Run the script and select a user. You may also run with --help to see more options.

Requires jq, Steam, and other common utilities to be installed. This script assumes Steam is located in the ~/.steam/ folder and has not been setup with Flatpaks, yet.
## Installation
Just download the Steamy_Cats script and run it.
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
	--user : User number to execute the script with, instead of inputting after running
	  Usage: --user=$USERNUM
	--include-file : Location of the file containing a list of categories to include
	  Usage: --include-file=$FILENAME
	--exclude-file : Location of the file containing a list of categories to exclude
	  Usage: --exclude-file=$FILENAME
```
### Disclaimer
This script works on my Ubuntu 18.04 installation. I have not tested it elsewhere.

Valve and Steam are trademarks of the Valve corporation. They have not endorsed or sanctioned the creation or usage of this script or of these trademarks.
### Image of Generated Library
![Example Image of Steam Library](Example.png?raw=true "Example Image")
### Example Output of Successful Run
```
# ./Steamy_Cats
We are using: SomeUser :: 0000
Our config file is: /home/user/.steam/steam/userdata/00/7/remote/sharedconfig.vdf
Downloading your community profile, if public, and then getting full list of games you own
Begin processing 45717 lines of configuration in /home/user/.steam/steam/userdata/00/7/remote/sharedconfig.vdf
Gathering the list of files to download from Steam now!
Downloading files for these game IDs: 

Downloads complete for the Steam Store User Readable Page.
Most recent ProtonDB file appears to be: ./reports_jan1_2019.tar.gz
Adding new category tags to the games!
Creating final configuration
New config written. To apply, run the below command:
cp /var/tmp/newconfig.vdf /home/user/.steam/steam/userdata/00/7/remote/sharedconfig.vdf
```
### Sample VDF Output
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
