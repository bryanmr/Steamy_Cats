#!/bin/bash
let BEGIN_APPS=$(grep -n \"Apps\" "$1" | cut -d: -f1)+1
let END_APPS=$(grep -n $'^\t\t\t\t}' "$1" | cut -d: -f1 | head -n1)

head -n"$BEGIN_APPS" "$1" > /var/tmp/newconfig.vdf
cat /var/tmp/steamy_cats/* >> /var/tmp/newconfig.vdf
tail -n+"$END_APPS" "$1" >> /var/tmp/newconfig.vdf

less /var/tmp/newconfig.vdf
