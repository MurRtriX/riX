checkRoot() {
user=$(whoami)
if [ ! "${user}" = "root" ]; then
echo -e "\e[91mHey dude, run me as root!\e[0m" # Red text
exit 1
fi
}

inst_obfs(){
    read -p "Set SlowUDP obfuscation password (Enter for random password) :  " obfs_pwd
    [[ -z $obfs_pwd ]] && obfs_pwd=$(date +%s%N | md5sum | cut -c 1-16)
    echo "The obfs password used on the SlowUDP server is: $obfs_pwd"
}

change_obfs(){
    old_pwd=$(cat /root/hy/config.json | grep obfs | awk -F',' 'NR == 1 {split($10,a,":");print a[2]}' | sed "s/\"//g" | sed "s/,//g")
    inst_obfs
    sed -i 's/\"obfs\":\"$old_pwd\"/\"obfs\":\"$obfs_pwd\"/' /root/hy/config.json

    systemctl restart hysteria-server.service

    echo "The configuration is modified successfully, please re-import the client configuration file"
}

menu() {
    clear
    echo -e "1. Install SlowUDP"
    echo " -------------"
    echo -e "0. Exit script"
    echo ""
    read -rp "Please enter options [0-1]: " menuInput
    case $menuInput in
        1 ) change_obfs ;;
        * ) exit 1 ;;
    esac
}

menu
