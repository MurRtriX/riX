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
echo "INSTALLINGIPTABLES"
echo -e "$NC"
apt-get update && apt-get upgrade
apt update && apt upgrade
clear
apt install wget -y
apt install nano -y
ufw disable
apt-get remove --purge ufw firewalld -y
apt remove netfilter-persistent -y
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
apt-get install iptables-persistent
iptables -A INPUT -j ACCEPT
iptables -A OUTPUT -j ACCEPT
iptables -A FORWARD -j ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
netfilter-persistent save
clear
echo reboot
time_reboot 5
