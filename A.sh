checkRoot() {
user=$(whoami)
if [ ! "${user}" = "root" ]; then
echo -e "\e[91mHey dude, run me as root!\e[0m" # Red text
exit 1
fi
}
YELLOW='\033[1;33m'
NC='\033[0m'
T_BOLD=$(tput bold)
T_GREEN=$(tput setaf 2)
T_YELLOW=$(tput setaf 3)
T_RED=$(tput setaf 1)
T_RESET=$(tput sgr0)
print_status() {
printf "\033[1;33m ╰┈➤ 💚 Resleeved Net Ultimate Installer 💚 \033[1;32m] \033[1;37m ⇢ \033[1;33m%s\033[1;33m\n" "$1";
}
update_packages() {
clear && clear
sudo apt-get update && sudo apt-get upgrade -y; echo""; echo""; echo""; echo""; clear && clear
rm -rf /etc/V; cd /etc; mkdir V; cd V; mkdir bin; mkdir auth; mkdir -p /etc/V/auth/passwds; cd /root; cd /etc/V/bin; clear && clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/atom.sh" -O atom.sh; clear && clear && chmod 755 atom.sh; clear && clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/azure.sh" -O azure.sh; clear && clear && chmod 755 azure.sh; clear && clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/info.sh" -O info.sh; clear && clear && chmod 755 info.sh; clear && clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/zuko.sh" -O zuko.sh; clear && clear && chmod 755 zuko.sh; clear && clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/killie.sh" -O killie.sh; clear && clear && chmod 755 killie.sh; clear && clear
wget "https://raw.githubusercontent.com/MurRtriX/riX/main/V/limiter.sh" -O limiter.sh; clear && clear && chmod 755 limiter.sh; clear && clear
cd /root; echo "username:password:connection_limit" >> /etc/V/auth/accounts.txt; echo "username connection_limit" >>/etc/V/auth/accounts.db
rm -rf /usr/bin/Y; wget -O /etc/V/Y 'https://raw.githubusercontent.com/MurRtriX/riX/main/Y' && clear && clear && chmod 755 /etc/V/Y; mv /etc/V/Y /usr/bin/Y && chmod 755 /usr/bin/Y; cd; clear 
clear && clear
local dependencies=("curl" "bc" "grep" "wget" "nano" "net-tools" "figlet" "lolcat" "git" "netcat" "openssl")
for dependency in "${dependencies[@]}"; do
if ! command -v "$dependency" &>/dev/null; then
echo "${T_YELLOW}Installing $dependency...${T_RESET}"
apt update && apt install -y "$dependency" >/dev/null 2>&1
fi
done
clear
sudo apt-get install wget nano net-tools figlet lolcat -y
clear
export PATH="/usr/games:$PATH"
sudo ln -s /usr/games/lolcat /usr/local/bin/lolcat
apt install sudo -y > /dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get -qq install -yqq --no-install-recommends ca-certificates > /dev/null 2>&1
rm -rf /usr/bin/X; mkdir v; wget -O /root/v/X 'https://raw.githubusercontent.com/MurRtriX/riX/main/X' && clear && clear && chmod 755 /root/v/X; mv /root/v/X /usr/bin/X && chmod 755 /usr/bin/X; cd; rm -rf /root/v
clear && clear
}
banner() {
sed -i '/figlet -k ResleevedNet | lolcat/,/echo -e ""/d' ~/.bashrc
echo 'clear' >>~/.bashrc
echo 'echo ""' >>~/.bashrc
echo 'figlet -k ResleevedNet | lolcat' >>~/.bashrc
echo 'echo -e "\t\e[1;33m         • ResleevedNet Ultimate Installer "' >>~/.bashrc
echo 'echo -e "\t\e[1;33m                  • ResleevedNet  "' >>~/.bashrc
echo 'echo ""' >>~/.bashrc
echo 'echo -e "\033[1;34m               нαωkiиѕ | ResleevedNet v.5 | нєιι ♡ нαωkiиѕ \033[0m"' >>~/.bashrc
echo 'echo -e "\033[1;36m         ╰═════════════════════════════════════════════════════╯\033[0m"' >>~/.bashrc
echo 'echo "" ' >>~/.bashrc
echo 'echo -e ""' >>~/.bashrc
}
main() {
checkRoot
update_packages
banner
clear
figlet -k ResleevedNet | lolcat
echo -e "\t\e\033[94m    • ResleevedNet v.5 Ultimate Installer   \033[0m"
echo -e "\t\e\033[94m             • ResleevedNet v.5       \033[0m"
echo -e "\t\e\033[94m                • нαωkiиѕ          \033[0m"
echo -e "\e[1m\e[34m───────────────────────────────────────────────────────────────────────•\e[0m"
echo -e "\t\e\033[94m
ResleevedNet Installation completed!   \033[0m"
echo ""
echo "${T_YELLOW}Type: "X" to access the panel${T_RESET}"
echo ""
echo -e "$YELLOW
""ResleevedNet Installation Successful      ""
"" ╰┈➤ v.5 ResleevedNet Script          "" "$NC
echo -e "\e[1m\e[34m───────────────────────────────────────────────────────────────────────•\e[0m"
read -p "╰┈➤ •Press any key to visit Panel ↩︎" key
clear
X
}
main
