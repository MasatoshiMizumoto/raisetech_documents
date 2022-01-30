
- [Cloud9 上での MySQL セットアップ方法](#cloud9-上での-mysql-セットアップ方法)
  - [事前準備（OS 共通作業）](#事前準備os-共通作業)
    - [ディスク容量を確保する](#ディスク容量を確保する)
  - [Amazon Linux](#amazon-linux)
    - [インストール](#インストール)
    - [動作確認＆初期パスワードの入手](#動作確認初期パスワードの入手)
  - [Ubuntu](#ubuntu)
    - [インストール](#インストール-1)
    - [動作確認＆初期パスワードの入手](#動作確認初期パスワードの入手-1)
    - [MySQLの設定](#mysqlの設定)

# Cloud9 上での MySQL セットアップ方法

- 事前準備を必ず実施してください。
- その後からはOS 別に記載していますので、対象の OS で手順を進めて下さい。
  - aptが使えればUbuntuです。
  - yumが使えればAmazon Linux（1または2）です。

## 事前準備（OS 共通作業）

### ディスク容量を確保する

- Cloud9 の初期状態ではストレージ容量が不足しますので、**必ず**下記のいずれかで空きを増やして下さい。

1. `docker system prune -a`を入力して y で実施する（不要 Docker イメージを削除して空きを作る）
2. Cloud9 が動作している EC2 の EBS サイズを 10GB→16GB くらいに上げる（`Cloud9 EBS サイズ変更`で検索してください）


**次からはOS別作業です。自分のOSの手順を進めてください。違うOSの手順は動きません。（互いに存在しないコマンドがあるため）**

## Amazon Linux 2

### インストール

- Amazon Linux 2にはMariaDBという、MySQL互換のDBサーバーが既にインストールされていますが、これを削除してからMySQL8.0をインストールします。
- 下記のコマンドを使ってインストールします。
- 手入力する必要はありません。（不要な手入力は誤入力の元なので、詳細な手順があるときはコピペするのがセオリーです。）

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

## Ubuntu

### インストール

- MySQL5.7が既にインストールされています。これで構わない場合はインストールは不要です。
  - `sudo service mysql start && sudo service mysql status`で起動と動作確認ができます。
  - ただし現在は8.0が最新なので、そこは意識しておきましょう。
- 8.0を使いたい場合は必要な場合は次の手順を使ってインストールしてください。
- 手入力する必要はありません。（不要な手入力は誤入力の元なので、詳細な手順があるときはコピペするのがセオリーです。）

```sh
curl -fsSL https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/main/aws/scripts/mysql_ubuntu.sh | sh
```

- Ubuntuでのインストールはガイダンスに従って設定が必要ですが、TABキーでOKにフォーカスしてEnterキーで進めてください。
- OKと返っていれば次へ進んで構いません。

- その後は以下の通りに進めます。

```sh
# aptの更新
sudo apt update
# インストール
sudo apt install -y mysql-server

#####################
# 下記の順序で操作
# 1. 既にデータがあるようなので本当にインストールするかという意味なのでそのままEnterでする
# 2. MySQLのルートパスワードを決めろと言われるのでそのままEnter＝なしとして定義
# 3. Use Legacyのほうを選んでEnter（新しい形式RECOMMENDは接続が大変なのでこちらで）
#####################

# 既に実施していると思いますが、ストレージ容量の確保をしていないと問題が発生します。
# （ダウンロード、インストールできる空きが足りなくなる）
# MySQLサーバーの確認
sudo service mysql status
```

- インストールが終わったら、動作確認をしてください。

```
##########サンプル##########
# ● mysql.service - MySQL Community Server
#    Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
#    Active: active (running) since Mon 2021-09-06 14:31:06 UTC; 15s ago
#      Docs: man:mysqld(8)
#            http://dev.mysql.com/doc/refman/en/using-systemd.html
#  Main PID: 5486 (mysqld)
#    Status: "Server is operational"
#     Tasks: 38 (limit: 1140)
#    CGroup: /system.slice/mysql.service
#            └─5486 /usr/sbin/mysqld

# Sep 06 14:30:53 ip-172-31-26-72 systemd[1]: Starting MySQL Community Server...
# Sep 06 14:31:06 ip-172-31-26-72 systemd[1]: Started MySQL Community Server.
####################
```
- サンプルのように、Activeが「active (running)」であれば完了です。

### 動作確認

- 下記コマンドで実施してください。

```sh
# 初期パスワードの確認=なしにしたので不要

# ログイン確認　パスワードはないのでそのままEnter
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
