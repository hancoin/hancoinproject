# ssh_port_changer
Additional optional but recommended scripts for the security of Hancoin Project Elastic Masternodes and Elastic nodes. These scripts change the SSH default port number 22 with a custom number chosen by the node owner and set up firewall and fail2ban in Linux Ubuntu server/VPS.

You can use these scripts before or after installing the masternode with the install.sh script, it is indifferent, you will first use them and first increase the security of your Virtual Machine and then the security of your node or masternode.

**Now start from here...**

****************************************
Step 1: Choose your custom port number!
****************************************

Choose you new custom SSH port from 1024 to 65535 obviously excluding port 6695 and 6694 (the default Hancoin Project Districts nodes ports) and avoid IANA registered service numbers.
For example you can choose a number from 1024 to 65535 and after you can search if it is a registered service number to avoid it at the following two links ((the first one has a search field at the bottom of the page):

https:/www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml

https:/en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers#Registered_ports

You can get the same list via the shell with this command on your VPS/server terminal:

```
cat /etc/services
```

If you want to check which ports are already listening then in use in your system you can use the following command:

```
netstat -ntlp
```

*****************************************************************************************
Step 2: LOGIN as ROOT on your VPS/server and run the FIRST script: ssh_changer_part_1.sh
*****************************************************************************************
**Warning: This script will REBOOTS the server/VPS!
Warning: This script DISABLES the FIREWALL, DO NOT FORGET TO RUN AFTER THIS SCRIPT THE SECOND SCRIPT WITH PART 2 to enable again the firewall!!!**

Do not forget that only after you are sure you have chosen the right new custom port number, you will be ready to run this first script and it's important that you have memorized and remember your custom number, because you will need to put it in the place of number 22 in the Putty or Bitvise box for example or in your SSH client to access the server again, clear? If you forget this number you can access (maybe) only using the VPS service provider web console, so beware!!!

**First of all, do not forget to check NOW if your elastic masternode is regularly active, if you have already installed it, with the usual commands you normally use, for example:**

```
Hancoin-cli elasticmasternode debug
```
This check will need to be done now before you start and then when you are finished, so you will realize that these scripts do not affect the proper functioning of your masternode.

Now, after the choice of the port and after check of elasticmasternode (if you have already installed it) you can run the FIRST script with these commands:

First command (copy and paste all the line, it's one single command, then press ENTER):
```
curl -O https:/raw.githubusercontent.com/hancoin/hancoinproject/master/ssh_changer_part_1.sh > ssh_changer_part_1.sh
```
Second command (copy and paste all the line, it's one single command, then press ENTER):
```
bash ssh_changer_part_1.sh
```
**Warning: This script will REBOOTS the LOCALHOST/VPS!
Warning: This script DISABLES the FIREWALL, DO NOT FORGET TO RUN AFTER THIS SCRIPT THE SECOND SCRIPT WITH PART 2 to enable again the firewall!!!**

**************************************************************************************************************************************
Step 3: AFTER AUTOMATIC REBOOT login again as ROOT on your VPS/server and run the SECOND script: ssh_changer_part_2.sh
**************************************************************************************************************************************
******************************************
YOUR NEW PORT NOW REQUIRED FOR LOGIN AGAIN
******************************************

**Be careful! Don't forget to use now for access the _NEW PORT_ chosen previously when you ran the first script. The system will no longer allow you to access via the old SSH port 22 so you must use in Putty, Bitvise or your SSH client your new custom port not the old ~~22~~ port!!!**

**Warning: RUN THIS SECOND SCRIPT ONLY AFTER AUTOMATIC REBOOT AFTER THE RUN OF THE FIRST SCRIPT (run this second script only if you have already run the first script and the system has been restarted automatically)**.

**************************************************************************************************************************************
Step 4: Run the SECOND script: ssh_changer_part_2.sh
**************************************************************************************************************************************

To run the SECOND script you must use these commands:

First command (copy and paste all the line, it's one single command, then press ENTER):
```
curl -O https:/raw.githubusercontent.com/hancoin/hancoinproject/master/ssh_changer_part_2.sh > ssh_changer_part_2.sh
```
Second command (copy and paste all the line, it's one single command, then press ENTER):
```
bash ssh_changer_part_2.sh
```

_Done! If you followed this step by step guide/readme and correctly executed the instructions, now your VPS and your node/masternode are a bit safer and with this installation you have also made the Hancoin Project Districts network more secure and stable! Thanks from the Hancoin Project Foundation and from our Community!_

Finally, do not forget to check again if your masternode is active (if you have already installed it) with the usual commands you normally use, for example:

```
Hancoin-cli masternode debug
```

Well, this time we just finished. If you need help or if you want to get in touch with the Hancoin Project Community you can find us in the official project site https:/hancoin.io and also through the Telegram HUB https:/t.me/coindevhan you can find all the groups (in various languages) and information channels for the project.

Finally remember that the elastic masternode can be installed before or after using these additional scripts, so if you have already installed it only checks that everything is ok as explained above, while if you have not installed it you can now proceed with the normal installation of the masternode using the main install.sh script found in this repository.
