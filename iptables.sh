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
echo "          🧡 IPTABLES....SETTING UP YOUR FIREWALL 🧡    "
echo "                 💚 Resleeved Net Firewall 💚          "
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
netfilter-persistent save
netfilter-persistent reload
netfilter-persistent start
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.rmem_default=16777216
echo "net.core.rmem_max=16777216" >> /etc/sysctl.d/udp_buffer.conf
echo "net.core.rmem_default=16777216" >> /etc/sysctl.d/udp_buffer.conf
sysctl -w net.core.wmem_max=16777216
sysctl -w net.core.wmem_default=16777216
echo "net.core.wmem_max=16777216" >> /etc/sysctl.d/udp_buffer.conf
echo "net.core.wmem_default=16777216" >> /etc/sysctl.d/udp_buffer.conf
echo -e "$YELLOW"
echo "           🧡 FIREWALL CONFIGURED 🧡      "
echo "                 💚 Active 💚             "
echo -e "$NC"
exit 1
