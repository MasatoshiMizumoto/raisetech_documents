
- [Cloud9 上での MySQL セットアップ方法(Amazon Linux 2編)](#cloud9-上での-mysql-セットアップ方法amazon-linux-2編)
  - [事前準備（OS 共通作業）](#事前準備os-共通作業)
    - [ディスク容量を確保する](#ディスク容量を確保する)
  - [インストール手順](#インストール手順)
    - [MySQLのインストール](#mysqlのインストール)
    - [初期パスワードの入手＆動作確認](#初期パスワードの入手動作確認)

# Cloud9 上での MySQL セットアップ方法(Amazon Linux 2編)

- 必ず事前準備の項目を実施してください。
- 次に、環境と手順が合っているか確認してください。
  - aptが使えればUbuntuです。
  - yumが使えればAmazon Linux（1または2）です。

## 事前準備（OS 共通作業）

### ディスク容量を確保する

- Cloud9 の初期状態ではストレージ容量が不足しますので、**必ず**下記のいずれかで空きを増やして下さい。

1. `docker system prune -a`を入力して y で実施する（不要 Docker イメージを削除して空きを作る）
2. Cloud9 が動作している EC2 の EBS サイズを 10GB→16GB くらいに上げる（`Cloud9 EBS サイズ変更`で検索してください）


**次からはOS別作業です。自分のOSの手順を進めてください。違うOSの手順は動きません。（互いに存在しないコマンドがあるため）**

## インストール手順

### MySQLのインストール

- Amazon Linux 2にはMariaDBという、MySQL互換のDBサーバーが既にインストールされていますが、これを削除してからMySQL8.0をインストールします。
- 下記のコマンドを使ってインストールします。
- 手入力する必要はありません。コードブロックの右上に出るアイコンがコピーボタンです。

```sh
# 以下を貼り付け
curl -fsSL https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/main/aws/scripts/mysql_amazon_linux_2.sh | sh
```

- 正常に起動すると、以下のような表示になります。

```
##########サンプル##########
# Redirecting to /bin/systemctl start mysqld.service
# Redirecting to /bin/systemctl status mysqld.service
# ● mysqld.service - MySQL Server
#    Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
#    Active: active (running) since 日 2021-09-05 15:20:19 UTC; 31ms ago
#      Docs: man:mysqld(8)
#            http://dev.mysql.com/doc/refman/en/using-systemd.html
#   Process: 8671 ExecStartPre=/usr/bin/mysqld_pre_systemd (code=exited, status=0/SUCCESS)
#  Main PID: 8802 (mysqld)
#    Status: "Server is operational"
#     Tasks: 38
#    Memory: 487.4M
#    CGroup: /system.slice/mysqld.service
#            └─8802 /usr/sbin/mysqld
####################
```

- 上記サンプルのように、Activeが「active (running)」であることを確認してください。

### 初期パスワードの入手＆動作確認

- 接続の確認をします。インストーラが自動でパスワードを発行しているので、下記コマンドで確認してください。
- Railsアプリケーションにも登録が必要です。控えておくか、その時が来たら確認するかは自由です。

```sh
# 初期パスワードの確認
sudo cat /var/log/mysqld.log | grep "temporary password" | awk '{print $13}'

# ↑で出てこない場合（出て来た場合は飛ばしてOK）
sudo cat /var/log/mysqld.log | grep "temporary password"


# ログイン確認　パスワード要求が出るので控えたパスワードを入力
mysql -u root -p
```

- 接続成功画面のサンプルは以下の通りです。

```
##########サンプル##########
# Welcome to the MySQL monitor.  Commands end with ; or \g.
# Your MySQL connection id is 11
# Server version: 8.0.26 MySQL Community Server - GPL

# Copyright (c) 2000, 2021, Oracle and/or its affiliates.

# Oracle is a registered trademark of Oracle Corporation and/or its
# affiliates. Other names may be trademarks of their respective
# owners.

# Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
####
```

- サンプルのような表示が出たらセットアップ完了です。exitで終了してください。
- 手順は以上です。Railsアプリケーションの作成に進んで下さい。
