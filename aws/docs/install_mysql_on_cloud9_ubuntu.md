
- [Cloud9 上での MySQL セットアップ方法(Ubuntu編)](#cloud9-上での-mysql-セットアップ方法ubuntu編)
  - [事前準備（OS 共通作業）](#事前準備os-共通作業)
    - [ディスク容量を確保する](#ディスク容量を確保する)
  - [インストール手順](#インストール手順)
    - [MySQLのインストール](#mysqlのインストール)
    - [動作確認](#動作確認)
  - [（補足）パスワードの変更](#補足パスワードの変更)

# Cloud9 上での MySQL セットアップ方法(Ubuntu編)

- 必ず事前準備の項目を実施してください。
- 次に、環境と手順が合っているか確認してください。
  - aptが使えればUbuntuです。
  - yumが使えればAmazon Linux（1または2）です。

## 事前準備（OS 共通作業）

### ディスク容量を確保する

- Cloud9 の初期状態ではストレージ容量が不足しますので、**必ず**下記のいずれかで空きを増やしてください。

1. `docker system prune -a`を入力して y で実施する（不要 Docker イメージを削除して空きを作る）
2. Cloud9 が動作している EC2 の EBS サイズを 10GB→16GB くらいに上げる（`Cloud9 EBS サイズ変更`で検索してください）

## インストール手順

### MySQLのインストール

- MySQL5.7がすでにインストールされています。これで構わない場合インストールは不要です。
  - `sudo service mysql start && sudo service mysql status`で起動と動作確認ができます。
  - ただし現在は8.0が最新なので、そこは意識しておきましょう。
- 8.0を使いたい場合は次の手順を使ってインストールしてください。
- 手入力する必要はありません。コードブロックの右上に出るアイコンがコピーボタンです。

```sh
curl -fsSL https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/main/aws/scripts/mysql_ubuntu.sh | sh
```

- Ubuntuでのインストールはガイダンスにしたがって設定が必要ですが、カーソルキーでOKをフォーカスしたらEnterキーで進めてください。
- `OK`と返っていれば次へ進んで構いません。

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

- インストールが終わったら、正常に起動したか確認してください。

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
- 手順は以上です。Railsアプリケーションの作成に進んでください。

## （補足）パスワードの変更

- 初期パスワードだと接続できないことがあるようなので、パスワード変更の手順も記載しておきます。
- MySQLへログインしてから操作してください。

```
ALTER USER 'root'@'localhost' IDENTIFIED BY '設定するパスワード';
FLUSH PRIVILEGES;
```
