# Steamy Cats
A Steam Game Category Sorter Written in Bash. This script will output the user tags, review score, release year, store flags, [Proton DB](https://www.protondb.com/) scores, and if a game is Linux native to a new Steam Configuration file.

Run the script and select a user. You may also run with --help to see more options.

Requires jq, Steam, and other common utilities to be installed. This script assumes Steam is located in the ~/.local/share/ folder and has not been setup with Flatpaks, yet.
## Help Output
'''
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
'''
### Disclaimer
This script works on my Ubuntu 18.04 installation. I have not tested it elsewhere.

Valve and Steam are trademarks of the Valve corporation. They have not endorsed or sanctioned the creation or usage of this script of these trademarks.
