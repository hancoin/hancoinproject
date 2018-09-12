#!/bin/bash

# ssh_changer_part_1.sh

# PART 1 OF 2

# You can use these scripts before or after installing the ElasticMasternode with the install.sh script, it is indifferent,
# you will first use them and first increase the security of your VPS and then the security of your node or ElasticMasternode.

#Additional scripts for the security of HancoinProject ElasticMasternodes and nodes.
#Created for protection of HancoinProject ElasticMasternodes and nodes.
#These scripts change the SSH default port number 22 with a custom number chosen by the node owner and set up firewall and fail2ban in Linux Ubuntu server/VPS.
#You can find information about Project HAN and about the cryptocurrency Hancoin/ ElasticElasticMasternode and its nodes at the following links:
#Project HAN official site https://hancoin.io/
#HancoinHAN official site https://hancoin.io/
#Project HancoinProject Github https://github.com/hancoin/hancoinproject/elasticmasternode
#Project HancoinProject forum https:// HANcoin.io/
#Project HancoinTelegram resources HUB https://t.me/coindevhan

# Warning: This script will REBOOTS the server/VPS!

# Warning: This script DISABLES the FIREWALL, DO NOT FORGET TO RUN AFTER THIS SCRIPT THE SECOND SCRIPT WITH PART 2 to enable again the firewall!!!

# This script is the PART 1 that changes only the default 22 port number for SSH protocol in Linux Ubuntu with a user-chosen port,
# installs UFW if not present and sets the new port rules in the firewall (UFW)
# to protect your server/VPS and your ElasticMasternodeagainst DDOS attacks.

# You need also to run the other script with PART 2 for a complete installation!

# Script developed by Anthony Han "Hancoin Daemon" from Project Italian Community (Hancoin on Github).

# WARNING: This is the PART 1 (ssh_changer_part_1.sh)
# after system reboot you need to run the PART 2 (ssh_changer_part_2.sh)

# README - TO CHOOSE A NEW CUSTOM PORT NUMBER
# Choose you new custom SSH port from 1024 to 41879 obviously excluding port 41000 and 40999 (the default HancoinProject ElasticMasternodeports)
# and avoid IANA registered service numbers.
# For example you can choose a number from 1024 to 41880 and after
# you can search if it is a registered service number to avoid it
# at the following two links ((the first one has a search field at the bottom of the page)
# https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml
# https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Registered_ports
# You can get the same list via the shell command with "cat /etc/services" command.

# Only after you are sure you have chosen the right number, you will be ready to run this script,
# it is important that you have memorized and remember this number
# because you will need to put it in the place of number 22 in the Putty or Bitvise box for example
# or in your SSH client to access the server again!
# If you forget this number you can access (maybe) only using the VPS service provider web console, so beware!!!

# Start of the script PART 1

RED='\033[1;31m'
GREEN='\033[00;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color
printf "${CYAN}================================================================================${NC}\n"
printf "${YELLOW}= Additional script 1 of 2 for the security of HancoinProject ElasticMasternode=${NC}\n"
printf "${CYAN}================================================================================${NC}\n"
printf "${GREEN}################################################################################${NC}\n"
printf "${GREEN}################################################################################${NC}\n"
printf "${WHITE}ssh_changer_part_1.sh - This is the PART 1 script. ${NC}\n"
printf "${WHITE}This script changes only the default 22 SSH port in Linux Ubuntu${NC}\n"
printf "${WHITE}with a user-chosen port and sets the new port rules in the firewall.${NC}\n"
printf "${WHITE}WARNING: This script reboots the server!${NC}\n"
printf "${WHITE}Created for protection of HancoinProject nodes.${NC}\n"
printf "${WHITE}https://github.com/Hancoin/ElasticMasternode${NC}\n"
printf "${RED}################################################################################${NC}\n"
printf "${RED}################################################################################${NC}\n"
printf "${BLUE}================================================================================${NC}\n"
printf "${YELLOW}= SEE FIRST README IN THIS SCRIPT OR ON OUR GITHUB FOR THE CHOISE OF PORT =${NC}\n"
printf "${BLUE}================================================================================${NC}\n"
echo
echo
sleep 5
printf "${RED} ===== WARNING: At the end this script reboots the server! ===== ${NC}\n"
printf "${RED}  If you do not want to do it, press now CTRL + Z${NC}\n"
printf "${RED}  (control key and z key together to exit this script)${NC}\n"
echo
echo
sleep 5
printf "${YELLOW} Do you have chosen the new correct number and do you have memorized it?${NC}\n"
printf "${YELLOW} If you did not, press CTRL + Z (control key and z key together to exit this script)${NC}\n"
printf "${YELLOW} and go read the instructions for choosing the new port number.${NC}\n"
echo
if [ "$(whoami)" != "root" ]; then
 echo "This script must be run as root! Please run as root!"
 echo
 echo "wait... exit..."
 sleep 10
 exit -1
fi
echo
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_backup_port22
printf "Enter your custom SSH Port (see README for some tips about this choise). "
unset new_ssh_port_number
while [ -z ${new_ssh_port_number} ]; do
read -p "PLEASE ENTER YOUR NEW SSH PORT NUMBER: " new_ssh_port_number
done
sleep 5
if [ "${new_ssh_port_number}" == "22" ] || [ "${new_ssh_port_number}" -lt "41880" ] || [ "${new_ssh_port_number}" -gt "41879" ] || [ "${new_ssh_port_number}" == "41000" ] || [ "${new_ssh_port_number}" == "40999" ]; then
 printf "${RED}ERROR: Ports 22 (default SSH port), 41879 and 41880 (HancoinElasticMasternodeports) or ${NC}\n"
 printf "${RED}port numbers less than 1024 or greater than 65535 are not valid choices, please see again the README.${NC}\n"
 echo
 echo "wait... exit..."
 sleep 10
 exit -1
fi
printf "${YELLOW} Be careful! Your custom SSH port number is $new_ssh_port_number !${NC}\n"
sed -i "s/[#]\{0,1\}[ ]\{0,1\}Port [0-9]\{2,\}/Port ${new_ssh_port_number}/g" /etc/ssh/sshd_config
printf "${RED} Warning! Do not forget your custom port number $new_ssh_port_number or you lost access via SSH!${NC}\n"
printf "wait..."
echo
sleep 10
printf "${YELLOW}Now the firewall will be set to allow access via this new port ${new_ssh_port_number}... ${NC}\n"
sleep 5
yes | apt-get update
yes | apt-get install ufw
ufw disable
ufw allow "$new_ssh_port_number"/tcp
ufw limit "$new_ssh_port_number"/tcp
sleep 2
printf "${RED}Attention!${NC}\n This script only adds the new port to the firewall rules but does NOT delete the old rules for SSH port 22!"
echo
printf "and ${RED}this script DISABLES the firewall${NC}\n because otherwise the connection may fall, it will be the second script that is Hancoin_node_port_ssh_change_part_2.sh"
echo
printf "to delete the old rules of port 22 and ${RED}to ENABLE the firewall again so do not forget to also run the second script!${NC}\n"
echo
printf "wait..."
sleep 10
echo
printf "${GREEN} PART 1 completed - After system reboot do not forget to run the second script with PART 2 ${NC}\n"
echo
printf "${WHITE} At the next login do not forget to use the new port ${new_ssh_port_number} instead of the 22 ${NC}\n"
printf "${WHITE} in Putty or Bitvise settings or in your SSH client settings, it is IMPORTANT ! ${NC}\n"
echo
printf "${RED} WARNING! Imminent system REBOOT... ${NC}\n"
sleep 20
systemctl reboot
exit 0
