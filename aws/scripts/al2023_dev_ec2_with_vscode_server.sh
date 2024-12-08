#!/bin/bash
set -x

sudo dnf update -y
sudo dnf install -y git

# change to ec2-user
sudo su - ec2-user


# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install node

# Install rvm and ruby
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -sSL https://get.rvm.io | bash -s stable
## add source ~/.rvm/scripts/rvm to ~/.bashrc
echo 'source ~/.rvm/scripts/rvm' >> ~/.bashrc
source ~/.bashrc
rvm install 3.2.3

# install code-server
curl -Lk 'https://update.code.visualstudio.com/latest/linux-rpm-x64/stable' --output vscode.rpm
sudo dnf -y install ./vscode.rpm
rm vscode.rpm

# install mysql
sudo dnf -y install https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm
sudo dnf -y install mysql mysql-community-client
sudo dnf -y install mysql-community-server
sudo dnf -y install mysql-devel
sudo systemctl start mysqld

# install yarn
npm install -g yarn

# Install ImageMagick
sudo dnf -y install ImageMagick
sudo dnf -y install ImageMagick-devel
