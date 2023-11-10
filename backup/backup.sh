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
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
clear
# ==========================================
install unzip -y
# Getting
clear
figlet "Backup" | lolcat
echo "Mohon Menunggu , Proses Backup sedang berlangsung !!"
rm -rf /root/backupvps
mkdir /root/backupvps
cp /etc/passwd backupvps/
cp /etc/group backupvps/
cp /etc/shadow backupvps/
cp /etc/gshadow backupvps/
cp -r /usr/local/etc/xray backupvps/xray
cd /root
zip -r $IP-$date.zip backupvps > /dev/null 2>&1

echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Tanggal       : $date
==================================
"
curl -X POST https://api.telegram.org/bot1551523951:AAH2a4NOHDhsPeoN_vZNIOn7Jida5o1pkYY/sendDocument \
     -F "chat_id=$(cat /root/id)" \
     -F "document=@/root/backup.zip" \
     -F "caption=File backup mu" &> /dev/null
