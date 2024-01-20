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
echo "🧡 IPTABLES....SETTING UP YOUR FIREWALL.... 🧡"
echo "          💚 Resleeved Net Firewall 💚          "
echo -e "$NC"
apt-get update && apt-get upgrade
apt update && apt upgrade
apt install wget -y
apt install nano -y
apt-get install tcpdump
ufw disable
apt-get remove --auto-remove ufw
apt-get purge ufw
apt-get purge --auto-remove ufw
apt-get remove ufw
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -F
iptables -X
apt-get install iptables 
apt-get install iptables-persistent
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A FORWARD -i lo -j ACCEPT
iptables -A FORWARD -o lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A INPUT -j ACCEPT
iptables -A OUTPUT -j ACCEPT
iptables -A FORWARD -j ACCEPT
netfilter-persistent save
netfilter-persistent reload
netfilter-persistent enable
netfilter-persistent start
echo -e "$YELLOW"
echo "🧡 FIREWALL CONFIGURED..... 🧡"
echo "💚 REBOOTING........ 💚"
echo -e "$NC"
reboot
