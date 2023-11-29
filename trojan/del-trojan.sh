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
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/usr/local/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}        ----- [ Delete Trojan Account ] -----          ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║        ${RB}You have no existing clients!${NC}            ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
trojan
fi
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}        ----- [ Delete Vmess Account ] -----           ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${CB}User       ${RB}Expired${NC}                                     ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
grep -E "^#& " "/usr/local/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║                  ${RB}Tap Enter To Go Back                 ${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
read -rp "Input Username : " user
if [ -z $user ]; then
trojan
else
exp=$(grep -wE "^#& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
rm -rf /var/www/html/trojan/trojan-$user.txt
rm -rf /user/log-trojan-$user.txt
systemctl restart xray
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}    ----- [ Trojan Account has been Deleted ] -----    ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║ ${WB}Client Name :${NC} $user"
echo -e "${BB}║ ${WB}Expired On  :${NC} $exp"
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║                  ${RB}Tap Enter To Go Back                 ${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
clear
trojan
fi
