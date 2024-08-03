#!/bin/bash
is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}
YELLOW='\033[1;33m'
NC='\033[0m'
T_BOLD=$(tput bold)
T_GREEN=$(tput setaf 2)
T_YELLOW=$(tput setaf 3)
T_RED=$(tput setaf 1)
T_RESET=$(tput sgr0)
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
cd /root
clear
echo -e "$YELLOW
💚 ALL HYSTERIA UDP INSTALLATIONS 💚      
    ╰┈➤ 💚 Resleeved Net 💚               "$NC
echo ""          
echo -e "$YELLOW Warp Services "$NC
 echo -e "\033[32m 1.  Change Obfs \033[0m"
 echo -e "\033[32m 2.  Auth ( Separate with commas ex: a,b,c \033[0m"
 echo -e "\033[32m 3.  WARP DNSTT TUNNEL \033[0m"
 echo -e "\033[32m 4.  WARP LINKLAYERVPN \033[0m"
 echo -e "\033[32m 5.  AMAZON AWS RESLEEVED \033[0m"
 echo -e "\033[32m 6.  Exit \033[0m"
 selected_option=0

while [ $selected_option -lt 1 ] || [ $selected_option -gt 6 ]; do
    echo -e "\033[1;33m Select a number from 1 to 6: \033[0m"
    read -p " " input
    
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
        rm -rf install54.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install54.sh" -O install54.sh && chmod 755 install54.sh && ./install54.sh; rm -rf install54.sh
        X
        exit 1
        ;;
    2)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh; rm -rf install10.sh
        X
        exit 1
        ;;
    3)
        rm -rf install5.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install5.sh" -O install5.sh && chmod 755 install5.sh && ./install5.sh; rm -rf install5.sh
        X
        exit 1
        ;;
    4)
        rm -rf ant.sh; wget "https://raw.githubusercontent.com/JohnReaJR/M/main/ant.sh" -O ant.sh && chmod 755 ant.sh && ./ant.sh; rm -rf ant.sh
        X
        exit 1
        ;;
    5)
        cd /etc/V/bin; ./aws.sh
        exit 1
        ;;
    6)
        clear; X
        exit 1
        ;;
esac
