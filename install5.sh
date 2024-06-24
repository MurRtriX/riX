#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
echo -e "$YELLOW"
echo "          💚 DNSTT INSTALLATION SCRIPT 💚    "
echo "        ╰┈➤💚 Installing DNSTT Binaries 💚          "
echo -e "$NC"
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 53 -j REDIRECT --to-ports 5300
ip6tables -I INPUT -p udp --dport 5300 -j ACCEPT
ip6tables -t nat -I PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 53 -j REDIRECT --to-ports 5300
netfilter-persistent save
netfilter-persistent reload
netfilter-persistent start
cd /root
systemctl stop dnstt-server.service
systemctl disable dnstt-server.service
rm -rf /etc/systemd/system/dnstt-server.service
rm -rf /root/dnstt
mkdir dnstt
cd dnstt
if [ ! -e "dnstt-linux-amd64" ]; then
    wget https://raw.githubusercontent.com/MurRtriX/riX/main/ns/dnstt-linux-amd64
fi
chmod 755 dnstt-linux-amd64
if [ -e "server.key" ]; then
    rm server.key
fi
if [ -e "server.pub" ]; then
    rm server.pub
fi
wget https://raw.githubusercontent.com/MurRtriX/riX/main/ns/server.key
wget https://raw.githubusercontent.com/MurRtriX/riX/main/ns/server.pub
echo -e "$YELLOW"
cat server.pub
read -p "Copy the pubkey above and press Enter when done"
read -p "Enter your Nameserver : " ns
##Dnstt Auto Service
cat <<EOF >/etc/systemd/system/dnstt-server.service
[Unit]
After=network.target nss-lookup.target

[Service]
User=root
WorkingDirectory=/root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
ExecStart=/root/dnstt/screen -dmS slowdns ./dnstt-linux-amd64 -udp :5300 -privkey-file /root/dnstt/server.key $ns 127.0.0.1:22
ExecReload=/bin/kill -HUP $MAINPID
Restart=always
RestartSec=2
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
##Activate Dnstt
screen -dmS slowdns ./dnstt-linux-amd64 -udp :5300 -privkey-file server.key $ns 127.0.0.1:22
echo -e "$NC"
echo -e "$YELLOW"
echo "           💚 DNSTT INSTALLED 💚      "
echo "           ╰┈➤💚 Active 💚             "
echo -e "$NC"
X
exit 1
