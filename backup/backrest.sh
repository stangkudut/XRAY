#!/bin/bash
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
# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
# ==========================================
export SC=$( /usr/bin/mbackup )
if [ "${SC}" -ne 1 ]; then
echo -e "${INFO} Starting Replacing Script !"
rm -rf /usr/bin/backup
rm -rf /usr/bin/autobackup
rm -rf /usr/bin/restore
fi
clear

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
sudo apt-get install figlet -y
sleep 3
clear
sudo apt install ruby -y
sleep 3
clear
sudo gem install lolcat
sleep 3
clear
apt install msmtp-mta ca-certificates bsd-mailx -y
sleep 3
clear
read -rp "input your chat id Telegram:" idtele
echo "$idtele" >> /root/id

cd /usr/bin
wget -O autobackup "https://raw.githubusercontent.com/stangkudut/XRAY/main/backup/autobackup.sh"
wget -O backup "https://raw.githubusercontent.com/stangkudut/XRAY/main/backup/backup.sh"
wget -O restore "https://raw.githubusercontent.com/stangkudut/XRAY/main/backup/restore.sh"
chmod +x autobackup
chmod +x backup
chmod +x restore
chmod +x limitspeed
cd
rm -f /root/set-br.sh
