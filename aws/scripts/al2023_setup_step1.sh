#!/bin/bash
set -x

# change to ec2-user
sudo su - ec2-user

# install asdf
sudo dnf -y install git
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc

# shell reload
source ~/.bash_profile

## plugin
asdf plugin add nodejs
asdf plugin update nodejs
asdf plugin add ruby
asdf plugin update ruby

echo """

サーバーを再起動します。
再起動後、Step2のスクリプトを実行してください。

## English

This server will be rebooted.
After reboot, please run the script for Step2.

"""

sleep 10
sudo reboot
