#!/bin/bash
# wget -q -O subquery.sh https://api.nodes.guru/subquery.sh && chmod +x subquery.sh && sudo /bin/bash subquery.sh


exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
  sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://api.nodes.guru/logo.sh | bash && sleep 3

function setupSwap {
	echo -e '\n\e[42mSet up swapfile\e[0m\n'
	curl -s https://api.nodes.guru/swap4.sh | bash
}

function installNodeJS {
	echo -e '\n\e[42mInstall NodeJS and Yarn\e[0m\n' && sleep 1
	sudo apt update
	curl https://deb.nodesource.com/setup_16.x | sudo bash
	sudo apt install -y nodejs gcc g++ make < "/dev/null"
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn
}

function installDocker {
	if exists docker; then
		sleep 1
	else
		echo -e '\n\e[42mInstall Docker\e[0m\n' && sleep 1
		curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
	fi
}

function installDockerCompose {
	echo -e '\n\e[42mInstall Docker Compose\e[0m\n' && sleep 1
	wget https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64
	chmod +x docker-compose-Linux-x86_64
	mv docker-compose-Linux-x86_64 /usr/bin/docker-compose
}

function installSoftware {
	echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1
	sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils -y < "/dev/null"
	npm install -g @subql/cli
	echo -e '\n\e[42mDone\e[0m\n'
}

setupSwap
installNodeJS
installDocker
installDockerCompose
installSoftware
