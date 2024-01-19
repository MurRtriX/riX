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
apt-get install iptables-persistent
iptables -A INPUT -j ACCEPT
iptables -A OUTPUT -j ACCEPT
iptables -A FORWARD -j ACCEPT
netfilter-persistent save
sudo systemctl enable iptables
sudo systemctl start iptables
echo -e "$YELLOW"
echo "🧡 FIREWALL CONFIGURED..... 🧡"
echo "💚 REBOOTING........ 💚"
echo -e "$NC"
reboot
