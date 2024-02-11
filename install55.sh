#!/bin/bash
is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
echo -e "$YELLOW
 💚 RESLEEVED NET AUTO INSTALLER 💚      
   ╰┈➤ 💚 Resleeved Net 💚               "
echo -e "$NC
Select an option"
echo "1. Install UDP HYSTERIA"
echo "2. Install HTTP CUSTOM UDP"
echo "3. Install SOCKSIP UDP REQUEST"
echo "4. Install DNSTT TUNNEL"
echo "5. Install IODINE TUNNEL"
echo "6. Install RESLEEVED NET FIREWALL"
echo "7. Install V2RAY PANNEL"
echo "8. RESET VPS"
echo "9. Install HYSTERIA V2 UDP"
echo "10. Exit Script" 
selected_option=0

while [ $selected_option -lt 1 ] || [ $selected_option -gt 10 ]; do
    echo -e "$YELLOW"
    echo "Select a number from 1 to 10:"
    echo -e "$NC"
    read input

    # Check if input is a number
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        selected_option=$input
    else
        echo -e "$YELLOW"
        echo "Invalid input. Please enter a valid number."
        echo -e "$NC"
    fi
done
clear
case $selected_option in
    1)
        rm -f install8.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install8.sh" -O install8.sh >/dev/null 2>&1; chmod 755 install8.sh;./install8.sh; rm -f install8.sh
        exit 1
        ;;
    2)
        rm -f install10.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh 22,53,68,444,7300,20000-50000; rm -f install10.sh
        exit 1
        ;;
    3)
        rm -f install6.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install6.sh" -O install6.sh >/dev/null 2>&1; chmod 755 install6.sh;./install6.sh; rm -f install6.sh
        exit 1
        ;;
    4)
        rm -f install3.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install3.sh" -O install3.sh >/dev/null 2>&1; chmod 755 install3.sh;./install3.sh; rm -f install3.sh
        exit 1
        ;;
    5)
        rm -f install4.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install4.sh" -O install4.sh >/dev/null 2>&1; chmod 755 install4.sh;./install4.sh; rm -f install4.sh
        exit 1
        ;;
    6)
        rm -f iptables.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/iptables.sh" -O iptables.sh >/dev/null 2>&1; chmod 755 iptables.sh;./iptables.sh; rm -f iptables.sh
        exit 1
        ;;
    7)
        bash <(curl -Ls https://raw.githubusercontent.com/JohnReaJR/A/master/v2ray.sh)
        exit 1
        ;;
    8)
        rm -f wipe.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/wipe.sh" -O wipe.sh >/dev/null 2>&1; chmod 755 wipe.sh;./wipe.sh; rm -f wipe.sh
        exit 1
        ;;
    9)
        rm -f install11.sh; apt-get update -y; apt-get upgrade -y; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install11.sh" -O install11.sh >/dev/null 2>&1; chmod 755 install11.sh;./install11.sh; rm -f install11.sh
        exit 1
        ;;
    10)
        echo -e "$YELLOW"
        echo "     💚 RESLEEVED NET SCRIPT EXITED 💚     "
        echo "     ╰┈➤💚 Resleeved Net 💚         "
        echo " ╰┈➤ 💚 Telegram >>> t.me/Am_The_Last_Envoy 💚       "
        echo -e "$NC"
        exit 1
        ;;
esac
