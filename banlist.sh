#!/bin/bash
#Author: Walter Carman
#Purpose: Automate Ban-list Updates for Perimeta
#Date: 12/16/2020
#NOTES: Tested for Perimeta Version 4.7.30.
#NOTES: This only adds to what you currently have. it does not remove IP's if they are removed from the BAD IP List.

#I usually gather the SIP-PS and SIP Signalling csv files from https://community.metaswitch.com/support/discussions/topics/76000007169 and then add them together to creat the full list for the perimeta.


echo -n "Filename of the list of IPs (include file extention)?"
echo
read -r varips
echo
echo "Copy the output of the Perimeta command 'show config include ban-peer' into the text editor that follows."
echo "If you do not have any ban-peer entries just save and close."
echo "EXCLUDE BAN-PEER RANGE AND ONLY ONE SERVICE NETWORK AT A TIME!!" 
echo "Press Any Key to Continue to open Text Editor or Ctrl+C to Exit"
echo
read -s -n 1 any_key
echo
nano existing.txt
varban=existing.txt
echo
echo "Which Service Network are you working on? NUMBER ONLY"
read -r varsn
echo
countf=$(grep -oEc "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$varips")
counts=$(grep -oEc "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))" "$varips")
echo -n "Found $countf ipv4 and $counts ipv6 addresses in the new list. Would you like to proceed? Press Any Key to Continue or Ctrl+C to Exit"
read -s -n 1 any_key
echo
echo
echo "$(tput setaf 1)$(tput bold)Processing Ban-list...Please Wait$(tput sgr 0)"
echo 
echo
echo
echo 
echo "Removing IPs that already exist in your config and creating a script for those that do NOT exist"
echo
echo
echo
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$varips" >>.ipv4.tmp
grep -oE "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))" "$varips" >> .ipv6.tmp
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" $varban >> .ipv4ex.tmp
grep -oE "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))" $varban >> .ipv6ex.tmp
grep -i -v -f .ipv4ex.tmp .ipv4.tmp > .ban.tmp
grep -i -v -f .ipv6ex.tmp .ipv6.tmp > .ban6.tmp
d=$(date +%Y"-%m-%d")
{
	echo config
	echo system
	echo ip-access-control
	echo blacklisting
} > ban-peer-"$d".txt
cat .ban.tmp | while read -r Line ; do
 {
	echo ban-peer service-network $varsn ipv4 $Line
	echo exit
 } >> ban-peer-"$d".txt
done
cat .ban6.tmp | while read -r line ; do
 {
	echo ban-peer service-network $varsn ipv6 $line
	echo exit 
 } >> ban-peer-"$d".txt
done
echo
echo
echo "Complete!"
echo
echo "After checking over the contents of ban-peer-$d.txt"
echo "Copy the contents into the Perimeta CLI"
echo
echo
echo
echo "Creating script to remove IP addresses that may no longer need to be blocked"
echo
echo
grep -i -v -f .ipv4.tmp .ipv4ex.tmp > .unban.tmp
grep -i -v -f .ipv6.tmp .ipv6ex.tmp > .unban6.tmp
{
	echo config
	echo system
	echo ip-access-control
	echo blacklisting
} > remove-ban-peer-"$d".txt	
cat .unban.tmp | while read -r Linee ; do
 {
	echo no ban-peer service-network $varsn ipv4 $Linee
	echo exit
 } >> remove-ban-peer-"$d".txt
done
cat .unban6.tmp | while read -r linee ; do
 {
	echo no ban-peer service-network $varsn ipv6 $linee 
 } >> remove-ban-peer-"$d".txt
done
echo "Complete!"
echo "After checking over the contents remove-ban-peer-$d.txt"
echo "Copy the contents into Perimeta CLI to remove any IPs that are not on the updated list"
echo
echo "$(tput setaf 1)$(tput bold)You may skip this previous step"
echo "just be aware of the IPs becasue you may be blocking traffic you don't intend to block$(tput sgr 0)"
echo
echo
rm -f .*.tmp


