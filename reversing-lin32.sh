#!/bin/sh

apt update && apt upgrade -y
apt install open-vm-tools radare2 elfutils terminator git gcc gedit cmake build-essential libboost-dev libqt5xmlpatterns5-dev qtbase5-dev qt5-default libqt5svg5-dev libgraphviz-dev libcapstone-dev pkg-config
mkdir /poseidon6/tools
cd /poseidon6/tools
git clone --recursive https://github.com/eteran/edb-debugger.git
cd edb-debugger
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ ..
make
make install
