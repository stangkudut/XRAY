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
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}            ----- [ Log Create User ] -----            ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${RB}[1]${NC} ${WB}Log Vmess Account${NC}                                  ${BB}║${NC}"
echo -e "${BB}║${RB}[2]${NC} ${WB}Log Vless Account${NC}                                  ${BB}║${NC}"
echo -e "${BB}║${RB}[3]${NC} ${WB}Log Trojan Account${NC}                                 ${BB}║${NC}"
echo -e "${BB}║${RB}[4]${NC} ${WB}Log Shadowsocks Account${NC}                            ${BB}║${NC}"
echo -e "${BB}║${RB}[5]${NC} ${WB}Log Shadowsocks 2022 Account${NC}                       ${BB}║${NC}"
echo -e "${BB}║${RB}[6]${NC} ${WB}Log Socks5 Account${NC}                                 ${BB}║${NC}"
echo -e "${BB}║${RB}[7]${NC} ${WB}Log All Xray Account${NC}                               ${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║                   ${RB}[0]${NC} Back To Menu                    ${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; log-vmess ; exit ;;
2) clear ; log-vless ; exit ;;
3) clear ; log-trojan ; exit ;;
4) clear ; log-ss ; exit ;;
5) clear ; log-ss2022 ; exit ;;
6) clear ; log-socks ; exit ;;
7) clear ; log-allxray ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo "salah tekan " ; sleep 0.5 ; log-create ;;
esac
