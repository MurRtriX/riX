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
echo "          💚 IODINE DNS INSTALLATION SCRIPT 💚    "
echo "        ╰┈➤💚 Installing DNSTT Binaries 💚          "
echo -e "$NC"
apt-get update && apt-get upgrade
apt update && apt upgrade
ufw disable
apt-get remove --auto-remove ufw
apt-get purge ufw
apt-get purge --auto-remove ufw
apt-get remove ufw
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X 
iptables -Z
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -t raw -F
iptables -t raw -X
apt-get install iptables
apt-get install iptables-persistent
ip6tables -P INPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -F
ip6tables -X 
ip6tables -Z
ip6tables -t nat -F
ip6tables -t nat -X
ip6tables -t mangle -F
ip6tables -t mangle -X
ip6tables -t raw -F
ip6tables -t raw -X
iptables -A INPUT -p udp -m multiport –dports 53 -i eth0 -j ACCEPT
iptables -A OUTPUT -p udp -m multiport –dports 53 -o eth0 -j ACCEPT
iptables -A INPUT -i tap0 -j ACCEPT
sudo iptables -A OUTPUT -o tap0 -j ACCEP
iptables -A FORWARD -i tap0 -o eth0 -m state –state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -o tap0 -m state –state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
netfilter-persistent reload
netfilter-persistent start
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
rm -rf /root/dnstt
apt install -y git golang-go
git clone https://www.bamsoftware.com/git/dnstt.git
cd /root/dnstt/dnstt-server
go build
./dnstt-server -gen-key -privkey-file server.key -pubkey-file server.pub
echo -e "$YELLOW"
cat server.pub
read -p "Copy the pubkey above and press Enter when done"
read -p "Enter your Nameserver : " ns
screen -dmS slowdns ./dnstt-server -udp :5300 -privkey-file server.key $ns 127.0.0.1:22
echo -e "$NC"
echo -e "$YELLOW"
echo "           💚 DNSTT INSTALLED 💚      "
echo "           ╰┈➤💚 Active 💚             "
echo -e "$NC"
exit 1
