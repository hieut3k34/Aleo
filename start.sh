#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
   apt install curl -y < "/dev/null"
fi
echo "=================================================="
curl -s https://api.nodes.guru/logo.sh | bash && sleep 3
echo "=================================================="
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Aborting: run as root user!"
    exit 1
fi
echo -e 'Setting up swapfile...\n'
curl -s https://api.nodes.guru/swap4.sh | bash
echo "=================================================="
echo -e 'Installing dependencies...\n' && sleep 1
apt update
apt install make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y < "/dev/null"
echo "=================================================="
echo -e 'Cloning snarkOS...\n' && sleep 1
rm -rf $HOME/snarkOS $(which snarkos) $(which snarkos) $HOME/.aleo $HOME/aleo
cd $HOME
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
echo "=================================================="
echo -e 'Installing snarkos ...\n' && sleep 1
bash ./build_ubuntu.sh
source $HOME/.bashrc
source $HOME/.cargo/env
