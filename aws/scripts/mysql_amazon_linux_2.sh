#!/bin/sh
set -x

# yumのアップデート
sudo yum -y update

# mariadbがある場合を想定して先に削除
sudo yum remove -y mysql-server
sudo yum remove -y mariadb*

# インストール
#####################
# Amazon Linux2ベース向け
# 2021/09時点
# もし最新のパッケージをインストールしたい場合は、パッケージURLを下記手順で調べて下さい
# わからない場合は無理せず書き替えずに使って下さい
#
# 1. https://dev.mysql.com/downloads/repo/yum/ へアクセス
# 2. `Red Hat Enterprise Linux 7 ...`のDownloadボタンを押下
# 3. `No thanks, just start my download.`と表示されているリンクをコピーして、`$MYSQL_PACKAGE_URL`と差替
#####################

# MYSQL_PACKAGE_URL="https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm"
MYSQL_PACKAGE_URL="https://dev.mysql.com/get/$(curl https://dev.mysql.com/downloads/repo/yum/ | grep el7 | cut -d'(' -f2 | cut -d')' -f1)"
sudo yum localinstall -y $MYSQL_PACKAGE_URL
sudo yum install -y mysql-community-devel
sudo yum install -y mysql-community-server

# MySQLサーバーの起動＆確認
sudo service mysqld start && sudo service mysqld status
