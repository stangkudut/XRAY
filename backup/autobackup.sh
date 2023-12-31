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
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[36;1m'
WB='\e[37;1m'
BW='\e[30;48;5;15m'
# ==========================================
# Getting
clear
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d");
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# BEGIN_Backup" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
function install() {
wget https://raw.githubusercontent.com/stangkudut/XRAY/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
echo " Autobackup successfully installed"
exit 0
}
function start() {
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
echo "Please enter your email"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
fi
cat << EOF >> /etc/crontab
# BEGIN_Backup
5 0 * * * root backup
# END_Backup
EOF
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Started"
echo " Data Will Be Backed Up Automatically at 00:05 GMT +7"
exit 0
}
function stop() {
email=$(cat /home/email)
sed -i "/^$email/d" /home/email
sed -i "/^# BEGIN_Backup/,/^# END_Backup/d" /etc/crontab
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Stopped"
exit 0
}

function gantipenerima() {
rm -rf /home/email
echo "Please enter your email"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
}
function gantipengirim() {
echo "Please enter your email"
read -rp "Email : " -e email
echo "Please enter your Password email"
read -rp "Password : " -e pwdd
rm -rf /etc/msmtprc
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user $email
from $email
password $pwdd
logfile ~/.msmtp.log
EOF
}
function testemail() {
email=$(cat /home/email)
if [[ "$email" = "" ]]; then
start
fi
email=$(cat /home/email)
echo -e "
Ini adalah isi email percobaaan kirim email dari vps
IP VPS : $IP
Tanggal : $date
" | mail -s "Percobaan Pengiriman Email" $email
}
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}           ----- [ Auto Backup VPS ] -----             ${NC}${BB}║${NC} "
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${NC}                 ----- [ ${sts} ] -----                  ${NC}${BB}║${NC} "
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${NC}   ${RB}[1]${NC} ${GB}Install Auto Backup${NC}                             ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[2]${NC} ${GB}Start Auto Backup${NC}                               ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[3]${NC} ${GB}Stop Auto Backup${NC}                                ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[4]${NC} ${GB}Ganti Email Penerima${NC}                            ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[5]${NC} ${GB}Ganti Email Pengirim${NC}                            ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[6]${NC} ${GB}Test Kirim Email${NC}                                ${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
read -rp "Please Enter The Correct Number : " -e num
case $num in
1)
install
autobackup
;;
2)
start
autobackup
;;
3)
stop
autobackup
;;
4)
gantipenerima
autobackup
;;
5)
gantipengirim
autobackup
;;
6)
testemail
autobackup
;;
*)
clear
;;
esac
