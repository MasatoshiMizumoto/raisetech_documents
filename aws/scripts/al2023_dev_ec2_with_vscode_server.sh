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

echo """

インストールが終了しました。
この後はec2-userに切り替えて作業してください。（例:'sudo su - ec2-user'）
'code tunnel --accept-server-license-terms' を起動し、表示されたURLと8桁のcodeを使ってこのサーバーをgithubアカウントで認証してください。
その後、サーバーに表示された'http://vscode.dev/tunnel/****'のURLからアクセスできるようになります。
サーバーのOSを停止した場合、再度'code tunnel --accept-server-license-terms'を実行してください。

## English

Installation is complete.
Switch to ec2-user and work. (e.g. 'sudo su - ec2-user')
Run 'code tunnel --accept-server-license-terms' and authenticate this server with your github account using the URL and 8-digit code displayed.
After that, you can access the server from the URL 'http://vscode.dev/tunnel/****' displayed on the server.
If you stop the server OS, run 'code tunnel --accept-server-license-terms' again.
"""