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
cat <<EOF >/etc/issue.net
<!--- Resleeved Net Banner--->

<font color="white">
<H3 style="text-align:left">
Telegram Links</span></ H3>

<H3 style="text-align:left">
T.me/Am_The_Last_Envoy</span></H3>

<H3 style="text-align:left">
T.me/VeCNa_rK_bot</span></H3>

<H3 style="text-align:left">
Resleeved Net </span></H3>

<H3 style="text-align:left">
нєιι 🤍 нαωkiиѕ</span></H3>
<font>
EOF
x="/etc/issue.net"
sudo sed -i 's/#Banner none/Banner /etc/issue.net/' /etc/ssh/sshd_config
sudo service sshd restart
exit 0
