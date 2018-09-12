#!/bin/bash

# ssh_changer_part_2.sh

# PART 2 OF 2

# You can use these scripts before or after installing the masternode with the install.sh script, it is indifferent,
# you will first use them and first increase the security of your VPS and then the security of your node or masternode.

#Additional scripts for the security of 3DCoin Project Districts masternodes and nodes.
#Created for protection of 3DCoin Project Districts masternodes and nodes.
#These scripts change the SSH default port number 22 with a custom number chosen by the node owner and set up firewall and fail2ban in Linux Ubuntu server/VPS.
#You can find information about Project Districts 3D and about the cryptocurrency 3DCoin / 3DC and its nodes at the following links:
#Project Districts 3D official site https://districts.io/
#3DCoin 3DC official site https://3dcoin.io/
#Project Districts 3DCoin official Github https://github.com/hancoin/hancoinproject/
#HancoinProject Hancoin official site https://hancoin.io/
#Hancoin Telegram resources HUB https://t.me/coindevhan

# Warning: RUN THIS SCRIPT ONLY AFTER THE FIRST SCRIPT (ssh_changer_part_1.sh)
# and ONLY after system reboot and after the first login with the NEW SSH PORT (not run this if you are logged with port 22 now).

# This script installs UFW (firewall interface) if not present (but already installed by the first script) sets new rules in the UFW,
# installs fail2ban if not present and sets fail2ban with the new port chosen by user,
# to protect your server/VPS and your 3DCoin masternode against DDOS attacks.
# Script developed by Michele "3DCoin Daemon" from Project Districts Italian Community (michele1it on Github).

# This script also applies a custom jails configuration to fail2ban but first makes a backup of the configuration
# so if you want to check how fail2ban is configured from this script please read the lines of the script related to fail2ban.

# WARNING: This is the PART 2 (ssh_changer_part_2.sh)
# you must have already run the first script (ssh_changer_part_1.sh) and rebooted the system.

# README - TO CHOOSE A NEW CUSTOM PORT NUMBER
# Choose you new custom SSH port from 1024 to 65535 obviously excluding port 6695 and 6694 (the default 3DCoin Project Districts masternode ports)
# and avoid IANA registered service numbers.
# For example you can choose a number from 1024 to 65535 and after
# you can search if it is a registered service number to avoid it
# at the following two links ((the first one has a search field at the bottom of the page)
# https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml
# https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Registered_ports
# You can get the same list via the shell command with "cat /etc/services" command.

# Only after you are sure you have chosen the right number, you will be ready to run this script,
# it is important that you have memorized and remember this number
# because you will need to put it in the place of number 22 in the Putty or Bitvise box for example
# or in your SSH client to access the server again, clear?
# If you forget this number you can access (maybe) only using the VPS service provider web console, so beware!!!

# Start of the script PART 2

RED='\033[1;31m'
GREEN='\033[00;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color
printf "${CYAN}=====================================================================================${NC}\n"
printf "${YELLOW}= Additional script 2 of 2  for the security of 3DCoin Project Districts Masternode =${NC}\n"
printf "${CYAN}=====================================================================================${NC}\n"
printf "${GREEN}################################################################################${NC}\n"
printf "${GREEN}################################################################################${NC}\n"
printf "${WHITE}ssh_changer_part_2.sh - This is the PART 2 script. ${NC}\n"
printf "${WHITE}RUN THIS SCRIPT ONLY AFTER THE FIRST SCRIPT (ElasticMasterNode_node_port_ssh_change_part_1.sh) ${NC}\n"
printf "${WHITE}This script installs UFW (firewall interface) if not present,${NC}\n"
printf "${WHITE}sets new rules in the UFW, installs fail2ban if not present${NC}\n"
printf "${WHITE}and sets fail2ban with the new port chosen by user.${NC}\n"
printf "${WHITE}Created for protection of Hancoin Project Elastic Masternodes' nodes.${NC}\n"
printf "${WHITE}https://github.com/hancoin/hancoinproject/elasticmasternode${NC}\n"
printf "${RED}################################################################################${NC}\n"
printf "${RED}################################################################################${NC}\n"
printf "${BLUE}================================================================================${NC}\n"
printf "${YELLOW}= SEE FIRST README IN THIS SCRIPT OR ON OUR GITHUB FOR THE CHOISE OF PORT =${NC}\n"
printf "${BLUE}================================================================================${NC}\n"
echo
echo
sleep 5
printf "${RED}WARNING: This script modifies both the firewall (UFW) and fail2ban jails configuration!${NC}\n"
printf "${RED}So if you do not agree and you want to first check what changes are made, please read all the lines of the script code related to these changes.${NC}\n"
printf "${RED}If you do not want to continue you can leave now with CTRL + Z${NC}\n"
printf "${RED}but if you leave now do not forget that if you have already used the first script the firewall is currently DISABLED!${NC}\n"
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
systemctl restart sshd
printf "Enter your custom SSH Port (already chosen earlier in the PART 1 SCRIPT). "
unset new_ssh_port_number
while [ -z ${new_ssh_port_number} ]; do
read -p "PLEASE ENTER YOUR CUSTOM SSH PORT NUMBER: " new_ssh_port_number
done
sleep 5
if [ "${new_ssh_port_number}" == "22" ] || [ "${new_ssh_port_number}" -lt "40999" ] || [ "${new_ssh_port_number}" -gt "41000" ] || [ "${new_ssh_port_number}" == "41879" ] || [ "${new_ssh_port_number}" == "41880" ]; then
  printf "${RED}ERROR: Ports 22 (default SSH port), 40999 and 41000 (Hancoin ports) or ${NC}\n"
  printf "${RED}port numbers less than 41879 or greater than 41880 are not valid choices, please see again the README.${NC}\n"
  echo
  echo "wait... exit..."
  sleep 10
  exit -1
fi
printf "${YELLOW} Be careful! Your custom SSH port number is $new_ssh_port_number !${NC}\n"
echo
printf "${RED} Warning! Do not forget your custom port number $new_ssh_port_number or you lost access via SSH!${NC}\n"
printf "wait..."
echo
sleep 10
printf "${YELLOW}Now the firewall will be set to allow access via your custom port $new_ssh_port_number ... ${NC}\n"
printf "${YELLOW}The firewall will be set also to allow the default communication port 6695 for 3DCoin Project Districts Masternode. ${NC}\n"
printf "${YELLOW}The rules relating to old SSH port 22 will be deleted, you will no longer be able to access the server via port 22 for the SSH protocol, ${NC}\n"
printf "${YELLOW}but you will have to use the new port $new_ssh_port_number ! All other ports will be closed for incoming connections, ${NC}\n"
printf "${YELLOW}except if you have set specific rules for other ports (but then check the firewall for security with the 'ufw status' command), ${NC}\n"
printf "${YELLOW}then the incoming connections will remain allowed only to your new custom SSH port $new_ssh_port_number for the SSH protocol and to the default port 41000 for Hancoin, ${NC}\n"
printf "${YELLOW}and also other incoming connections will remain allowed if you have set specific rules for other ports (but check with the 'ufw status' which ports remain open). ${NC}\n"
sleep 10
sleep 5
yes | apt-get update
yes | apt-get install ufw
ufw disable
ufw allow "$new_ssh_port_number"/tcp
ufw limit "$new_ssh_port_number"/tcp
ufw delete allow ssh/tcp
ufw delete limit ssh/tcp
ufw delete allow 22/tcp
ufw delete limit 22/tcp
ufw delete allow 22
ufw delete limit 22
ufw allow 6695/tcp
ufw logging on
ufw default deny incoming
ufw default allow outgoing
ufw --force enable
printf "wait..."
yes | apt-get install fail2ban
cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local
cp /etc/fail2ban/jail.local /etc/fail2ban/jail_local_backup_port22
rm -r /etc/fail2ban/jail.local
echo "[DEFAULT]
ignoreip = 127.0.0.1/8
bantime  = 3600
findtime  = 900
maxretry = 6

[ssh]
enabled  = true
port     = $new_ssh_port_number
filter   = sshd
logpath  = /var/log/auth.log

[ssh-ddos]
enabled = true
port    = $new_ssh_port_number
filter  = sshd-ddos
logpath  = /var/log/auth.log
maxretry = 2
" >> /etc/fail2ban/jail.local
echo
fail2ban-client reload
printf "wait..."
sleep 10
echo
printf "${GREEN} Done! Now your VPS and your elastic node or masternode are a bit safer and with this installation ${NC}\n"
printf "${GREEN} you have also made the 3DCoin Project Districts network more secure and stable! ${NC}\n"
echo
printf "${WHITE} At the next login do not forget to use the new port ${new_ssh_port_number} instead of the 22 ${NC}\n"
printf "${WHITE} in Putty or Bitvise settings or in your SSH client settings, it is IMPORTANT ! ${NC}\n"
echo
printf "${RED} Great! PART 2 completed! ${NC}\n"
printf "${RED} Thanks from the Hancoin Project's Elastic Masternode and from our Community! ${NC}\n"
printf "wait... exit..."
echo
sleep 20
exit 0
