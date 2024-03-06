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
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp -m multiport --dport 53 -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -j ACCEPT
iptables -A OUTPUT -p udp -m multiport --dport 53 -o $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -j ACCEPT
iptables -t nat -A PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 53 -j REDIRECT --to-ports 53
iptables -t nat -A PREROUTING -o $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport 53 -j REDIRECT --to-ports 53
netfilter-persistent save
netfilter-persistent reload
netfilter-persistent start
cd /root
rm -rf go
rm -rf /root/dnstt
apt-get remove ncat
apt-get remove --auto-remove ncat
apt-get purge ncat
apt-get purge --auto-remove ncat
apt install ncat
apt install -y git golang-go
git clone https://www.bamsoftware.com/git/dnstt.git
cd /root/dnstt/dnstt-server
go build
./dnstt-server -gen-key -privkey-file server.key -pubkey-file server.pub
echo -e "$YELLOW"
cat server.pub
read -p "Copy the pubkey above and press Enter when done"
read -p "Enter your Nameserver : " ns
screen -dmS slowdns ./dnstt-server -udp :53 -privkey-file server.key $ns 127.0.0.1:22
echo -e "$NC"
echo -e "$YELLOW"
echo "           💚 DNSTT INSTALLED 💚      "
echo "           ╰┈➤💚 Active 💚             "
echo -e "$NC"
exit 1
