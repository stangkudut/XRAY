#!/bin/bash
# SL
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
clear
figlet "Restore" | lolcat
echo "This Feature Can Only Be Used According To Vps Data With This Autoscript"
echo "Please input link to your vps data backup file."
echo "You can check it on your email if you run backup data vps before."
read -rp "Link File: " -e url
wget -O backupvpsku.zip "$url"
unzip backupvpsku.zip
rm -f backupvpsku.zip
sleep 1
echo Start Restore
cd /root/backupvpsku
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp -r user/* /user/
cp -r xray/ /usr/local/etc/
cp -r html/ /var/www/
rm -rf /root/backupvpsku
rm -f backupvpsku.zip
echo "Restore Berhasil!!!" | lolcat
read -n 1 -s -r -p "Press any key to back on menu"
clear
backupvps
