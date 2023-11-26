NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[36;1m'
WB='\e[37;1m'
BW='\e[123;48;5;33m'
xray_service=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nginx_service=$(systemctl status nginx | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray_service == "running" ]]; then
status_xray="${GB}[ ON ]"
else
status_xray="${RB}[ OFF ]"
fi
if [[ $nginx_service == "running" ]]; then
status_nginx="${GB}[ ON ]"
else
status_nginx="${RB}[ OFF ]"
fi
dtoday="$(vnstat | grep today | awk '{print $2" "substr ($3, 1, 3)}')"
utoday="$(vnstat | grep today | awk '{print $5" "substr ($6, 1, 3)}')"
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}')"
dmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $2" "substr ($3, 1 ,3)}')"
umon="$(vnstat -m | grep `date +%G-%m` | awk '{print $5" "substr ($6, 1 ,3)}')"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}')"
domain=$(cat /usr/local/etc/xray/domain)
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
WKT=$(cat /usr/local/etc/xray/timezone)
DATE=$(date -R | cut -d " " -f -4)
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}        ----- [ Xray Script By ST4NGKUDUT ] -----      ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC} ${CB}Public IP${NC}        ${WB}: $MYIP                    ${BB}║${NC} "
echo -e "${BB}║${NC} ${CB}Service Provider${NC} ${WB}: $ISP             ${BB}║${NC}  "
echo -e "${BB}║${NC} ${CB}Timezone${NC}         ${WB}: $WKT${NC}                     ${BB}║${NC}  "
echo -e "${BB}║${NC} ${CB}City${NC}             ${WB}: $CITY${NC}                          ${BB}║${NC}  "
echo -e "${BB}║${NC} ${CB}Date${NC}             ${WB}: $DATE${NC}                   ${BB}║${NC}  "
echo -e "${BB}║${NC} ${CB}Domain${NC}           ${WB}: $domain${NC}               ${BB}║${NC}  "
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}          ----- [ Bandwidth Monitoring ] -----         ${NC}${BB}║${NC}  "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC}  ${WB}Today ($DATE)     Monthly ($(date +%B/%Y))${NC} ${BB}║${NC} "
echo -e "${BB}║${NC}    ${CB}↓↓ Down: $dtoday          ↓↓ Down: $dmon${NC}       ${BB}║${NC}"
echo -e "${BB}║${NC}    ${CB}↑↑ Up  : $utoday          ↑↑ Up  : $umon${NC}       ${BB}║${NC} "
echo -e "${BB}║${NC}    ${CB}≈ Total: $ttoday         ≈ Total: $tmon${NC}      ${BB}║${NC} "
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}              ----- [ Xray Menu ] -----                ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC} ${GB}[1]${NC} ${YB}Vmess Menu${NC}          ${GB}[5]${NC} ${YB}Shadowsocks 2022 Menu${NC}     ${BB}║${NC} "
echo -e "${BB}║${NC} ${GB}[2]${NC} ${YB}Vless Menu${NC}          ${GB}[6]${NC} ${YB}Socks5 Menu${NC}               ${BB}║${NC} "
echo -e "${BB}║${NC} ${GB}[3]${NC} ${YB}Trojan Menu${NC}         ${GB}[7]${NC} ${YB}All Xray Menu${NC}             ${BB}║${NC}"
echo -e "${BB}║${NC} ${GB}[4]${NC} ${YB}Shadowsocks Menu${NC}                                  ${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}               ----- [ Utility ] -----                 ${NC}${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC} ${GB}[8]${NC} ${YB}Log Create Account${NC}  ${GB}[14]${NC} ${YB}VPS Backup${NC}               ${BB}║${NC}"
echo -e "${BB}║${NC} ${GB}[9]${NC} ${YB}Speedtest${NC}           ${GB}[15]${NC} ${YB}Check DNS Status${NC}         ${BB}║${NC}"
echo -e "${BB}║${NC} ${GB}[10]${NC} ${YB}Change Domain${NC}      ${GB}[16]${NC} ${YB}Change Xray-core Mod${NC}     ${BB}║${NC}"
echo -e "${BB}║${NC} ${GB}[11]${NC} ${YB}Renew Cert${NC}         ${GB}[17]${NC} ${YB}Change Xray-core Official${NC}${BB}║${NC}"
echo -e "${BB}║${NC} ${GB}[12]${NC} ${YB}About Script${NC}       ${GB}[18]${NC} ${YB}Restart XRAY${NC}             ${BB}║${NC}"
echo -e "${BB}║${NC} ${GB}[13]${NC} ${YB}DNS Setting${NC}        ${GB}[19]${NC} ${YB}Reboot VPS${NC}               ${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}                ----- [ Exit Menu ] -----              ${NC}${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC}                ${RB}         PRESS X         ${NC}              ${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}     NGINX STATUS : $status_nginx    ${BW}XRAY STATUS :    $status_xray ${NC}${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e ""

echo -e ""
read -p " Select Menu :  "  opt
echo -e ""
case $opt in
1) clear ; vmess ;;
2) clear ; vless ;;
3) clear ; trojan ;;
4) clear ; shadowsocks ;;
5) clear ; shadowsocks2022 ;;
6) clear ; socks ;;
7) clear ; allxray ;;
8) clear ; log-create ;;
9) clear ; speedtest ;;
10) clear ; dns ;;
11) clear ; certxray ;;
12) clear ; about ;;
13) clear ; changer ;;
14) clear ; backupvps ;;
15) clear ;
resolvectl status
echo ""
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
echo ""
echo ""
menu ;;
16) clear ; xraymod ;;
17) clear ; xrayofficial ;;
18) clear ; restart-xray ;;
19) clear ; reboot ; /sbin/reboot ;;
x) clear ; exit ;;
*) echo -e "${RB}salah input${NC}" ; sleep 1 ; menu ;;
esac
