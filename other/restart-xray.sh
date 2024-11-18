#!/bin/bash
# ==========================================
# Color
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
# ==========================================
#information
OK="${GB}[OK]${NC}"
Error="${RB}[Mistake]${NC}"
clear
echo -e "${OK}Please Wait..."${NC}
systemctl daemon-reload
systemctl enable xray
systemctl restart xray
systemctl restart nginx
clear
echo "${OK}Xray.service berhasil di restart"${NC}
sleep 3
menu
