#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
echo -e "\033[1;33mInstalling Badvpn Udp...\033[0m"
#Install Badvpn
cd /root
systemctl stop udpgw.service
systemctl disable udpgw.service
rm -rf /etc/systemd/system/udpgw.service
rm -rf /usr/bin/udpgw
cd /usr/bin
wget http://github.com/JohnReaJR/A/releases/download/V1/udpgw
chmod 755 udpgw
cd /root        
cat <<EOF >/etc/systemd/system/udpgw.service
[Unit]
Description=UDPGW Gateway Service by InFiNitY 
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/screen -dmS udpgw /bin/udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 1000
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
#start badvpn
systemctl enable udpgw.service
systemctl start udpgw.service
echo -e "$YELLOW"
echo "           💚 BADVPN INSTALLED SUCCESSFULLY 💚      "
echo "             ╰┈➤💚 BadVpn Activated 💚             "
echo -e "$NC"
X
exit 1
