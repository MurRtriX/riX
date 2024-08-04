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
echo -e "$YELLOW
💚 HYSTERIA INSTALLATIONS 💚      
╰┈➤ 💚 Resleeved Net 💚               "$NC
echo ""          
echo -e "$YELLOW Hysteria UDP Services "$NC
 echo -e "\033[1;32m 1.  New Obfs \033[0m"
 echo -e "\033[1;32m 2.  Auth Logins \033[0m"
 echo -e "\033[1;32m 3.  Active Auth  \033[1;0m"
 echo -e "\033[1;32m 4.  Exit \033[0m"
 selected_option=0

while [ $selected_option -lt 1 ] || [ $selected_option -gt 4 ]; do
    echo -e "\033[1;33m Select a number from 1 to 4: \033[0m"
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
        echo -e "$YELLOW"
        old_pwd=$(cat /root/hy/config.json | grep obfs | awk -F',' 'NR == 1 {split($10,a,":");print a[2]}' | sed "s/\"//g" | sed "s/,//g")
        read -p "Set New obfs :  " obfs_pwd
        echo -e "$NC"
        [[ -z $obfs_pwd ]] && obfs_pwd=$(date +%s%N | md5sum | cut -c 1-16)
        echo -e "\033[1;32mThe New obfs: $obfs_pwd\033[0m"
        sed -i "s/\"obfs\":\"$old_pwd\"/\"obfs\":\"$obfs_pwd\"/" /root/hy/config.json
        systemctl restart hysteria-server.service
        sleep 2
        exit 1
        ;;
    2)
            echo -e "\033[1;33mActive auth: \033[1;36m(\033[1;33m $(awk -F, 'NR==1 { print }' /root/hy/authusers | sed "s/\"/ /g" | sed "s/,/ /g") \033[1;36m)\033[0m"
            rm -rf /root/hy/authusers
            echo -e "\033[1;32mFor Multiple Auth str Separate with commas ( ex: a,b,c )\033[0m"
            echo -e "$YELLOW"
            read -p "Auth Str : " input_config
            echo -e "$NC"
            if [ -n "$input_config" ]; then
                IFS=',' read -r -a config <<< "$input_config"
                if [ ${#config[@]} -eq 1 ]; then
                    config+=(${config[0]})
                fi
            else
                echo -e "$YELLOW"
                echo "Enter auth separated by commas"
                echo -e "$NC"
            fi
        echo "$input_config" > /root/hy/authusers
        auth_str=$(printf "\"%s\"," "${config[@]}" | sed 's/,$//')
        remote_udp_port=$(cat /root/hy/config.json | grep listen | awk -F',' 'NR == 1 {split($1,a,":");print a[3]}' | sed "s/\"//g" | sed "s/,//g")
        obfs=$(cat /root/hy/config.json | grep obfs | awk -F',' 'NR == 1 {split($10,a,":");print a[2]}' | sed "s/\"//g" | sed "s/,//g")
        rm -rf /root/hy/config.json
        file_path="/root/hy/config.json"
        json_content='{"listen":":'"$remote_udp_port"'","protocol":"udp","cert":"/root/hy/ca.crt","key":"/root/hy/ca.key","up":"100 Mbps","up_mbps":100,"down":"100 Mbps","down_mbps":100,"disable_udp":false,"obfs":"'"$obfs"'","auth":{"mode":"passwords","config":['"$auth_str"']}}'
        echo "$json_content" > "$file_path"
        if [ ! -e "$file_path" ]; then
            echo -e "$YELLOW"
            echo "Error: Unable to save the config.json file"
            echo -e "$NC"
            exit 1
        fi
        chmod 755 /root/hy/config.json
        systemctl restart hysteria-server.service
        sleep 2
        exit 1
        ;;
    3)
        echo ""
        echo -e "\033[1;33mActive Auth/Passwords\033[0m"
        echo ""
        echo -e "\033[1;32m$(awk -F, 'NR==1 { print }' /root/hy/authusers | sed "s/\"//g" | sed "s/,/                                                                         /g")\033[0m"
        echo -e "\033[1;33m───────────────────────•\033[0m"
        read -p "Press any key to exit ↩︎" key
        exit 1
        ;;
    4)
        clear; X
        exit 1
        ;;
esac
