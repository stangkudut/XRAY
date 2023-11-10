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
wget -O backupvps.zip "$url"
unzip backupvps.zip
rm -f backupvps.zip
sleep 1
echo Start Restore
cd /root/backupvps
cp passwd /etc/
cp group /etc/
cp shadow /etc/
cp gshadow /etc/
cp -r xray /usr/local/etc/xray
rm -rf /root/backupvps
rm -f backupvps.zip
echo "Restore Berhasil!!!" | lolcat
read -n 1 -s -r -p "Press any key to back on menu"
clear
backupvps
