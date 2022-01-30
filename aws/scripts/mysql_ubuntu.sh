#!/bin/sh

set -x

# mysqlサーバーを止める
sudo service mysql stop

# aptのアップデート
sudo apt -y update
# mariadbがある場合を想定して先に削除
sudo apt remove -y mysql-server
# sudo apt remove -y mariadb*
sudo apt autoremove -y
# sudo rm -rf /var/lib/mysql
# sudo rm -rf /etc/mysql

# インストール
#####################
# Ubuntuベース向け
# 2021/09時点
# もし最新のパッケージをインストールしたい場合は、パッケージURLを下記手順で調べて下さい
# わからない場合は無理せず書き替えずに使って下さい
#
# 1. https://dev.mysql.com/downloads/repo/apt/ へアクセス
# 2. Downloadボタンを押下（1つしかないはずです）
# 3. `No thanks, just start my download.`と表示されているリンクをコピーして、`$MYSQL_PACKAGE_URL`と差替
#####################

# MYSQL_PACKAGE_URL="https://dev.mysql.com/get/mysql-apt-config_0.8.19-1_all.deb"
MYSQL_PACKAGE_URL="https://dev.mysql.com/get/$(curl https://dev.mysql.com/downloads/repo/apt/ | grep mysql-apt-config -m 1 | cut -d'(' -f2 | cut -d')' -f1)"
# aptに8.0パッケージ情報を登録
TEMP_DEB="$(pwd)/mysql8.deb"
wget -O "$TEMP_DEB" "$MYSQL_PACKAGE_URL" && \
  sudo dpkg -i "$TEMP_DEB" && \
  rm -f "$TEMP_DEB"


