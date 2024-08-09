udp_dir='/etc/UDPCustom'
source $udp_dir/module
exclude() {
  title "${a20:-Exclude UDP ports}"
  print_center -ama "${a21:-UDP CUSTOM covers full range of ports,}"
  print_center -ama "${a22:-However, you can exclude UDP ports.}"
  msg -bar3
  print_center -ama "${a23:-Examples of ports you can exclude:}:"
  print_center -ama "dnstt (slowdns) udp 53 5300"
  print_center -ama "wireguard udp 51820"
  print_center -ama "openvpn udp 1194"
  msg -bar
  print_center -verd "${a24:-enter the ports separated by spaces}"
  print_center -verd "${a25:-Example}: 53 5300 51820 1194"
  msg -bar3
  in_opcion_down "${a26:-type ports or hit enter to skip}"
  del 2
  tmport=($opcion)
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

  if [[ -z $Port ]]; then
    unset Port
    print_center -ama "${a29:-no ports excluded}"
  else
    Port=" -exclude=$(echo "$Port" | sed "s/ /,/g" | sed 's/,//')"
  fi
  msg -bar3
}

add_exclude() {
  title "${a20:-Exclude UDP ports}"
  print_center -ama "${a21:-UDP CUSTOM covers full range of ports,}"
  print_center -ama "${a22:-However, you can exclude UDP ports.}"
  msg -bar3
  print_center -ama "${a23:-Examples of ports you can exclude:}:"
  print_center -ama "dnstt (slowdns) udp 53 5300"
  print_center -ama "wireguard udp 51820"
  print_center -ama "openvpn udp 1194"
  msg -bar
  print_center -verd "${a24:-enter the ports separated by spaces}"
  print_center -verd "${a25:-Example}: 53 5300 51820 1194"
  in_opcion_down "${a26:-type ports or hit enter to skip}"
  del 4
  tmport=($opcion)
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
  enter
}
add_exclude
