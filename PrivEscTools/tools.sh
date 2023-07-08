#!/bin/bash
# Downloads Tools for privilege escalation.
# Created by WafflesExploit

lightgreen=`echo -en "\e[92m"`
lightyellow=`echo -en "\e[93m"`
lightblue=`echo -en "\e[94m"`
white=`echo -en "\e[97m"`
aqua=`echo -en "\e[36m"`
green=`echo -en "\e[32m"`
orange=`echo -en "\e[33m"`
echo "${lightyellow}------Waffles' Downloads------"
echo "${white}This script needs sudo to install dependencies, so write your password in the following prompt:"
sudo echo "${white}Successfully entered sudo."


if [[ $1 == '-h' ]]; then
        echo "${white}-$ ./tools.sh "
        echo "${white}-> Downloads Tools for privilege escalation."
        exit 0
fi

dots(){
 while true; do
 	echo -ne "."
 	sleep 0.5
 done
}
pid=a
fdots(){
	if [[ $1 == 1 ]]; then
		dots &
		pid=$!
	else
		kill $pid
		echo ""	
	fi
}


if [[ ! (-d LinPriv) ]]; then
	echo "${green}LinPriv created"
	mkdir LinPriv
	cd LinPriv
else
	echo "${orange}LinPriv already created"
	cd LinPriv
fi
echo "${aqua}Moving in to LinPriv"


declare -A ltools
ltools[LinPEAS]="https://github.com/carlospolop/PEASS-ng/releases/download/20230425-bd7331ea/linpeas.sh "
ltools[LinEnum]="https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh "
ltools[linux-exploit-suggester]="https://raw.githubusercontent.com/The-Z-Labs/linux-exploit-suggester/master/linux-exploit-suggester.sh "
ltools[Linux-smart-enumeration]="https://github.com/diego-treitos/linux-smart-enumeration/releases/download/4.11nw/lse.sh "

for key in "${!ltools[@]}"; do
	val="${ltools[$key]}"
	key=$(echo "$key" | cut -d "_" -f 1)
	if [ -d $key ]; then
		cd $key
	else
		mkdir $key
		cd $key
	fi
	fieldcount=$(tr -dc '/' <<< $val | wc -c)
	fieldnum=$(expr $fieldcount + 1)
	output=$(cut -d "/" -f $fieldnum <<< $val)
	
	if [ -f $output ]; then
	   if [ $output == "master.zip" ];then
		rm $key.zip
		rm $key -r
	   fi
	   rm $output
	fi
	
	echo -n "${lightblue}-> Downloading $key."
	fdots 1
	wget -q $val; chmod +x $output
	fdots 0
	if [ $output == "master.zip" ];then
		mv master.zip $key.zip
		output=$key.zip
		echo "${lightgreen}-> Created $output"
		if [ -d "$key-master" ]; then
			rm $key-master -r
		fi
		fdots 1
		echo -n "${lightblue}-> Extracting $key.zip"
		unzip -qq $output
		rm $key.zip
		fdots 0
		echo "${lightgreen}-> Extracted $key.zip to $key-master"
	else
		echo "${lightgreen}-> Created $output"
	fi
	cd ..
	
done

declare -A wtools
# Remember, to make files stay in the same folder use "_" Example: <foldername>_<filetype> -> winPEAS_bat
wtools[winPEAS_bat]="https://github.com/carlospolop/PEASS-ng/releases/download/20230425-bd7331ea/winPEAS.bat "
wtools[winPEAS_x64exe]="https://github.com/carlospolop/PEASS-ng/releases/download/20230425-bd7331ea/winPEASx64.exe "
wtools[winPEAS_x86exe]="https://github.com/carlospolop/PEASS-ng/releases/download/20230425-bd7331ea/winPEASx86.exe "
wtools[PowerUp]="https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1 "
wtools[Windows-Exploit-Suggester]="https://raw.githubusercontent.com/bitsadmin/wesng/master/wes.py "
wtools[Sherlock]="https://raw.githubusercontent.com/rasta-mouse/Sherlock/master/Sherlock.ps1 "
wtools[Watson]="https://github.com/rasta-mouse/Watson/archive/refs/heads/master.zip "
wtools[JAWS]="https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1 "
wtools[Seatbelt]="https://github.com/GhostPack/Seatbelt/archive/refs/heads/master.zip "
wtools[SharpUp]="https://github.com/GhostPack/SharpUp/archive/refs/heads/master.zip "

cd ..
if [[ ! (-d WinPriv) ]]; then
	echo "${green}WinPriv created"
	mkdir WinPriv
	cd WinPriv
else
	echo "${orange}WinPriv already created"
	cd WinPriv
fi
echo "${aqua}Moving in to WinPriv"

for key in "${!wtools[@]}"; do
	val="${wtools[$key]}"
	key=$(echo "$key" | cut -d "_" -f 1)
	if [ -d $key ]; then
		cd $key
	else
		mkdir $key
		cd $key
	fi
	fieldcount=$(tr -dc '/' <<< $val | wc -c)
	fieldnum=$(expr $fieldcount + 1)
	output=$(cut -d "/" -f $fieldnum <<< $val)
	
	if [ -f $output ]; then
	   if [ $output == "master.zip" ];then
		rm $key.zip
		rm $key -r
	   fi
	   rm $output
	fi
	
	echo -n "${lightblue}-> Downloading $key."
	fdots 1
	wget -q $val; chmod +x $output
	fdots 0
	if [ $output == "master.zip" ];then
		mv master.zip $key.zip
		output=$key.zip
		echo "${lightgreen}-> Created $output"
		if [ -d "$key-master" ]; then
			rm $key-master -r
		fi
		fdots 1
		echo -n "${lightblue}-> Extracting $key.zip"
		unzip -qq $output
		rm $key.zip
		fdots 0
		echo "${lightgreen}-> Extracted $key.zip to $key-master"
	else
		echo "${lightgreen}-> Created $output"
	fi
	cd ..
	
done
echo "${lightblue}-> Downloading & Installing Impacket"
fdots 1
sudo apt install pipx 1>/dev/null
python3 -m pipx install impacket 1>/dev/null
pipx ensurepath 1>/dev/null
fdots 0
echo "${lightgreen}-> Installed Impacket"
echo ""
echo "${lightyellow}------Finished all Downloads------"
echo "${lightyellow}------Finished Running------"