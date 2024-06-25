if [ "$EUID" -ne 0 ]; then
echo -e "\033[1;31mHey dude, run me as root!\033[0m"
exit 1
fi
banner00() {
clear
figlet -k Resleeved | lolcat
echo -e "\033[1;34m   ResleevedNet v.5 \033[0m  | \033[1;33m v.5 Release  | ResleevedNet \033[0m"
echo -e "\033[1;36m╰═════════════════════════════════════════════════════╯\033[0m"
echo ""
}
banner() {
clear
figlet -k Resleeved | lolcat
echo -e "\033[1;34m   ResleevedNet v.5 \033[0m  | \033[1;33m v.5 Release  | ResleevedNet \033[0m"
echo -e "\033[1;36m╰═════════════════════════════════════════════════════╯\033[0m"
server_ip=$(curl -s https://api.ipify.org)
oscode=$(lsb_release -ds)
os_arch=$(uname -m) # Corrected from 'uname -i'
isp=$(wget -qO- ipinfo.io/org)
ram=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
cpu=$(top -bn1 | awk '/Cpu/ { cpu = 100 - $8 "%"; print cpu }')
echo -e "\033[1;33m IP: $server_ip  | ISP: $isp\033[0m"
echo -e "\033[1;35m OS: $oscode | Arch: $os_arch | RAM: $ram | CPU: $cpu\033[0m"
echo -e "\033[1;36m•═══════════════════════════════════════════════════•\033[0m"
}
banner1() {
clear
figlet -k Resleeved | lolcat
echo -e "\033[1;34m   ResleevedNet v.5 \033[0m  | \033[1;33m v.5 Release  | ResleevedNet \033[0m"
echo -e "\033[1;36m╰═════════════════════════════════════════════════════╯\033[0m"
echo ""
server_ip=$(curl -s https://api.ipify.org)
oscode=$(lsb_release -ds)
os_arch=$(uname -m)  # Corrected from 'uname -i'
isp=$(wget -qO- ipinfo.io/org)
ram=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
cpu=$(top -bn1 | awk '/Cpu/ { printf "%.2f%%", 100 - $8 }')
echo -e "\033[1;36m IP: $server_ip  | ISP: $isp\033[0m"
echo -e "\033[1;35m OS: $oscode | Arch: $os_arch | RAM: $ram | CPU: $cpu\033[0m"
echo -e "\033[1;36m•═══════════════════════════════════════════════════•\033[0m"
}
uninstallation() {
banner00
echo "Please wait..."
sleep 5
rm -rf /etc/V
while IFS= read -r username; do
userdel -r "$username"
done < <(grep -oP '^user[0-9]+:' /etc/passwd | cut -d: -f1)
echo ""
echo "Please wait..."
sleep 3
echo "Uninstallation complete."
}
menu() {
echo -e "\033[1;33m Manage ResleevedNet Users\033[0m"
echo -e "\033[1;36m────────────────────────────────────────────────────•\033[0m"
echo -e "\e[36m 01⎬╰┈➤ Create Account"
echo -e "\e[36m 02⎬╰┈➤ Change Password"
echo -e "\e[36m 03⎬╰┈➤ Remove Account"
echo -e "\e[36m 04⎬╰┈➤ Renew Account"
echo -e "\e[36m 05⎬╰┈➤ Account Details"
echo -e "\e[36m 06⎬╰┈➤ Check Active Protocols"
echo -e "\e[36m 07⎬╰┈➤ Restart VPS"
echo -e "\e[36m 08⎬╰┈➤ Online Accounts (not implemeted)"
echo -e "\e[36m 09⎬╰┈➤ Backup/Restore (not implemeted)"
echo -e "\e[36m 10⎬╰┈➤ Uninstall"
echo -e "\e[36m 00⎬╰┈➤ Exit \033[0m"
echo -e "\033[1;36m────────────────────────────────────────────────────•\033[0m"
}
call_menu() {
while true; do
banner
menu
read -p " Enter your choice: " choice
case $choice in
1)
clear
cd /etc/V/bin && ./atom.sh; cd
read -n 1 -s -r -p "Press any key to return ↩︎"
;;
2)
clear
cd /etc/V/bin && ./zuko.sh; cd
read -n 1 -s -r -p "Press any key to return ↩︎"
;;
3)
clear
cd /etc/V/bin && ./killie.sh; cd
read -n 1 -s -r -p "Press any key to return ↩︎"
;;
4)
clear
cd /etc/V/bin && ./azure.sh; cd
read -n 1 -s -r -p "Press any key to return ↩︎"
;;
5)
clear
cd /etc/V/bin && ./info.sh; cd
read -n 1 -s -r -p "Press any key to return ↩︎"
;;
6)
banner
echo -e "\n\033[1;33m Active Protocols\033[0m"
echo -e "\033[1;36m───────────────────────────────────────────────────\033[0m"
lsof -i :80,443,8000,8001,8002,8990,36718 | awk 'NR==1{print; next} {print "\033[1;34m・ " $0 "\033[0m"}'
echo -e "\033[1;36m────────────────────────────────────────────────────────────────────────•\033[0m"
read -n 1 -s -r -p "Press any key to return ↩︎"
;;
7)
banner
echo -e "reboot in 3 secs..."
sleep 3
reboot
;;
10)
banner
uninstallation
sleep 2
exit 0
;;
0)
echo ""
echo "Exiting..."
exit 0
;;
*)
echo ""
echo "Invalid choice. Please select a valid option."
;;
esac
done
}
## Installing Dependencies
cd /etc; mkdir V; cd V; mkdir bin; mkdir auth; mkdir -p /etc/V/auth/passwds; cd /root; cd /etc/V/bin
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/atom.sh" -O atom.sh && chmod 755 atom.sh
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/azure.sh" -O azure.sh && chmod 755 azure.sh; clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/info.sh" -O info.sh && chmod 755 info.sh
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/zuko.sh" -O zuko.sh && chmod 755 zuko.sh; clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/killie.sh" -O killie.sh && chmod 755 killie.sh
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/limiter.sh" -O limiter.sh && chmod 755 limiter.sh; clear
call_menu
