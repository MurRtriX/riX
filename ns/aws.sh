#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/; s/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/; s/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config; sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf; sudo systemctl restart ssh; sudo sh -c "echo /bin/false >> /etc/shells" chsh -s /bin/false; sudo hostnamectl set-hostname Resleeved; sudo sh -c "echo 127.0.1.1 Resleeved >> /etc/hosts" chsh -s 127.0.1.1 Resleeved; echo -e "\033[1;33mEnter Your New root Password \033[0m"; sudo passwd root; exec bash
