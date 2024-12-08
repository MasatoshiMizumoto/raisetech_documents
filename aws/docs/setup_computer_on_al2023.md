# RaiseTech 学習用コンピューターのセットアップ手順

## 1. このドキュメントについて
このドキュメントは、RaiseTech 学習用コンピューターのセットアップ手順を記載しています。
この手順を実行すると、課題学習を進めるためのコンピューター環境が構築されます。

## 2. 対象読者

RaiseTech で課題学習を行う方

## 3. 注意事項

この手順は、皆さんの環境構築を支援するためのものです。
RaiseTech 学習カリキュラムの序盤においてのみ使用してください。
とくに最終課題においてこの手順から流用したものをそのまま実装することは禁止します。


## 4. RaiseTech 学習用コンピューターのセットアップ手順

### 4.1. 事前準備


```sh
curl -o al2023_study_instances.yml 'https://raw.githubusercontent.com/MasatoshiMizumoto/raisetech_documents/refs/heads/add/vscode_server_script/aws/templates/al2023_study_instances.yml'

aws cloudformation deploy --template-file al2023_study_instances.yml --stack-name al2023-study-instances --capabilities CAPABILITY_NAMED_IAM

aws cloudformation describe-stacks --stack-name al2023-study-instances --query 'Stacks[].Outputs'

```
