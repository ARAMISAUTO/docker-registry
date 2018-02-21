.PHONY: install cert
SHELL=/bin/bash

# install
install: install-deb cert

# install-deb
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
install-deb:
	if [ `lsb_release -si` == "Debian" ] || [ `lsb_release -si` == "Ubuntu" ]; then \
		sudo apt-get -y remove docker docker-engine docker.io; \
		sudo apt-get -y update; \
		sudo apt-get -y install apt-transport-https ca-certificates curl openssl software-properties-common; \
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -; \
		if [ `lsb_release -si` == "Debian" ]; then \
			sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/`. /etc/os-release; echo "$$ID"` `lsb_release -cs` stable"; \
		else \
			sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu `lsb_release -cs` stable"; \
		fi; \
		sudo apt-get -y update; \
		sudo apt-get -y install docker-ce; \
		sudo docker run hello-world; \
		sudo usermod -a -G docker $$USER; \
		sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose; \
		sudo chmod +x /usr/local/bin/docker-compose; \
	fi

cert:
	mkdir -p certs
	openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 365 -out certs/domain.crt \
		-subj "/C=FR/ST=Some State/L=Some City/O=Some Organization/OU=IT Department/CN=$${REGISTRY_HOST:=localhost}"
