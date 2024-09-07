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
echo ""
echo -e "\033[1;33mWarp Installations \033[0m"
echo -e "\033[32m1. WARP HYSTERIA \033[0m"
echo -e "\033[32m2. WARP UDP CUSTOM \033[0m"
echo -e "\033[32m3. WARP DNSTT TUNNEL \033[0m"
echo -e "\033[32m4. WARP LINKLAYERVPN \033[0m"
echo -e "\033[32m5. AMAZON AWS RESLEEVED \033[0m"
echo -e "\033[32m6. ZIVPN UDP INSTALLER \033[0m"
echo -e "\033[32m0. Exit \033[0m"
# Select an Option

    read -p "$(echo -e "\033[1;33mSelect a number from 0 to 6: \033[0m")" input
    
    # Check if input is a number
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        selected_option=$input
    else
        echo -e "$YELLOW"
        echo "Invalid input. Please enter a valid number."
        echo -e "$NC"
    fi
clear
case $selected_option in
    1)
        rm -rf install54.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install54.sh" -O install54.sh && chmod 755 install54.sh && ./install54.sh; rm -rf install54.sh
        exit 0
        ;;
    2)
        rm -rf install10.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install10.sh" -O install10.sh && chmod 755 install10.sh && ./install10.sh; rm -rf install10.sh
        exit 0
        ;;
    3)
        rm -rf install5.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/install5.sh" -O install5.sh && chmod 755 install5.sh && ./install5.sh; rm -rf install5.sh
        exit 0
        ;;
    4)
        rm -rf ant.sh; wget "https://raw.githubusercontent.com/JohnReaJR/M/main/ant.sh" -O ant.sh && chmod 755 ant.sh && ./ant.sh; rm -rf ant.sh
        cd /etc/V/bin; ./W.sh
        exit 0
        ;;
    5)
        cd /etc/V/bin; ./aws.sh
        exit 0
        ;;
    6)
        rm -rf zz.sh; wget "https://raw.githubusercontent.com/MurRtriX/riX/main/o/ziv/zz.sh" -O zz.sh && chmod 755 zz.sh && ./zz.sh; rm -rf zz.sh
        exit 0
        ;;
    *)
        clear; X
        exit 0
        ;;
esac
done
