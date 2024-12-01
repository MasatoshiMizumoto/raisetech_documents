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

Step1は完了です。
EC2を再起動（インスタンスを再起動）して、改めてStep2のスクリプトを実行してください。

## English

Step1 is done.
Restart EC2 (restart the instance) and run the Step2 script again.


"""
