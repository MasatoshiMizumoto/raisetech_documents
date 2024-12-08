1. [RaiseTech 学習用コンピューターのセットアップ手順](#raisetech-学習用コンピューターのセットアップ手順)
   1. [1. このドキュメントについて](#1-このドキュメントについて)
   2. [2. 動作環境、対象読者](#2-動作環境対象読者)
      1. [2-1. 対象読者](#2-1-対象読者)
      2. [2-2. 動作環境](#2-2-動作環境)
   3. [3. 注意事項、禁止事項](#3-注意事項禁止事項)
   4. [4. RaiseTech 学習用コンピューターのセットアップ手順](#4-raisetech-学習用コンピューターのセットアップ手順)
      1. [4-1. 事前準備](#4-1-事前準備)
      2. [4-2. RaiseTech 学習用コンピューターへの接続](#4-2-raisetech-学習用コンピューターへの接続)
      3. [4-3. サンプルコード動作環境のセットアップ](#4-3-サンプルコード動作環境のセットアップ)
   5. [5. トラブル発生用](#5-トラブル発生用)
      1. [5-1. EC2 インスタンスが起動しない](#5-1-ec2-インスタンスが起動しない)
      2. [5-2. セッションマネージャーで接続できない](#5-2-セッションマネージャーで接続できない)
      3. [5-3. VS Code server が起動しない](#5-3-vs-code-server-が起動しない)

# RaiseTech 学習用コンピューターのセットアップ手順

## 1. このドキュメントについて

このドキュメントは、RaiseTech 学習用コンピューターのセットアップ手順を記載しています。
この手順を実行すると、課題学習を進めるためのコンピューター環境が構築されます。

## 2. 動作環境、対象読者

### 2-1. 対象読者

RaiseTech で課題学習を行う方

### 2-2. 動作環境

- AWS アカウント
- GitHub アカウント
- Web ブラウザ（Google Chrome、Microsoft Edge など）

## 3. 注意事項、禁止事項

> [!NOTE]
> すべての資料は日本語で作成しています。日本語が母国語でない方は、翻訳ツールを使用してください。If you are not a native Japanese speaker, please use a translation tool.<br>
> 必要なものはすべて自動化によってインストールされますが、すべての作業工程が省略されるわけではありません。たとえば MySQL 自体はインストールされていますが、パスワードの再設定などは行っていません。

> [!WARNING]
> この手順は、皆さんの序盤の脱落を防ぐ為に環境構築を支援するものです。本来自分で調べていただきたいとを自動化しており、何をしているかもわかりにくくなっています。あくまで RaiseTech 学習カリキュラムの序盤においてのみ使用してください。<br>
> RaiseTech で提供している学習コンテンツの AWS 操作は、無料利用枠の対象外の操作も含まれています。そのため、AWS アカウントを使用する際は、課金についての理解を深めてから操作を行ってください

> [!CAUTION]
> この手順から流用したものをそのまま最終課題まで流用することは禁止します。IT 業界が求めている「自走力」を得られないままに最終課題を終えも、皆さんの殆どは目的を果たせないでしょう。

## 4. RaiseTech 学習用コンピューターのセットアップ手順

### 4-1. 事前準備

1. AWS マネジメントコンソールへログインします。リージョンが東京になっていることを確認してください。
2. [CloudShell](https://ap-northeast-1.console.aws.amazon.com/cloudshell/home?region=ap-northeast-1)を開きます。
3. CloudShell に以下のコマンドを入力して、RaiseTech 学習用コンピューターの CloudFormation スタックをデプロイします。

> [!TIP]
> 「複数行貼り付け」の警告は問題ありませんので、「貼り付け」を選択してください。

すべてが完了すると、JSON 形式のメッセージが出てきます。そのままウィンドウは開いておいてください。（次の手順で使います）

> [!TIP]
> もし JSON 形式のメッセージが出てこない場合は貼り付け時に最後の改行（実行）が抜けている、またはコマンドが欠けている疑いが強いです。投入されているコマンドを見直してください。

```sh
curl -o al2023_study_instances.yml 'https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/refs/heads/main/aws/templates/al2023_study_instances.yml'

aws cloudformation deploy --template-file al2023_study_instances.yml --stack-name al2023-study-instances --capabilities CAPABILITY_NAMED_IAM

aws cloudformation describe-stacks --stack-name al2023-study-instances --query 'Stacks[].Outputs'

```

**サンプル**

> [!IMPORTANT]
> すべてのコマンドが正常終了したときに出てくるメッセージのサンプルです。実際のメッセージは異なります。

```json
[
  [
    {
      "OutputKey": "SecurityGroupURL",
      "OutputValue": "https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#SecurityGroup:groupId=sg-0166a9997a251bbd4",
      "Description": "SecurityGroupURL of the AL2023 study instance",
      "ExportName": "al2023-study-instances-SecurityGroupURL"
    },
    {
      "OutputKey": "InstanceURL",
      "OutputValue": "https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#InstanceDetails:instanceId=i-026c10adf88e66b22",
      "Description": "InstanceURL of the AL2023 study instance",
      "ExportName": "al2023-study-instances-InstanceURL"
    }
  ]
]
```

### 4-2. RaiseTech 学習用コンピューターへの接続

1. 4-1 の CloudShell 画面に出ているうち、`InstanceURL` の URL リンクをブラウザの新しいタブ（またはウィンドウ）に入力してください。EC2 インスタンスの詳細画面が開きます。
2. 「接続」ボタンをクリックし、遷移したページの「接続」を押すことで、SSM セッションマネージャーを使って EC2 に接続できます。

### 4-3. サンプルコード動作環境のセットアップ

1. 表示された画面に以下のコマンドを貼り付けします。

```sh
curl -o- 'https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/refs/heads/main/aws/scripts/al2023_dev_ec2_with_vscode_server.sh' | bash
curl -o- 'https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/refs/heads/main/aws/scripts/al2023_libvips.sh' | bash
```

> [!TIP]
> 上記コマンドでは、後の課題に必要なライブラリやツールを裏側でインストールしています。
>
> - Ruby
> - Node.js
> - Yarn
> - MySQL
> - libvips
> - vscode-server

2. コマンドが完了すると、VS Code server を起動する手順の「メッセージ」が表示されます。指示にしたがって VS Code server を起動してください。

> [!IMPORTANT]
> このメッセージは一度だけ表示されます。必要に応じてメモを取ってください。

> [!TIP]
> 表示されている指示の大まかな流れは以下です。
>
> 1. 表示されているメッセージに従い、コマンドを実行します。
> 2. 表示された URL と認証コードをブラウザに入力します。GitHub へのログインが必要です。
> 3. VS Code server が起動し、接続用の URL が表示されます。
>
> この URL にアクセスすることで、ブラウザ版の VS Code に接続できます。
> 必要に応じて EC2 のフォルダを開けますので、Ruby のコードで HelloWorld を書いたり、課題のアプリケーションを起動できるか確認してください。

## 5. トラブル発生用

### 5-1. EC2 インスタンスが起動しない

- EC2 を再起動してください。

### 5-2. セッションマネージャーで接続できない

- EC2 を再起動してください。
- セッションマネージャーは初期設定で 20 分無操作の場合、接続が切れます。

### 5-3. VS Code server が起動しない

- EC2 上で毎回起動コマンドを入れていただく必要があります。再度コマンドを入力してください。
- 2 回目以降は 8 桁の登録作業は不要です。
