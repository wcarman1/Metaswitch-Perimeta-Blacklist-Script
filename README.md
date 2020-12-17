# Metaswitch-Perimeta-Blacklist-Script
This is a bash script to parse the Metaswitch supplied known bad IP list (https://community.metaswitch.com/support/discussions/topics/76000007169) or any list of IP's (NO CIDR, and NO SUBNET, Just the IP's should be in the file)

EXAMPLE LIST:

    5.5.5.5
    2.2.2.2
    3.3.3.3

   *File extension doesn't matter(I've tested CSV and TXT) and the file can have other text in it as the script searches only to IP addresses in the files.*

It compares the updated list you provide to your existing configuration (if you have one, and if you supply it), 
It creates a text file with the commands needed to add all the IP addresses that you do not currently have in you blacklist. 

**TIP:** I usually download and merge the Metaswitch provided SIP PS and SIP Signaling lists and run this script on the merged lists. 

**THIS SCRIPT WILL NOT REMOVE IP's IF THEY ARE REMOVED FROM THE LIST. That may be added in the future.**

**#REQUIREMENTS**

1. a device capable of runing a bash script (Linux or Windows 10 with Ubuntu App from Microsoft Store)
2. nano text editor
3. configuration level permissions to the Perimeta CLI

**#INTRUCTIONS**

1. Download or create the list of known bad IPs that you wish to block. Save it to the same directory where the banlist.sh file is.
2. Open Terminal or Launch the ubuntu app if you are using Windows 10.
3. cd to the directory that has banlist.sh and your file you just created.
4. run ./banlist.sh
5. You will be prompted as follows:

        "Filename of the list of IPs (include file extension)?   *enter the full file name of the known bad IP file you created*
    
        input.csv <input your filename and extension>

        Copy the output of the Perimeta command 'show config include ban-peer' into the text editor that follows.
        If you do not have any ban-peer entries just save and close. EXCLUDE BAN-PEER RANGE AND ONLY ONE SERVICE NETWORK AT A TIME!!
        Press Any Key to Continue to open Text Editor or Ctrl+C to Exit 
    
    
        *when you continue NANO text editor will open. Paste the the out put of the 'show config include ban-peer' 
        (excluding the ban-peer range entires and only paste in one service network at a time). 
        If you do not have any blacklist or don't which to provide it then just press CTRL+x to exit. Doing this will give you a script for the entire known bad IP list. 
        If you do provide a copy of the existing config then you will paste it in Nano and then press CTRL+x then y*
   
   
        Which Service Network are you working on? NUMBER ONLY
   
        2 <input your service network number>

        Found 796 ipv4 and 1 ipv6 addresses in the new list. Would you like to proceed? Press Any Key to Continue or Ctrl+C to Exit


        Processing Ban-list...Please Wait



        Removing IPs that already exist in your config and creating a script for those that do NOT exist





        Complete! Copy the contents of ban-peer-2020-12-17.txt into the Perimeta CLI"
    
    
6. Copy the content of the newly created txt file into the Perimeta CLI
    
7. Run the command 'show config here' to list the entire blacklist.
    
8. Look for any inline redundant configuration warnings if you have ban-peer ranges. and make the appropriate adjustments to the config.
    
   example warning:
               
        ! This configuration overlaps with configured banned peer range x.x.x.x to y.y.y.y and is redundant.
    
    
    
