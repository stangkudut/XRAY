NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[36;1m'
WB='\e[37;1m'
BW='\e[30;48;5;15m'
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
echo -e "   ${GB}Public IP${NC}        ${CB}: $MYIP${NC}     "
echo -e "   ${GB}Service Provider${NC} ${CB}: $ISP${NC}      "
echo -e "   ${GB}Timezone${NC}         ${CB}: $WKT${NC}      "
echo -e "   ${GB}City${NC}             ${CB}: $CITY${NC}     "
echo -e "   ${GB}Date${NC}             ${CB}: $DATE${NC}     "
echo -e "   ${GB}Domain${NC}           ${CB}: $domain${NC}   "
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}          ----- [ Bandwidth Monitoring ] -----         ${NC}${BB}║${NC}  "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "  ${WB}Today ($DATE)     Monthly ($(date +%B/%Y))${NC}"
echo -e "    ${CB}↓↓ Down: $dtoday          ↓↓ Down: $dmon${NC}"
echo -e "    ${CB}↑↑ Up  : $utoday          ↑↑ Up  : $umon${NC}"
echo -e "    ${CB}≈ Total: $ttoday          ≈ Total: $tmon${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}              ----- [ Xray Menu ] -----                ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC} ${RB}[1]${NC} ${GB}Vmess Menu${NC}          ${RB}[5]${NC} ${GB}Shadowsocks 2022 Menu${NC}     ${BB}║${NC} "
echo -e "${BB}║${NC} ${RB}[2]${NC} ${GB}Vless Menu${NC}          ${RB}[6]${NC} ${GB}Socks5 Menu${NC}               ${BB}║${NC} "
echo -e "${BB}║${NC} ${RB}[3]${NC} ${GB}Trojan Menu${NC}         ${RB}[7]${NC} ${GB}All Xray Menu${NC}             ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[4]${NC} ${GB}Shadowsocks Menu${NC}                                  ${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}               ----- [ Utility ] -----                 ${NC}${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC} ${RB}[8]${NC} ${GB}Log Create Account${NC}  ${RB}[14]${NC} ${GB}VPS Backup${NC}               ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[9]${NC} ${GB}Speedtest${NC}           ${RB}[15]${NC} ${GB}Check DNS Status${NC}         ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[10]${NC} ${GB}Change Domain${NC}      ${RB}[16]${NC} ${GB}Change Xray-core Mod${NC}     ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[11]${NC} ${GB}Renew Cert${NC}         ${RB}[17]${NC} ${GB}Change Xray-core Official${NC}${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[12]${NC} ${GB}About Script${NC}       ${RB}[18]${NC} ${GB}Restart XRAY${NC}             ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[13]${NC} ${GB}DNS Setting${NC}        ${RB}[19]${NC} ${GB}Reboot VPS${NC}               ${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║                    ${RB}[0]${NC} ${GB}Exit Script${NC}                    ${NC}${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${NC}     ${WB}NGINX STATUS${NC} : $status_nginx    ${WB}XRAY STATUS${NC} : $status_xray     ${NC}${BB}║${NC}"
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
