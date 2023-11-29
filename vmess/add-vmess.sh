NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
BW='\e[30;48;5;15m'
clear
domain=$(cat /usr/local/etc/xray/domain)
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}          ----- [ Add Vmess Account ] -----            ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
read -rp "User: " -e user
CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${BW}          ----- [ Add Vmess Account ] -----            ${NC}${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BB}║${RB}A client with the specified name was already created, please choose another name.${NC}"
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
read -n 1 -s -r -p "Press any key to back on menu"
add-vmess
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\#@ '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vmess-grpc$/a\#@ '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
vlink1=`cat << EOF
{
"v": "2",
"ps": "$user",
"add": "$domain",
"port": "443",
"id": "$uuid",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "$domain",
"tls": "tls"
}
EOF`
vlink2=`cat << EOF
{
"v": "2",
"ps": "$user",
"add": "$domain",
"port": "80",
"id": "$uuid",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "$domain",
"tls": "none"
}
EOF`
vlink3=`cat << EOF
{
"v": "2",
"ps": "$user",
"add": "$domain",
"port": "443",
"id": "$uuid",
"aid": "0",
"net": "grpc",
"path": "vmess-grpc",
"type": "none",
"host": "$domain",
"tls": "tls"
}
EOF`
vmesslink1="vmess://$(echo $vlink1 | base64 -w 0)"
vmesslink2="vmess://$(echo $vlink2 | base64 -w 0)"
vmesslink3="vmess://$(echo $vlink3 | base64 -w 0)"
cat > /var/www/html/vmess/vmess-$user.txt << END
==========================
Vmess WS (CDN) TLS
==========================
- name: Vmess-$user
type: vmess
server: ${domain}
port: 443
uuid: ${uuid}
alterId: 0
cipher: auto
udp: true
tls: true
skip-cert-verify: true
servername: ${domain}
network: ws
ws-opts:
path: /vmess
headers:
Host: ${domain}
==========================
Vmess WS (CDN)
==========================
- name: Vmess-$user
type: vmess
server: ${domain}
port: 80
uuid: ${uuid}
alterId: 0
cipher: auto
udp: true
tls: false
skip-cert-verify: false
servername: ${domain}
network: ws
ws-opts:
path: /vmess
headers:
Host: ${domain}
==========================
Vmess gRPC (CDN)
==========================
- name: Vmess-$user
server: $domain
port: 443
type: vmess
uuid: $uuid
alterId: 0
cipher: auto
network: grpc
tls: true
servername: $domain
skip-cert-verify: true
grpc-opts:
grpc-service-name: "vmess-grpc"
==========================
Link Vmess Account
==========================
Link TLS  : vmess://$(echo $vlink1 | base64 -w 0)
==========================
Link NTLS : vmess://$(echo $vlink2 | base64 -w 0)
==========================
Link gRPC : vmess://$(echo $vlink3 | base64 -w 0)
==========================
END
ISP=$(cat /usr/local/etc/xray/org)
CITY=$(cat /usr/local/etc/xray/city)
systemctl restart xray
clear
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${BW}            ----- [ Vmess Account ] -----              ${NC}${BB}║${NC} " | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Remarks       : $user" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} ISP           : $ISP" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} City          : $CITY" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Domain        : $domain" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Wildcard      : (bug.com).$domain" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Port TLS      : 443" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Port NTLS     : 80" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Port gRPC     : 443" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Alt Port TLS  : 2053, 2083, 2087, 2096, 8443" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Alt Port NTLS : 8080, 8880, 2052, 2082, 2086, 2095" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} id            : $uuid" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} AlterId       : 0" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Security      : auto" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Network       : Websocket" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Path          : /(multipath) • ubah suka-suka" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} ServiceName   : vmess-grpc" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}║${NC} Alpn          : h2, http/1.1" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${NC} Link TLS      : $vmesslink1" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${NC} Link NTLS     : $vmesslink2" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${NC} Link gRPC     : $vmesslink3" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${NC} Format Clash  : http://$domain:8000/vmess/vmess-$user.txt" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║${NC} Expired On    : $exp" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}" | tee -a /user/log-vmess-$user.txt
echo -e "${BB}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BB}║                  ${RB}Tap Enter To Go Back                 ${BB}║${NC} "
echo -e "${BB}╚═══════════════════════════════════════════════════════╝${NC}"
echo " " | tee -a /user/log-vmess-$user.txt
echo " " | tee -a /user/log-vmess-$user.txt
echo " " | tee -a /user/log-vmess-$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
clear
vmess
