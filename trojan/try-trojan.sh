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
domain=$(cat /usr/local/etc/xray/domain)
user=trial-`echo $RANDOM | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=1
echo ""
echo ""
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojan$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#trojan-grpc$/a\#& '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
trojanlink1="trojan://$uuid@$domain:443?path=/trojan&security=tls&host=$domain&type=ws&sni=$domain#$user"
trojanlink2="trojan://${uuid}@$domain:80?path=/trojan&security=none&host=$domain&type=ws#$user"
trojanlink3="trojan://${uuid}@$domain:443?security=tls&encryption=none&type=grpc&serviceName=trojan-grpc&sni=$domain#$user"
cat > /var/www/html/trojan/trojan-$user.txt << END
==========================
Trojan WS (CDN) TLS
==========================
- name: Trojan-$user
server: $domain
port: 443
type: trojan
password: $uuid
network: ws
sni: $domain
skip-cert-verify: true
udp: true
ws-opts:
path: /trojan
headers:
Host: $domain
==========================
Trojan gRPC (CDN)
==========================
- name: Trojan-$user
server: $domain
port: 443
type: trojan
password: $uuid
network: grpc
sni: $domain
skip-cert-verify: true
udp: true
grpc-opts:
grpc-service-name: "trojan-grpc"
==========================
Link Trojan Account
==========================
Link TLS  : trojan://$uuid@$domain:443?path=/trojan&security=tls&host=$domain&type=ws&sni=$domain#$user
==========================
Link NTLS : trojan://${uuid}@$domain:80?path=/trojan&security=none&host=$domain&type=ws#$user
==========================
Link gRPC : trojan://${uuid}@$domain:443?security=tls&encryption=none&type=grpc&serviceName=trojan-grpc&sni=$domain#$user
==========================
END
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${BW}          ----- [ Try Trojan Account ] -----            ${NC}${BB}║${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Remarks       : ${user}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} ISP           : $ISP" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} City          : $CITY" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Host/IP       : ${domain}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Wildcard      : (bug.com).${domain}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Port TLS      : 443" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Port NTLS     : 80" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Port gRPC     : 443" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Alt Port TLS  : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Alt Port NTLS : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Password      : ${uuid}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Network       : Websocket, gRPC" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Path          : /trojan" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} ServiceName   : trojan-grpc" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}║${NC} Alpn          : h2, http/1.1" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "Link TLS      : ${trojanlink1}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "Link NTLS     : ${trojanlink2}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "Link gRPC     : ${trojanlink3}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "Format Clash  : http://$domain:8000/trojan/trojan-$user.txt" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "Expired On    : $exp" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-trojan-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║                  ${RB}Tap Enter To Go Back                 ${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo " " | tee -a /user/log-trojan-$user.txt
echo " " | tee -a /user/log-trojan-$user.txt
echo " " | tee -a /user/log-trojan-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
trojan
