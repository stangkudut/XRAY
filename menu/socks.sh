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
echo -e "${BB}║${BW}              ----- [ Socks5 Menu ] -----              ${NC}${BB}║${NC} "
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║${NC}   ${RB}[1]${NC} ${GB}Create Account Socks5${NC}                           ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[2]${NC} ${GB}Trial Account Socks5${NC}                            ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[3]${NC} ${GB}Extend Account Socks5${NC}                           ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[4]${NC} ${GB}Delete Account Socks5${NC}                           ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[5]${NC} ${GB}Check User Login${NC}                                ${BB}║${NC}"
echo -e "${BB}║═══════════════════════════════════════════════════════║${NC}"
echo -e "${BB}║                   ${RB}[0]${NC} Back To Menu                    ${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e ""
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; add-socks ; exit ;;
2) clear ; try-socks ; exit ;;
3) clear ; ext-socks ; exit ;;
4) clear ; del-socks ; exit ;;
5) clear ; cek-socks ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "salah tekan " ; sleep 1 ; socks ;;
esac
