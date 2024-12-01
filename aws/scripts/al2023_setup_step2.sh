#!/bin/bash
set -x

# change to ec2-user
sudo su - ec2-user

# install nodejs
adsf install nodejs latest
asdf global nodejs latest
# install ruby
asdf install ruby 3.2.3
asdf global ruby 3.2.3

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
