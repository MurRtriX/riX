block_user() {
  clear
  active_users=('' $(show_users))
  msg -bar
  print_center -ama "${a9:-BLOCK/UNBLOCK USERS}"
  msg -bar
  data_user
  back

  print_center -ama "${a52:-Type a Username from the list}"
  msg -bar
  unset selection
  while [[ ${selection} = "" ]]; do
    msg -nazu "${a53:-Please type a username}: " && read selection
    del 1
  done

  [[ ${selection} = "0" ]] && return
  if [[ ! $(print_center -ama "${selection}" | egrep '[^0-9]') ]]; then
    user_del="${active_users[$selection]}"
  else
    user_del="$selection"
  fi
  [[ -z $user_del ]] && {
    msg -verm "${a54:-Error, Invalid User}"
    msg -bar
    return 1
  }
  [[ ! $(echo ${active_users[@]} | grep -w "$user_del") ]] && {
    msg -verm "${a54:-Error, Invalid User}"
    msg -bar
    return 1
  }

  msg -nama "   ${a48:-Username}: $user_del >>>> "

  if [[ $(passwd --status $user_del | cut -d ' ' -f2) = "P" ]]; then
    pkill -u $user_del &>/dev/null
    droplim=$(droppids | grep -w "$user_del" | awk '{print $2}')
    kill -9 $droplim &>/dev/null
    usermod -L $user_del &>/dev/null
    sleep 2
    msg -verm2 "${a60:-Blocked}"
  else
    usermod -U $user_del
    sleep 2
    msg -verd "${a61:-Unblocked}"
  fi
  msg -bar
  sleep 3
}
