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
echo "          💚 IPTABLES....SETTING UP YOUR FIREWALL 💚    "
echo "             ╰┈➤💚 Resleeved Net Firewall 💚          "
echo -e "$NC"
rm -f /etc/sysctl.conf
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.$(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1).rp_filter=0
echo "net.ipv4.ip_forward=1
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.$(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1).rp_filter=0" >> /etc/sysctl.conf
sysctl -p
sysctl -w net.core.rmem_default=212992
sysctl -w net.core.wmem_default=212992
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w net.ipv4.tcp_congestion_control=bbr
echo "net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
echo "net.core.rmem_default=212992" >> /etc/sysctl.conf
echo "net.core.wmem_default=212992" >> /etc/sysctl.conf
echo "net.core.rmem_max=16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max=16777216" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time=7200" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes=9" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl=75" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
echo -e "$YELLOW"
echo "           💚 FIREWALL CONFIGURED 💚      "
echo "              ╰┈➤💚 Active 💚             "
echo -e "$NC"
exit 1
