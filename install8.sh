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
      💚 RESLEEVED NET HYSTERIA SCRIPT 💚      
        ╰┈➤ 💚 Resleeved Net 💚             "
echo -e "$NC
Select an option"
echo "1. INSTALL UDP HYSTERIA"
echo "2. OTHER UDP HYSTERIA SETTINGS"
echo "3. Exit"
# Select an Option

    read -p "$(echo -e "\033[1;33m Select a number from 0 to 2: \033[0m")" input
    
    # Check if input is a number
    if [[ $input =~ ^[0-9]+$ ]]; then
        selected_option=$input
    else
        echo -e "$YELLOW"
        echo "Invalid input. Please enter a valid number."
        echo -e "$NC"
    fi
clear
case $selected_option in
    1)
        echo -e "$YELLOW"
        echo "     💚 UDP HYSTERIA AUTO INSTALLATION 💚      "
        echo "       ╰┈➤💚 Installing Binaries 💚           "
        echo -e "$NC"
        cd /root
        systemctl stop hysteria-server.service
        systemctl disable hysteria-server.service
        rm -rf /etc/systemd/system/hysteria-server.service
        rm -rf /root/hy
        mkdir hy
        cd hy
        udp_script="/root/hy/hysteria-linux-amd64"
        if [ ! -e "$udp_script" ]; then
            wget https://github.com/JohnReaJR/A/releases/download/V1/hysteria-linux-amd64
        fi
        chmod 755 hysteria-linux-amd64
        openssl ecparam -genkey -name prime256v1 -out ca.key
        openssl req -new -x509 -days 36500 -key ca.key -out ca.crt -subj "/CN=bing.com"
        while true; do
            echo -e "$YELLOW"
            read -p "Obfs : " obfs
            echo -e "$NC"
            if [ ! -z "$obfs" ]; then
            break
            fi
        done
            echo -e "\033[1;32mMultiple Auth Separate with commas ( ex: a,b,c )\033[0m"
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
                echo "Enter auth separatedbycommas"
                echo -e "$NC"
            fi
        echo "$input_config" > /root/hy/authusers
        auth_str=$(printf "\"%s\"," "${config[@]}" | sed 's/,$//')
        while true; do
            echo -e "$YELLOW"
            read -p "Remote UDP Port : " remote_udp_port
            echo -e "$NC"
            if is_number "$remote_udp_port" && [ "$remote_udp_port" -ge 1 ] && [ "$remote_udp_port" -le 65534 ]; then
                if netstat -tulnp | grep -q "::$remote_udp_port"; then
                    echo -e "$YELLOW"
                    echo "Error : the selected port has already been used"
                    echo -e "$NC"
                else
                    break
                fi
            else
                echo -e "$YELLOW"
                echo "Invalid input. Please enter a valid number between 1 and 65534."
                echo -e "$NC"
            fi
        done
        file_path="/root/hy/config.json"
        json_content='{"listen":":'"$remote_udp_port"'","protocol":"udp","cert":"/root/hy/ca.crt","key":"/root/hy/ca.key","up":"100 Mbps","up_mbps":100,"down":"100 Mbps","down_mbps":100,"disable_udp":false,"obfs":"'"$obfs"'","auth":{"mode":"passwords","config":['"$auth_str"']}}'
        echo "$json_content" > "$file_path"
        if [ ! -e "$file_path" ]; then
            echo -e "$YELLOW"
            echo "Error: Unable to save the config.json file"
            echo -e "$NC"
            exit 1
        fi
        sudo debconf-set-selections <<< "iptables-persistent iptables-persistent/autosave_v4 boolean true"
        sudo debconf-set-selections <<< "iptables-persistent iptables-persistent/autosave_v6 boolean true"
        while true; do
            echo -e "$YELLOW"
            read -p "Binding UDP Ports : from port : " first_number
            echo -e "$NC"
            if is_number "$first_number" && [ "$first_number" -ge 1 ] && [ "$first_number" -le 65534 ]; then
                break
            else
                echo -e "$YELLOW"
                echo "Invalid input. Please enter a valid number between 1 and 65534."
                echo -e "$NC"
            fi
        done
        while true; do
            echo -e "$YELLOW"
            read -p "Binding UDP Ports : from port : $first_number to port : " second_number
            echo -e "$NC"
            if is_number "$second_number" && [ "$second_number" -gt "$first_number" ] && [ "$second_number" -lt 65536 ]; then
                break
            else
                echo -e "$YELLOW"
                echo "Invalid input. Please enter a valid number greater than $first_number and less than 65536."
                echo -e "$NC"
            fi
        done
        #Install Badvpn
        cd /root
        systemctl stop udpgw.service
        systemctl disable udpgw.service
        rm -rf /etc/systemd/system/udpgw.service
        rm -rf /usr/bin/udpgw
        cd /usr/bin
        wget https://github.com/JohnReaJR/A/releases/download/V1/udpgw
        chmod 755 udpgw
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
        echo "     💚 P2P SERVICE INITIALIZED 💚     "
        echo "     ╰┈➤💚 Badvpn Activated 💚         "
        echo -e "$NC"
    
        # [+config+]
        chmod 755 /root/hy/config.json
        cat <<EOF >/etc/systemd/system/hysteria-server.service
[Unit]
After=network.target nss-lookup.target

[Service]
User=root
WorkingDirectory=/root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
ExecStart=/root/hy/hysteria-linux-amd64 server -c /root/hy/config.json
ExecReload=/bin/kill -HUP $MAINPID
Restart=always
RestartSec=2
LimitNOFILE=infinity
StandardOutput=file:/root/hy/hysteria.log

[Install]
WantedBy=multi-user.target
EOF
        #Start Services
        systemctl enable hysteria-server.service
        systemctl start hysteria-server.service
        iptables -t nat -A PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport "$first_number":"$second_number" -j DNAT --to-destination :$remote_udp_port
        ip6tables -t nat -A PREROUTING -i $(ip -4 route ls|grep default|grep -Po '(?<=dev )(\S+)'|head -1) -p udp --dport "$first_number":"$second_number" -j DNAT --to-destination :$remote_udp_port
        iptables -A INPUT -p udp --dport $remote_udp_port -j ACCEPT
        ip6tables -A INPUT -p udp --dport $remote_udp_port -j ACCEPT
        netfilter-persistent save
        netfilter-persistent reload
        netfilter-persistent start
        cd /root
        rm .bash_history && history -c && history -w
        echo -e "$YELLOW"
        echo "    💚 UDP HYSTERIA INSTALLED SUCCESSFULLY 💚        "
        echo "      ╰┈➤💚 Telegram >>> t.me/Am_The_Last_Envoy    "
        echo -e "$NC"
        X
        exit 1
        ;;
    2)
        cd /etc/V/bin; ./k.sh; cd; X
        exit 1
        ;;
    3)
        echo -e "$YELLOW"
        echo "Welcome To Resleeved Net"
        echo -e "$NC"
        exit 1
        ;;
esac
