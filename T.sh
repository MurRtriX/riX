echo -e "ZIVPN UDP Passwords"
read -p "Enter passwords separated by commas, example: pass1,pass2 (Press enter for Default 'zi'): " input_config

if [ -n "$input_config" ]; then
    IFS=',' read -r -a config <<< "$input_config"
    if [ ${#config[@]} -eq 1 ]; then
        config+=(${config[0]})
    fi
else
    config=("zi")
fi

new_config_str="\"config\": [$(printf "\"%s\"," "${config[@]}" | sed 's/,$//')]"

sed -i -E "s/\"config\": ?\[[[:space:]]*\"zi\"[[:space:]]*\]/${new_config_str}/g" /root/hy/config.json


inst_obfs(){
    read -p "Set SlowUDP obfuscation password (Enter for random password) :  " obfs_pwd
    [[ -z $obfs_pwd ]] && obfs_pwd=$(date +%s%N | md5sum | cut -c 1-16)
    yellow "The obfs password used on the SlowUDP server is: $obfs_pwd"
    auth_pwd=$obfs_pwd
}

change_obfs(){
    old_pwd=$(cat /etc/slowudp/config.json | grep password | sed -n 2p | awk -F " " '{print $2}' | sed "s/\"//g" | sed "s/,//g")
    inst_obfs
    sed -i "s/\"obfs\": \"\"/\"obfs\": \"$obfs_pwd\"/" /etc/slowudp/config.json
    sed -i "s/\"obfs\": \"\"/\"obfs\": \"$obfs_pwd\"/" /root/slowudp/slowudp-client.json
    sed -i "s/obfs: /obfs: $obfs_pwd/" /root/slowudp/clash-meta.yaml
    sed -i "s/obfsParam=/obfsParam=$obfs_pwd/" /root/slowudp/url.txt

    sed -i "s/\"obfs\": \"$old_pwd\"/\"obfs\": \"$obfs_pwd\"/" /etc/slowudp/config.json
    sed -i "s/\"obfs\": \"$old_pwd\"/\"obfs\": \"$obfs_pwd\"/" /root/slowudp/slowudp-client.json
    sed -i "s/obfs: $old_pwd/obfs: $obfs_pwd/" /root/slowudp/clash-meta.yaml
    sed -i "s/obfsParam=$old_pwd/obfsParam=$obfs_pwd/" /root/slowudp/url.txt

    sed -i "s/$old_pwd/$auth_pwd/" /etc/slowudp/config.json
    sed -i "s/$old_pwd/$auth_pwd/" /root/slowudp/slowudp-client.json
    sed -i "s/$old_pwd/$auth_pwd/" /root/slowudp/clash-meta.yaml
    sed -i "s/$old_pwd/$auth_pwd/" /root/slowudp/url.txt

    stopHysteria && startHysteria

    green "The configuration is modified successfully, please re-import the client configuration file"
}
