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
iptables -t nat -I PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 53 -j DNAT --to-destination $(curl -s https://api.ipify.org):5300
ip6tables -I INPUT -p udp --dport 5300 -j ACCEPT
ip6tables -t nat -I PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 53 -j DNAT --to-destination $(curl -6 icanhazip.com):5300
netfilter-persistent save
netfilter-persistent reload
netfilter-persistent start
cd /root
systemctl stop dnstt-server.service
systemctl disable dnstt-server.service
rm -rf /etc/systemd/system/dnstt-server.service
rm -rf /usr/bin/dnstt-linux-amd64
cd /usr/bin
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
cd /root
echo -e "$YELLOW"
cat /usr/bin/server.pub
read -p "Copy the pubkey above and press Enter when done"
read -p "Enter your Nameserver : " ns
echo -e "$NC"
##Dnstt Auto Service
cat <<EOF >/etc/systemd/system/dnstt-server.service
[Unit]
Description=UDPGW Gateway Service by InFiNitY 
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/screen -dmS dnstt /bin/dnstt-linux-amd64 -udp $(curl -s https://api.ipify.org):5300 -privkey-file /usr/bin/server.key $ns 127.0.0.1:22
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
##Activate Dnstt
systemctl daemon-reload
systemctl enable dnstt-server.service
systemctl start dnstt-server.service
echo -e "$YELLOW"
echo "           💚 DNSTT INSTALLED 💚      "
echo "           ╰┈➤💚 Active 💚             "
echo -e "$NC"
X
exit 1
