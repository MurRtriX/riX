#!/bin/bash
YELLOW='\033[1;33m'
NC='\033[0m'
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run as root."
    exit 1
fi
udp_dir='/root/udp'
source $udp_dir/module
cd /root
echo -e "\033[1;33mEnter ports to be Excluded separated spaces\033[0m"
read -p "Enter the ports : " option
tmport=($option)
unset Port
  for ((i = 0; i < ${#tmport[@]}; i++)); do
    num=$((${tmport[$i]}))
    if [[ $num -gt 0 ]]; then
      echo "$(msg -ama " ${a27:-port to exclude} >") $(msg -azu "$num") $(msg -verd "OK")"
      Port+=" $num"
    else
      msg -verm2 " ${a28:-not a port} > ${tmport[$i]}?"
      continue
    fi
  done
  if [[ $Port = "" ]]; then
    unset Port
    print_center -ama "${a29:-no ports excluded}"
  else
    exclude=$(cat /etc/systemd/system/custom-server.service | grep 'exclude')
    if systemctl is-active custom-server.service &>/dev/null; then
      systemctl stop custom-server.service &>/dev/null
      systemctl disable custom-server.service &>/dev/null
      iniciar=1
    fi
    if [[ -z $exclude ]]; then
      Port=" -exclude=$(echo "$Port" | sed "s/ /,/g" | sed 's/,//')"
      sed -i "s/ -mode/$Port -mode/" /etc/systemd/system/custom-server.service
    else
      exclude_port=$(echo $exclude | awk '{print $4}' | cut -d '=' -f2)
      Port="-exclude=$exclude_port$(echo "$Port" | sed "s/ /,/g")"
      sed -i "s/-exclude=$exclude_port/$Port/" /etc/systemd/system/custom-server.service
    fi
    if [[ $iniciar = 1 ]]; then
      systemctl enable custom-server.service &>/dev/null
      systemctl start custom-server.service &>/dev/null
    fi
  fi
  exit 0
