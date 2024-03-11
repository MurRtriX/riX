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
echo "1.  Install UDP HYSTERIA"
echo "2.  CUSTOM UDP Exclude Hysteria"
echo "3.  CUSTOM UDP No Hysteria"
echo "4.  Install SOCKSIP UDP REQUEST"
echo "5.  Install DNSTT TUNNEL"
echo "6.  Install IODINE TUNNEL"
echo "7.  Install RESLEEVED NET FIREWALL"
echo "8.  Install V2RAY PANNEL"
echo "9.  RESET VPS"
echo "10. Install HYSTERIA V2 UDP"
echo "11. Install Mieru TCP"
echo "12. Exit Script" 
selected_option=0

while [ $selected_option -lt 1 ] || [ $selected_option -gt 12 ]; do
    echo -e "$YELLOW"
    echo "Select a number from 1 to 12:"
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
        rm -rf install8.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install8.sh" -O install8.sh >/dev/null 2>&1; chmod 755 install8.sh;./install8.sh; rm -rf install8.sh
        exit 1
        ;;
    2)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh 5,22,53,68,80,444,7300,20000-50000; rm -rf install10.sh
        exit 1
        ;;
    3)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh 22,53,68,7300; rm -rf install10.sh
        exit 1
        ;;
    4)
        rm -rf install6.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install6.sh" -O install6.sh >/dev/null 2>&1; chmod 755 install6.sh;./install6.sh; rm -rf install6.sh
        exit 1
        ;;
    5)
        rm -rf install3.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install3.sh" -O install3.sh >/dev/null 2>&1; chmod 755 install3.sh;./install3.sh; rm -rf install3.sh
        exit 1
        ;;
    6)
        rm -rf install4.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install4.sh" -O install4.sh >/dev/null 2>&1; chmod 755 install4.sh;./install4.sh; rm -rf install4.sh
        exit 1
        ;;
    7)
        rm -rf iptables.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/iptables.sh" -O iptables.sh >/dev/null 2>&1; chmod 755 iptables.sh;./iptables.sh; rm -rf iptables.sh
        exit 1
        ;;
    8)
        bash <(curl -Ls https://raw.githubusercontent.com/JohnReaJR/A/master/v2ray.sh)
        exit 1
        ;;
    9)
        rm -rf wipe.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/wipe.sh" -O wipe.sh >/dev/null 2>&1; chmod 755 wipe.sh;./wipe.sh; rm -rf wipe.sh
        exit 1
        ;;
    10)
        rm -rf install11.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install11.sh" -O install11.sh >/dev/null 2>&1; chmod 755 install11.sh;./install11.sh; rm -rf install11.sh
        exit 1
        ;;
    11)
        rm -rf install65.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install65.sh" -O install65.sh && chmod 755 install65.sh && ./install65.sh; rm -rf install65.sh
        exit 1
        ;;
    12)
        echo -e "$YELLOW"
        echo "     💚 RESLEEVED NET SCRIPT EXITED 💚     "
        echo "     ╰┈➤💚 Resleeved Net 💚         "
        echo " ╰┈➤ 💚 Telegram >>> t.me/Am_The_Last_Envoy 💚       "
        echo -e "$NC"
        exit 1
        ;;
esac
