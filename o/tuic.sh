#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
echo -e "\033[1;33mInstalling TUIC Udp...\033[0m"
#Install Tuic UDP
cd /root
apt install uuid-runtime
systemctl stop tuic-server.service
systemctl disable tuic-server.service
rm -rf /etc/systemd/system/tuic-server.service
rm -rf /root/tuic
mkdir tuic
cd tuic
wget -O tuic-linux-amd64 https://github.com/EAimTY/tuic/releases/download/tuic-server-1.0.0/tuic-server-1.0.0-x86_64-unknown-linux-gnu
chmod 755 tuic-linux-amd64
openssl ecparam -genkey -name prime256v1 -out ca.key
openssl req -new -x509 -days 36500 -key ca.key -out ca.crt -subj "/CN=bing.com"
uid=$(uuidgen)
echo ""
read -p "$(echo -e "\033[1;32mPort: \033[0m")" port
echo ""
echo -e "\033[1;33mCreate Tuic Password\033[0m"
read -p "$(echo -e "\033[1;32mPassword: \033[0m")" password
cat <<EOF >/root/tuic/config.json
{
"server": "[::]:$port",
"users": {
"$uid": "$password"
},
"certificate": "/root/tuic/ca.crt",
"private_key": "/root/tuic/ca.key",
"congestion_control": "bbr",
"alpn": ["h3", "spdy/3.1"],
"udp_relay_ipv6": true,
"zero_rtt_handshake": false,
"dual_stack": true,
"auth_timeout": "3s",
"task_negotiation_timeout": "3s",
"max_idle_time": "10s",
"max_external_packet_size": 1500,
"send_window": 16777216,
"receive_window": 8388608,
"gc_interval": "3s",
"gc_lifetime": "15s",
"log_level": "warn"
}
EOF
#Create Tuic Service
cat <<EOF >/etc/systemd/system/tuic-server.service
[Unit]
Description=tuic service
Documentation=by ResleevedNet
After=network.target nss-lookup.target

[Service]
User=root
WorkingDirectory=/root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
ExecStart=/root/tuic/tuic-linux-amd64 -c /root/tuic/config.json
Restart=on-failure
RestartSec=10
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
#start TUIC udp
systemctl enable tuic-server.service
systemctl start tuic-server.service
echo -e "$YELLOW"
echo "           💚 TUic INSTALLED SUCCESSFULLY 💚      "
echo "             ╰┈➤💚 Tuic Activated 💚             "
echo -e "$NC"
exit 1
