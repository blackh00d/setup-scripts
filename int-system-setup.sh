#!/bin/bash

# Update system before setup
apt update && apt full-upgrade -y
apt install -f -y
apt autoremove

# Install usual packages
apt install -q -y ftp html2text kali-linux-{full,pwtools,web} terminator cookie-cadger gedit default-jdk default-jdk-headless default-jre default-jre-headless dex2jar
apt install -q -y wmctrl javasnoop jsql-injection keepass2 magictree maltego maltego-teeth mediainfo oscanner paros patator protos-sip smali webscarab zaproxy jd jd-gui gobuster
apt install -q -y python3-pip libimage-exiftool-perl crowbar ncat gobuster masscan build-essential g++ xsel make fakeroot jq ruby-full libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev
apt install -q -y sshuttle libgmp-dev zlib1g-dev gcc-multilib libcanberra-pulse libssh-dev autoconf libsmbclient libsmbclient-dev
apt install -q -y routersploit krb5-user cifs-utils rdate libxcb-xtest0 golang redis-tools mingw-w64 mingw-w64-i686-dev zabbix-cli python-xlib

# Install Wine Setup
apt install winbind winetricks -y
dpkg --add-architecture i386
apt install wine32 -y

# Setup PEDA for GDB
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit


apt install -f -y

# Install Py packages
echo "Installing Py Packages"
cd /opt
git https://github.com/cheat/cheat.git
pip install {proxy.py,getsploit,pwncrypto}

# Copy useful libraries
cp -r /usr/local/include/node/openssl/* /usr/include/openssl/


# Install Impacket
cd /mnt/hgfs/oneDrive-poseidon6/tools/misc/impacket
pip install -r requirements.txt
python setup.py install

#IDA Debugger (free) for Linux
chmod +x /mnt/hgfs/oneDrive-poseidon6/other-tools/ida-7
ln -s /mnt/hgfs/oneDrive-poseidon6/other-tools/ida-7 /usr/bin/ida

# Restore user settings and perms
cp -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/autokey/ /root/.config/
cp -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/.bashrc /root/
mkdir /root/.cheat
cp -r /mnt/hgfs/oneDrive-poseidon6/tools/p6-cheats/* /root/.cheat
cp -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/peda /root/
cp -r /mnt/hgfs/oneDrive-poseidon6/safety-backup/root/.ssh/* /root/.ssh/


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
cp -r fuzzbunch-debian $HOME/.wine-fuzzbunch/drive_c/
cd $HOME/.wine-fuzzbunch/drive_c

# MSF Modules
#- Eternal Blue x86/x64 Multi
cp /mnt/hgfs/oneDrive-poseidon6/exploits/msf-modules/Eternalblue-Doublepulsar-Metasploit/eternalblue_doublepulsar.rb /usr/share/metasploit-framework/modules/exploits/windows/smb/
mkdir /root/Eternalblue-Doublepulsar-Metasploit
cp -r /mnt/hgfs/oneDrive-poseidon6/exploits/msf-modules/Eternalblue-Doublepulsar-Metasploit/deps /root/Eternalblue-Doublepulsar-Metasploit/

echo "System Setup Complete!"
