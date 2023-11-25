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
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
echo "Masukkan Email Untuk Menerima Backup"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
fi
clear
figlet "Backup" | lolcat
echo "Mohon Menunggu , Proses Backup sedang berlangsung !!"
rm -rf /root/backupvpsku
mkdir /root/backupvpsku
cp /etc/passwd backupvpsku/
cp /etc/group backupvpsku/
cp /etc/shadow backupvpsku/
cp /etc/gshadow backupvpsku/
cp -r /usr/local/etc/xray backupvpsku/usr/local/etc/xray
cp -r /var/www/html backupvpsku/var/www/html
cd /root
zip -r $IP-$date.zip backupvpsku > /dev/null 2>&1
rclone copy /root/$IP-$date.zip backup:server
url=$(rclone link backup:server/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"

echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
" | mail -s "Backup Data" $email
rm -rf /root/backupvpsku
rm -r /root/$IP-$date.zip
clear
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
"
echo "Silahkan cek Kotak Masuk $email"

read -n 1 -s -r -p "Press any key to back on menu"
clear
backupvps
