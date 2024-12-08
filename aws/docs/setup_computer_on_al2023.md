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
   5. [5. トラブルが発生したら](#5-トラブルが発生したら)
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

- 必須
  - AWS アカウント
  - GitHub アカウント
  - Web ブラウザ（Google Chrome、Microsoft Edge など）
- 推奨
  - PCに VS Code をインストールしている
  - VS Code の設定をGitHub と同期している

## 3. 注意事項、禁止事項

> [!NOTE]
> すべての資料は日本語で作成しています。日本語が母国語でない方は、翻訳ツールを使用してください。If you are not a native Japanese speaker, please use a translation tool.

> [!NOTE]
> 必要なものはすべて自動化によってインストールされますが、すべての作業工程が省略されるわけではありません。たとえば MySQL 自体はインストールされていますが、パスワードの再設定などは行っていません。

> [!WARNING]
> この手順は、皆さんの序盤の脱落を防ぐ為に環境構築作業を補助するものです。あくまで RaiseTech 学習カリキュラムの序盤においてのみ使用してください。本資料は、自分で環境構築を行う場合に必要なプログラム情報が一部含まれます。参考にしてください。

> [!WARNING]
> AWS フルコースの学習コンテンツはなるべく AWS 無料利用枠に収まるように調整していますが、すべての課題が無料ではありません。この資料内で構築される AWS リソースを 1 ヶ月間起動した場合、主に以下のリソース費用が無料利用枠と相殺され、超過分がクレジットカードから引き落とされます。
>
> 1. EC2 インスタンス（t3.small）=720 時間/月
> 2. EBS ボリューム（8GB）=720 時間/月
> 3. パブリック IP アドレス=720 時間/月

> [!CAUTION]
> この手順に含まれるスクリプトその他を最終課題に流用することは禁止します。「実装した理由を論理的に説明できないエンジニア」は、指示作業しかさせてもらえません。働き方も給与も、想像していたより厳しいものになるでしょう。

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



> [!NOTE]
> **サンプル**
> 
> すべてのコマンドが正常終了したときに出てくるメッセージのサンプルです。
> ```json
> [
>   [
>     {
>       "OutputKey": "CfnStackURL",
>       "OutputValue": "https://ap-northeast-1.console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/outputs?filteringStatus=active&viewNested=true&stackId=arn:aws:cloudformation:ap-northeast-1:123412341234:stack/al2023-study-instances/b543c710-b56f-11ef-bde0-06808a396929",
>       "Description": "CloudFormation Stack URL",
>       "ExportName": "al2023-study-instances-CfnStackURL"
>     },
>     {
>       "OutputKey": "SecurityGroupURL",
>       "OutputValue": "https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#SecurityGroup:groupId=sg-03a1bff6894048190",
>       "Description": "SecurityGroupURL of the AL2023 study instance",
>       "ExportName": "al2023-study-instances-SecurityGroupURL"
>     },
>     {
>       "OutputKey": "InstanceURL",
>       "OutputValue": "https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#InstanceDetails:instanceId=i-093a1f61d787e6d6a",
>       "Description": "InstanceURL of the AL2023 study instance",
>       "ExportName": "al2023-study-instances-InstanceURL"
>     }
>   ]
> ]
> ```

> [!WARNING]
> サンプル記載メッセージの URL は皆さんの環境では無効です。ご自身の環境で出力された URL を使用してください。

> [!IMPORTANT]
> CfnStackURL に記されている URL が、CloudFormation（自動化サービス） のスタック（とあるグルーピング単位）の URL です。このセクションに表示されている URL をブラウザに貼り付けることで、他のセクションの URL はリンク形式で確認できます。



### 4-2. RaiseTech 学習用コンピューターへの接続

1. 4-1 の CloudShell 画面に出ているうち、`CfnStackURL` の URL リンクをブラウザの新しいタブ（またはウィンドウ）に入力してください。CloudFormation スタックの出力ページが開きます。
2. 「InstanceURL」のリンクをクリックし、遷移したページの「接続」ボタンをクリックしてください。

> [!TIP]
> SecurityGroupURL はこの段階では使いませんが、Rails アプリケーションの接続許可設定を行う際に必要になります。

### 4-3. サンプルコード動作環境のセットアップ

1. 表示された画面に以下のコマンドを貼り付けします。1、2 と順番に行ってください。

```sh
#1
curl -o- 'https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/refs/heads/main/aws/scripts/al2023_dev_ec2_with_vscode_server.sh' | bash
```

```sh
#2
curl -o- 'https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/refs/heads/main/aws/scripts/al2023_libvips.sh' | bash
```

> [!NOTE]
> インストールはしばらくかかります。20 分で一度画面が終了する場合がありますが、その場合は再度接続してコマンドを入力してください。

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

> [!NOTE]
> **サンプルメッセージの一部**
> ```sh
> インストールが終了しました。
> この後はec2-userに切り替えて作業してください。
> （中略）
> ```

> [!TIP]
> 表示されている指示の大まかな流れは以下です。
>
> 1. 表示されているメッセージに従い、コマンドを実行します。
> 2. 表示された URL と認証コードをブラウザに入力します。GitHub へのログインが必要です。
> 3. VS Code server の起動が完了すると、接続用の URL が表示されます。
> 4. この URL にアクセスすることで、ブラウザ版の VS Code に接続できます。トンネル作成に使われたアカウントについて聞かれた場合は、「GitHub」を選択してください。

> [!WARNING]
> 今回作成した EC2 はパブリック IP アドレスが不定のため、ブラウザ版の VS Code をブックマークしても無効です。毎回 EC2のセッションマネージャーから起動してください。

> [!TIP]
> ブラウザ版の VS Code では必要に応じて EC2 のフォルダを開けます。ターミナルを表示させて Ruby のコードで HelloWorld を書いたり、課題のアプリケーション clone してからフォルダを開けるか確認してください。


## 5. トラブルが発生したら

### 5-1. EC2 インスタンスが起動しない

- EC2 を再起動してください。

### 5-2. セッションマネージャーで接続できない

- EC2 を再起動してください。
- セッションマネージャーは初期設定で 20 分無操作の場合、接続が切れます。

### 5-3. VS Code server が起動しない

- EC2 上で毎回起動コマンドを入れていただく必要があります。再度コマンドを入力してください。
- 2 回目以降は 8 桁の登録作業は不要です。
