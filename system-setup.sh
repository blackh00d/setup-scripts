#!/bin/bash

# Update system before setup
apt update && apt full-upgrade -y

# Cleanup
apt install -f -y
apt autoremove && apt autoclean


# Install usual packages
echo "Installing packages"
apt install -q -y kali-linux-{full,pwtools,web}
apt install -q -y gedit leafpad terminator chromium ftp html2text cookie-cadger dbeaver default-jdk default-jdk-headless default-jre default-jre-headless dex2jar
apt install -q -y libimage-exiftool-perl crowbar ncat gobuster masscan xfce4-clipman autokey-gtk flameshot ismtp sshuttle dirbuster filezilla
apt install -q -y wmctrl javasnoop jsql-injection magictree maltego maltego-teeth mediainfo oscanner paros patator protos-sip smali webscarab zaproxy jd jd-gui python3-pip 
apt install -q -y build-essential g++ xsel make fakeroot jq ruby-full libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev
apt install -q -y libgmp-dev zlib1g-dev gcc-multilib libcanberra-pulse libssh-dev autoconf  libsmbclient libsmbclient-dev libffi-dev python-dev python-xlib
apt install -q -y routersploit krb5-user cifs-utils rdate libxcb-xtest0 golang redis-tools mingw-w64 mingw-w64-i686-dev zabbix-cli
apt install -q -y gnome-calculator gimp payloadsallthethings crackmapexec python3-pip

Install Mobile Pentesting Tools
echo "Installing Mobile Pentesting Tools"
apt install -q -y  adb pidcat apktool dex2jar jd-gui bytecode-viewer androguard virtualbox
pip install {qark,frida}
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

# Cleanup
apt install -f -y


# Install Py packages
echo "Installing Py Packages"
pip install {proxy.py,getsploit}

# Install Prebellico
cd /opt
git clone https://github.com/unixrox/prebellico.git
cd /opt/prebellico
pip install -r requirements.txt
pip install pcapy


echo "System Setup Complete!"
