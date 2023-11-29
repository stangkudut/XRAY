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
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║  ${GB}Public IP${NC}        ${CB}: $MYIP${NC}     "
echo -e "${BB}║  ${GB}Service Provider${NC} ${CB}: $ISP${NC}      "
echo -e "${BB}║  ${GB}Timezone${NC}         ${CB}: $WKT${NC}      "
echo -e "${BB}║  ${GB}City${NC}             ${CB}: $CITY${NC}     "
echo -e "${BB}║  ${GB}Date${NC}             ${CB}: $DATE${NC}     "
echo -e "${BB}║  ${GB}Domain${NC}           ${CB}: $domain${NC}   "
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${BW}          ----- [ Bandwidth Monitoring ] -----         ${NC}${BB}║${NC}  "
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║ ${WB}Today ($DATE)     Monthly ($(date +%B/%Y))${NC}"
echo -e "${BB}║  ${GB}↓↓ Down: ${WB}$dtoday          ${GB}↓↓ Down: ${WB}$dmon${NC}"
echo -e "${BB}║  ${RB}↑↑ Up  : ${WB}$utoday          ${RB}↑↑ Up  : ${WB}$umon${NC}"
echo -e "${BB}║  ${CB}≈ Total: $ttoday          ≈ Total: $tmon${NC}"
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${BW}              ----- [ Xray Menu ] -----                ${NC}${BB}║${NC} "
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${NC} ${RB}[1]${NC} ${WB}Vmess Menu${NC}          ${RB}[5]${NC} ${WB}Shadowsocks 2022 Menu${NC}     ${BB}║${NC} "
echo -e "${BB}║${NC} ${RB}[2]${NC} ${WB}Vless Menu${NC}          ${RB}[6]${NC} ${WB}Socks5 Menu${NC}               ${BB}║${NC} "
echo -e "${BB}║${NC} ${RB}[3]${NC} ${WB}Trojan Menu${NC}         ${RB}[7]${NC} ${WB}All Xray Menu${NC}             ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[4]${NC} ${WB}Shadowsocks Menu${NC}                                  ${BB}║${NC}"
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${BW}               ----- [ Utility ] -----                 ${NC}${BB}║${NC}"
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${NC} ${RB}[8]${NC} ${WB}Log Create Account${NC}  ${RB}[14]${NC} ${WB}VPS Backup${NC}               ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[9]${NC} ${WB}Speedtest${NC}           ${RB}[15]${NC} ${WB}Check DNS Status${NC}         ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[10]${NC} ${WB}Change Domain${NC}      ${RB}[16]${NC} ${WB}Change Xray-core Mod${NC}     ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[11]${NC} ${WB}Renew Cert${NC}         ${RB}[17]${NC} ${WB}Change Xray-core Official${NC}${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[12]${NC} ${WB}About Script${NC}       ${RB}[18]${NC} ${WB}Restart XRAY${NC}             ${BB}║${NC}"
echo -e "${BB}║${NC} ${RB}[13]${NC} ${WB}DNS Setting${NC}        ${RB}[19]${NC} ${WB}Reboot VPS${NC}               ${BB}║${NC}"
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║                    ${RB}[x]${NC} ${WB}Exit Script${NC}                    ${NC}${BB}║${NC}"
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${NC}     ${CB}NGINX STATUS${NC} : $status_nginx    ${CB}XRAY STATUS${NC} : $status_xray     ${NC}${BB}║${NC}"
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
