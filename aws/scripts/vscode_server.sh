#!/bin/bash
set -x

# change to ec2-user
sudo su - ec2-user

# Install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install node

# Install rvm
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -sSL https://get.rvm.io | bash -s stable
source ~/.bashrc
rvm install 3.2.3

# install code-server
curl -Lk 'https://update.code.visualstudio.com/latest/linux-rpm-x64/stable' --output vscode.rpm
sudo yum install -y ./vscode.rpm

echo """

インストールが終了しました。
'code tunnel --accept-server-license-terms' を起動し、githubアカウントで認証してください。
'vscode.dev'からアクセスできます。
サーバーのOSを停止した場合、再度'code tunnel --accept-server-license-terms'を実行してください。

## English

Installation is complete.
Run 'code tunnel --accept-server-license-terms' and authenticate with your github account.
You can access it from 'vscode.dev'.
If you stop the server OS, run 'code tunnel --accept-server-license-terms' again.
"""
