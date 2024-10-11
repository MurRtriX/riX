#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
rm -rf /etc/issue.net
x=$(/etc/issue.net)
sudo sed -i 's/#Banner none/Banner x/' /etc/ssh/sshd_config
exit 0
