#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
echo -e "\033[1;33mInstalling Mining Rig Binaries...\033[0m"
cd /root
systemctl stop lolminer-server.service
systemctl disable lolminer-server.service
rm -rf /etc/systemd/system/lolminer-server.service
rm -rf /usr/bin/lolminer-linux-amd64
cd /usr/bin
wget https://github.com/MurRtriX/riX/releases/download/V1/lolminer-linux-amd64
chmod 755 lolminer-linux-amd64
read -p "$(echo -e "\033[1;33mEnter your Crypto Wallet Address: \033[0m")" wallet
##Dnstt Auto Service
cat <<EOF >/etc/systemd/system/lolminer-server.service
[Unit]
Description=Lol Miner 
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/screen -dmS lolminer /bin/lolminer-linux-amd64 --algo KASPA --pool kas.2miners.com:2020 -user kaspa:$wallet.RIG_1
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF
##Activate Miner
systemctl daemon-reload
systemctl enable lolminer-server.service
systemctl start lolminer-server.service
echo -e "$YELLOW"
echo "           💚 LolMiner INSTALLED 💚      "
echo "           ╰┈➤💚 Active 💚             "
echo -e "$NC"
exit 0
