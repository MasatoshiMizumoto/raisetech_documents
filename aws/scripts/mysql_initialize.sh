#!/bin/sh
set -x


# MySQLの停止
sudo service mysqld stop
# ファイルの削除
sudo su - <<EOF
cd /var/lib/mysql
rm -rf *
mysqld --initialize --user=mysql
EOF
