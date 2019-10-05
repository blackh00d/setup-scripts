#!/bin/bash

# Update system before setup
apt update && apt full-upgrade -y

# Cleanup
apt install -f -y
apt autoremove && autoclean


# Install usual packages
echo "Installing packages"
apt install -q -y kali-linux-{full,pwtools,web}
apt install -q -y gedit leafpad terminator chromium ftp html2text terminator cookie-cadger dbeaver default-jdk default-jdk-headless default-jre default-jre-headless dex2jar
apt install -q -y libimage-exiftool-perl crowbar ncat gobuster masscan xfce4-clipman autokey-gtk flameshot ismtp sshuttle dirbuster filezilla
apt install -q -y wmctrl javasnoop jsql-injection magictree maltego maltego-teeth mediainfo oscanner paros patator protos-sip smali webscarab zaproxy jd jd-gui python3-pip 
apt install -q -y build-essential g++ xsel make fakeroot jq ruby-full libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev
apt install -q -y libgmp-dev zlib1g-dev gcc-multilib libcanberra-pulse libssh-dev autoconf  libsmbclient libsmbclient-dev libffi-dev python-dev python-xlib
apt install -q -y routersploit krb5-user cifs-utils rdate libxcb-xtest0 golang redis-tools mingw-w64 mingw-w64-i686-dev zabbix-cli
apt install -q -y gnome-calculator gimp keepass2 payloadsallthethings

# Install Mobile Pentesting Tools
# echo "Installing Mobile Pentesting Tools"
# apt install -q -y  adb pidcat apktool dex2jar jd-gui bytecode-viewer androguard virtualbox
# pip install {qark,frida}
# cp -r /mnt/hgfs/oneDrive-poseidon6/tools/mobile/* /opt/



# Install Stego Tools
echo "Installing Stego Tools"
apt install -y steghide
curl https://raw.githubusercontent.com/Paradoxis/StegCracker/master/stegcracker > /bin/stegcracker
chmod +x /bin/stegcracker


# Install Wine Setup
echo "Installing Wine"
apt install winbind winetricks -y
dpkg --add-architecture i386
apt update
apt install wine32 -y


# Setup Docker
echo "Installing Docker and Docker Compose"
apt install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg2 \
software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) \
stable"
apt update
apt install docker-ce -y

# Setup Docker Compose
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


# Setup PEDA for GDB
echo "Installing PEDA"
rm -rf /root/peda
git clone https://github.com/longld/peda.git /root/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit


# Cleanup
apt install -f -y


# Install Node
echo "Installing NodeJS"
cd /tmp && wget http://ftp.br.debian.org/debian/pool/main/c/checkinstall/checkinstall_1.6.2-4_amd64.deb
dpkg -i checkinstall*.deb
src=$(mktemp -d) && cd $src
wget -N http://nodejs.org/dist/node-latest.tar.gz
tar xzvf node-latest.tar.gz && cd node-v*
./configure
fakeroot checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install
dpkg -i node_*
npm install -g n && n latest

# Install Node packages
echo "Installing Node Packages"
npm install -g Brosec
npm install -g pown-proxy
npm install -g pown


# Install Py packages
echo "Installing Py Packages"
pip install {proxy.py,getsploit,pwncrypto}

# Install Impacket
cd /mnt/hgfs/oneDrive-poseidon6/tools/collections/impacket/ && git pull && pip install -r requirements.txt && python setup.py install


# Copy useful libraries
echo "Copying Libraries"
cp -r /usr/local/include/node/openssl/* /usr/include/openssl/


# Restore user settings and perms
cp -u -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/.config/* /root/.config/
cp -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/.bashrc /root/
mkdir /root/.cheat
cp -u -r /mnt/hgfs/oneDrive-poseidon6/tools/p6-cheats/* /root/.cheat



# Setup Fuzzbunch
cd /mnt/hgfs/oneDrive-poseidon6/tools/
#git clone https://github.com/mdiazcl/fuzzbunch-debian.git
#WINEPREFIX="$HOME/.wine-fuzzbunch" WINEARCH=win32 wine wineboot
export WINEPREFIX=$HOME/.wine-fuzzbunch
#echo "export WINEPREFIX=$HOME/.wine-fuzzbunch" >> /root/.bashrc

## Create Fuzzbunch Env Registry file
## File beginning (Uncomment below to create)

#cat > /mnt/hgfs/oneDrive-poseidon6/tools/fuzzbunch-env.reg << EOF
#Windows Registry Editor Version 5.00

#[HKEY_CURRENT_USER\Environment]
#"PATH"="c:\windows;c:\windows\system;C:\Python26;C:\fuzzbunch-debian\windows\fuzzbunch"
#"TEMP"="C:\users\root\Temp"
#"TMP"="C:\users\root\Temp"

#EOF

## File End (Uncomment above to create)

wine regedit /s fuzzbunch-env.reg
cp fuzzbunch-env.reg $HOME/.wine-fuzzbunch/drive_c/
#cp -r fuzzbunch-debian $HOME/.wine-fuzzbunch/drive_c/
cd $HOME/.wine-fuzzbunch/drive_c

# MSF Modules
#- Eternal Blue x86/x64 Multi
cp /mnt/hgfs/oneDrive-poseidon6/exploits/msf-modules/Eternalblue-Doublepulsar-Metasploit/eternalblue_doublepulsar.rb /usr/share/metasploit-framework/modules/exploits/windows/smb/
mkdir /root/Eternalblue-Doublepulsar-Metasploit
cp -r /mnt/hgfs/oneDrive-poseidon6/exploits/msf-modules/Eternalblue-Doublepulsar-Metasploit/deps /root/Eternalblue-Doublepulsar-Metasploit/

# Install Cheat
pip install docopt pygments appdirs
cd /mnt/hgfs/oneDrive-poseidon6/tools/utilities/cheat/
python setup.py install

# Install Handy Header Hacker
mkdir /opt/handyHeaderHacker
cp /mnt/hgfs/oneDrive-poseidon6/tools/webapp/HandyHeaderHacker/hhh.py /opt/handyHeaderHacker/
ln -s /opt/handyHeaderHacker/hhh.py /usr/bin/handyHeaderHacker
chmod +x /usr/bin/handyHeaderHacker

# Copy Autokey files
rm -rf /root/.config/autokey/data/*
cp -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/.config/autokey/data/* /root/.config/autokey/data/

cp -u -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/* /root/
cp -u -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/.* /root/

# Install Prebellico
cd /opt
git clone https://github.com/unixrox/prebellico.git
cd /opt/prebellico
pip install -r requirements.txt
pip install pcapy

# Install CrackMapExec
cd /mnt/hgfs/oneDrive-poseidon6/tools/postex/win-postex/CrackMapExec
git pull
python setup.py install




echo "System Setup Complete!"






