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
rm -f /etc/sysctl.d/udp_buffer.conf
rm -f /etc/sysctl.conf
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.$(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1).rp_filter=0
echo "net.ipv4.ip_forward = 1
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.$(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1).rp_filter=0" > /etc/sysctl.conf
sysctl -p
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w net.core.rmem_default=212992
sysctl -w net.core.wmem_default=212992
sysctl -w net.netfilter.nf_conntrack_udp_timeout=30
sysctl -w net.netfilter.nf_conntrack_udp_timeout_stream=120
sysctl -w vm.swappiness=10
sysctl -w vm.dirty_ratio=60
sysctl -w vm.dirty_background_ratio=2
sysctl -w fs.file-max=1000000
sysctl -w net.ipv4.neigh.default.proxy_qlen=64
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.inet_peer_threshold=65664
sysctl -w net.ipv4.inet_peer_minttl=120
sysctl -w net.ipv4.inet_peer_maxttl=600
sysctl -w net.ipv4.tcp_sack=1
sysctl -w net.ipv4.tcp_adv_win_scale=3
sysctl -w net.ipv4.ipfrag_time=30
sysctl -w net.ipv4.ipfrag_low_thresh=196608
sysctl -w net.ipv4.tcp_tw_reuse=1
sysctl -w net.ipv4.tcp_window_scaling=1
sysctl -w net.ipv4.tcp_timestamps=1
sysctl -w net.ipv4.tcp_no_metrics_save=0
sysctl -w net.ipv4.tcp_slow_start_after_idle=0
sysctl -w net.ipv4.udp_rmem_min=16384
sysctl -w net.ipv4.tcp_orphan_retries=0
sysctl -w net.ipv4.tcp_max_orphans=16384
sysctl -w net.ipv4.tcp_tw_reuse=1
sysctl -w net.ipv4.tcp_max_tw_buckets=1440000
sysctl -w net.ipv4.udp_wmem_min=16384
sysctl -w net.core.netdev_budget=500
sysctl -w net.core.netdev_max_backlog=65536
sysctl -w net.core.optmem_max=20480
sysctl -w net.core.somaxconn=65535
sysctl -w net.netfilter.nf_conntrack_max=1048576
sysctl -w net.ipv4.neigh.default.unres_qlen=101
sysctl -w net.ipv4.tcp_fin_timeout=15
sysctl -w net.ipv4.tcp_rfc1337=1
sysctl -w net.ipv4.tcp_keepalive_intvl=15
sysctl -w net.ipv4.tcp_keepalive_probes=5
sysctl -w net.ipv4.tcp_keepalive_time=300
sysctl -w net.ipv4.tcp_syn_retries=2
sysctl -w net.ipv4.tcp_synack_retries=2
sysctl -w net.ipv4.tcp_syncookies=0
sysctl -w net.ipv4.tcp_max_syn_backlog=4096
echo "net.core.rmem_max=16777216" >> /etc/sysctl.conf
echo "net.core.wmem_max=16777216" >> /etc/sysctl.conf
echo "net.core.rmem_default=212992" >> /etc/sysctl.conf
echo "net.core.wmem_default=212992" >> /etc/sysctl.conf
echo "net.core.optmem_max=20480" >> /etc/sysctl.conf
echo "net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range=1024 65535" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem=32768 524288 16777216" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem=32768 524288 16777216" >> /etc/sysctl.conf
echo "net.core.udp_mem=764349  1019133 1528698" >> /etc/sysctl.conf
echo "net.core.tcp_mem=382173  509566  764346" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_udp_timeout=30" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_udp_timeout_stream=120" >> /etc/sysctl.conf
echo "net.core.somaxconn=65535" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_max=1048576" >> /etc/sysctl.conf
echo "net.ipv4.neigh.default.unres_qlen=101" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout=15" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rfc1337=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl=15" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes=5" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time=300" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syn_retries=2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_synack_retries=2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies=0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog=4096" >> /etc/sysctl.conf
echo "net.ipv4.neigh.default.proxy_qlen=64" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_source_route=0" >> /etc/sysctl.conf
echo "net.ipv4.inet_peer_threshold=65664" >> /etc/sysctl.conf
echo "net.ipv4.inet_peer_minttl=120" >> /etc/sysctl.conf
echo "net.ipv4.inet_peer_maxttl=600" >> /etc/sysctl.conf
echo "net.ipv4.tcp_sack=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_adv_win_scale=3" >> /etc/sysctl.conf
echo "net.ipv4.ipfrag_time=30" >> /etc/sysctl.conf
echo "net.ipv4.ipfrag_low_thresh=196608" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_timestamps=1" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_no_metrics_save=0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_slow_start_after_idle=0" >> /etc/sysctl.conf
echo "net.ipv4.udp_rmem_min=16384" >> /etc/sysctl.conf
echo "net.ipv4.tcp_orphan_retries=0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_orphans=16384" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets=1440000" >> /etc/sysctl.conf
echo "net.ipv4.udp_wmem_min=16384" >> /etc/sysctl.conf
echo "net.core.netdev_budget=500" >> /etc/sysctl.conf
echo "fs.file-max=1000000" >> /etc/sysctl.conf
echo "net.core.netdev_max_backlog=65536" >> /etc/sysctl.conf
echo "vm.swappiness=10" >> /etc/sysctl.conf
echo "vm.dirty_ratio=60" >> /etc/sysctl.conf
echo "vm.dirty_background_ratio=2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_synack_retries=2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies=0" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syn_retries=2" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog=4096" >> /etc/sysctl.conf
echo "net.ipv4.neigh.default.proxy_qlen=64" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
echo -e "$YELLOW"
echo "           🧡 FIREWALL CONFIGURED 🧡      "
echo "                 💚 Active 💚             "
echo -e "$NC"
exit 1
