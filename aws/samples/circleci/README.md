# CircleCI サンプルコンフィグ

- CircleCI のサンプルコンフィグです。

## 使い方

- [公式ドキュメント通り](https://circleci.com/docs/ja/2.0/getting-started/)に操作して動作について理解したら、課題のリポジトリでプロジェクトの設定、を行い、`config.yml`を提供したものに書き替えてください。
- 以下の動作がコミットのタイミングで行われるよう定義してあります。課題の参考にしてください。
  - [cfn-lint](https://github.com/aws-cloudformation/cfn-lint)が`cloudformation`ディレクトリ内の`yml`ファイルをチェックする

```
.circleci
  └── config.yml
```
