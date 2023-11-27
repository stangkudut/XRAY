NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
BW='\e[30;48;5;15m'
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}              ----- [ Backup Menu ] -----              ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${NC}   ${RB}[1]${NC} ${GB}Auto Backup Data VPS${NC}                            ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[2]${NC} ${GB}Backup Data VPS${NC}                                 ${BB}║${NC}"
echo -e "${BB}║${NC}   ${RB}[3]${NC} ${GB}Restore Data VPS${NC}                                ${BB}║${NC}"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║                   ${RB}[0]${NC} Back To Menu                    ${BB}║${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; autobackup ; exit ;;
2) clear ; backup ; exit ;;
3) clear ; restore ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "salah tekan " ; sleep 1 ; vmess ;;
esac
