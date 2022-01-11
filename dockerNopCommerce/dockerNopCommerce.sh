#! /bin/bash

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt-get update
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Docker Compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# nopCommerce
sudo usermod -aG docker $USER
git clone https://github.com/nopSolutions/nopCommerce
cd nopCommerce
docker build -t nopcommerce .
docker run -d -p 80:80 nopcommerce

# MySQL
docker pull mysql
mkdir /var/lib/mysql -p
docker run -d --name mysql-server -p 3306:3306 -v /var/lib/mysql:/var/lib/mysql \
	-e "MYSQL_ROOT_PASSWORD=nopCommerce" mysql

echo 'set completion-ignore-case On' >> sudo /etc/inputrc
