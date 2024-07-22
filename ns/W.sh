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
echo -e "$YELLOW Warp Services "$NC
 echo -e "\033[32m 1.  WARP HYSTERIA \033[0m"
 echo -e "\033[32m 2.  WARP UDP CUSTOM \033[0m"
 echo -e "\033[32m 3.  WARP DNSTT TUNNEL \033[0m"
 echo -e "\033[32m 4.  WARP LINKLAYERVPN \033[0m"
 echo -e "\033[32m 5.  Exit \033[0m"
 selected_option=0

while [ $selected_option -lt 1 ] || [ $selected_option -gt 5 ]; do
    echo -e "\033[1;33m Select a number from 1 to 5: \033[0m"
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
        rm -rf install8.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install8.sh" -O install8.sh && chmod 755 install8.sh && ./install8.sh; rm -rf install8.sh
        exit 1
        ;;
    2)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh 5,22,53,68,80,143,444,445,5050,5300,7300,8080,9090,20000-50000; rm -rf install10.sh
        exit 1
        ;;
    3)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh 5,22,53,68,80,143,444,445,5050,5300,7300,8080,9090; rm -rf install10.sh
        exit 1
        ;;
    4)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/JohnReaJR/A/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh 5,22,53,68,80,143,444,445,5050,5300,7300,8080,9090; rm -rf install10.sh
        exit 1
        ;;
    5)
        clear; X
        exit 1
        ;;
esac
