- [Git の初期設定〜GitHub へのプルリクエスト（PR）まで](#git-の初期設定github-へのプルリクエストprまで)
  - [はじめに：かならず読んでください](#はじめにかならず読んでください)
  - [1. GitHub のアカウント作成](#1-github-のアカウント作成)
  - [2. Git の初期設定](#2-git-の初期設定)
  - [3. GitHub 個人アクセストークンの作成](#3-github-個人アクセストークンの作成)
  - [4. GitHub のリポジトリ作成](#4-github-のリポジトリ作成)
  - [5. GitHub リポジトリのクローン](#5-github-リポジトリのクローン)
  - [6. 作業用ブランチの作成と現在ブランチの切替(checkout)](#6-作業用ブランチの作成と現在ブランチの切替checkout)
  - [7. ファイルの作成・変更](#7-ファイルの作成変更)
  - [8. ファイルのステージング(add)](#8-ファイルのステージングadd)
  - [9. ファイルのコミット](#9-ファイルのコミット)
  - [10. ステージング情報のプッシュ](#10-ステージング情報のプッシュ)
  - [11. プルリクエスト（PR）](#11-プルリクエストpr)
  - [12. プルリクエスト（PR）のマージ（ブランチ統合）](#12-プルリクエストprのマージブランチ統合)
  - [13. main ブランチでのマージ結果の確認](#13-main-ブランチでのマージ結果の確認)
  - [14. 不要になったブランチの削除](#14-不要になったブランチの削除)
  - [15. おわりに](#15-おわりに)

# Git の初期設定〜GitHub へのプルリクエスト（PR）まで

## はじめに：かならず読んでください

- このドキュメントでは、Git と GitHub を使った変更管理の操作を説明します。
- Git や GitHub の操作はなるべく詳しく書いていますが、それ以外の説明、手順は省略していますので、ご自身で調べてください。
- 操作しながら Git や GitHub の理解を深めてもらうのが目的なので、「**読むだけでなく、実際に操作を行って**」ください。
  - 1 つ 1 つ「**操作が成功しているか**」確認しながら進めてください。失敗に気がつかずに操作を続けている方のご質問が多く来ています。
  - サンプルコマンドのコメント情報も必ず読んでください。コメントにあることを質問されている方もいらっしゃいます。
  - `git init`、`git remote add`など、「**この資料に書いていないことは基本的に操作不要**」です。
- コマンドやフロー図を都度掲載していますので、今どこまで進んでいるかの参考にしてください。
- 途中、「ローカル PC」という表記がありますが、Cloud9 を使っている方は Cloud9 と読み替えていただいて結構です。
- 基本的には「**章ごとに正しく動作しているか確認すること**」を意識してください。おかしいと感じたら Discord で質問してください。

## 1. GitHub のアカウント作成

- [公式サイト](https://docs.github.com/ja/get-started/signing-up-for-github/signing-up-for-a-new-github-account)や他のサイトを見ながら、GitHub アカウントを作成してください。
- 次の手順で個人メールアドレスを公開したくない場合、GitHub アカウント作成後に確認できる、受信専用のメールアドレス入手をわすれずに。（授業で説明済）

## 2. Git の初期設定

- コミット履歴に残るあなたの名称、連絡先等の初期設定を行ってください。
- 設定については授業スライドで説明済です。

## 3. GitHub 個人アクセストークンの作成

- [公式サイト](https://docs.github.com/ja/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)や他のサイトを見ながら、GitHub 個人アクセストークンを作成してください。
- 二種類ありますが`Fine-grained personal access tokens`が推奨です。
- 有効期限は無期限で構いませんが、無くしたり盗まれたりしないようにしてください。
- 書き込み権限は明示的に与える必要があります。忘れるとこの後 push で躓くので注意しましょう。以下のいずれかで可能です。

| 方式                                  | 操作                                                                                                                                    |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `Fine-grained personal access tokens` | `Repository access`・・・`All repositories`または作成済の操作したいリポジトリを選ぶ<br>`Permissions`・・・`contents` : `Read and write` |
| `classic`                             | リポジトリを条件に含められないので `repo`にチェック。                                                                                   |

## 4. GitHub のリポジトリ作成

- リポジトリを作成してください。名称に希望がなければ`RaiseTech`でも構いません。
- `README.md` ファイルを同時に作成する方法で実施してください。
  - もし忘れた場合は、ブランクコミット（空コミット）が必要なはずです。ブランクコミットの方法は調べて実施してください。

```mermaid
sequenceDiagram
  participant A as ローカルPC
  participant B as GitHub
  B->>B: リポジトリ作成
```

## 5. GitHub リポジトリのクローン

- ローカル PC にリポジトリをクローンしてください。
- リポジトリの URL は、GitHub のリポジトリ画面の「Code」ボタンを押下すると表示されます。
- クローンの方法は、授業スライドで説明済です。
- 【注意】クローン後、リポジトリのディレクトリに必ず移動してください。移動できていないとこのハンズオンは失敗します。
  - ここが失敗している問い合わせが非常に多いです。

```sh
git clone https://???
cd ???


```

```mermaid
sequenceDiagram
  participant A as ローカルPC
  participant B as GitHub
  B-->>B: リポジトリ作成
  B->>A: git clone https://???
  A->>A: cd ???
```

## 6. 作業用ブランチの作成と現在ブランチの切替(checkout)

- `git-lecture`という名前の作業用ブランチを作成し、`main`から`git-lecture`へ切替（移動=checkout）をしてください。一度にやることもできれば、作成と切替を別々にやることもできます。
- git はいくつかの alternative（同じ意味を持つ）なコマンドがあります。以下のコマンドはすべて同じ結果になります。覚えやすいものを使ってください。
  - `git checkout -b git-lecture`
  - `git switch -c git-lecture`

```sh
git checkout -b git-lecture

# 以下のコマンドでもOKです。
# git switch -c git-lecture
```

現在の状態は以下のようになります。

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A->>B: git checkout -b git-lecture
```

## 7. ファイルの作成・変更

- `git-lecture.md`の名前で Markdown ファイルを作ってください。
- 中身は自由で構いませんが、空にはしないでください。
- ファイルの作成は、ターミナルなら`touch`コマンドで行えます。エディター上のファイルツリー画面などを使ってもらっても結構です。
- 変更の保存忘れには注意しましょう。

```sh
touch git-lecture.md
```

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B->>B: touch git-lecture.md
```

## 8. ファイルのステージング(add)

- `git-lecture.md`をステージングエリアに格納します。
- ステージングは、`git add`コマンドで行います。

```sh
git add git-lecture.md

# すべてのファイルをステージングする場合は、以下のコマンドでもOKです。
# git add .
```

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B->>B: git add git-lecture.md
```

## 9. ファイルのコミット

- `git-lecture.md`をコミットしてください。
- コミットは、`git commit`コマンドで行います。

```sh
git commit -m "add git-lecture.md"
```

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B-->>B: git add git-lecture.md
  B->>B: git commit -m "add git-lecture.md"
```

## 10. ステージング情報のプッシュ

- `git-lecture.md`をリモートリポジトリ（GitHub）へプッシュしてください。
- プッシュは、`git push`コマンドで行います。
- GitHub のユーザー名とパスワードを聞かれますので入力してください。
- ユーザー名はアカウント開設したときの名称で、リポジトリ URL に含まれています。
- パスワードは、GitHub 個人アクセストークン（PAT）です。
  - すでにお伝えしたとおりですが、PAT で書き込み権限が与えられていないとエラーになります。

```sh
git push origin git-lecture

# （参考）git pushまでしか入力せずに実行すると、指定が必要な元先のブランチ名称を教えてくれます
#git push

# usernameを入力
# passwordはPATのことです。入力文字は見えません。
```

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B-->>B: git add git-lecture.md
  B-->>B: git commit -m "add git-lecture.md"
  B->>C: git push origin git-lecture
```

## 11. プルリクエスト（PR）

- GitHub のリポジトリ画面を確認すると、新しいブランチがプッシュされたことを検知していますので、プルリクエスト（PR）を作成してください。
- タイトルと本文は自由に書いて構いませんが、プルリクエストの目的は「人にレビューをしてもらう」ことです。レビューしてほしいポイントや、あなたがやったことを簡潔に書くのが良いでしょう。
- `File changed`タブをクリックすると、変更内容が表示されます。今回は`git-lecture.md`の追加が示されているはずです。
  - 実際のレビューはこの画面を見て行いますので、レビューしてほしいファイルが不足していないか、内容が正しいかを毎回確認してください。

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B-->>B: git add git-lecture.md
  B-->>B: git commit -m "add git-lecture.md"
  B-->>C: git push origin git-lecture
  C->>C: プルリクエスト（PR）を作成
  C->>C: プルリクエスト（PR）の内容を確認
```

## 12. プルリクエスト（PR）のマージ（ブランチ統合）

- 今回はレビュアーが居ませんので、そのままマージしてもらって OK です。
- マージも 1 つのコミット操作になるので、コメントが求められます。自動で埋まっているはずですが、内容を変更したければ変更してもらって構いません。
- 勘違いしないように注意ですが、あくまでマージされるのは GitHub 内です。ローカル PC には反映されていません。

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B-->>B: git add git-lecture.md
  B-->>B: git commit -m "add git-lecture.md"
  B-->>C: git push origin git-lecture
  C-->>C: プルリクエスト（PR）を作成
  C-->>C: プルリクエスト（PR）の内容を確認
  C->>C: プルリクエスト（PR）のマージ承認
  B->>A: マージ
```

## 13. main ブランチでのマージ結果の確認

- マージが完了すると、GitHub のリポジトリ画面の`main`ブランチでは`git-lecture.md`が追加されているはずです。
- だだし、ローカル PC にはまだ`main`ブランチの変更が反映されていません。
- これを反映させるには、ブランチを`main`に切り替えて、`git pull`コマンドを使います。
- `git-lecture.md`が存在することを確認してください。
- この pull 操作をコース中忘れる方が非常に多いので、必ず課題をスタートするときは main ブランチが最新の状態であることを確認してください。わからなければとりあえず pull する癖をつけてください。

```sh
git checkout main
git pull
ls
cat git-lecture.md
```

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B-->>B: git add git-lecture.md
  B-->>B: git commit -m "add git-lecture.md"
  B-->>C: git push origin git-lecture
  C-->>C: プルリクエスト（PR）を作成
  C-->>C: プルリクエスト（PR）の内容を確認
  C-->>C: プルリクエスト（PR）のマージ承認
  B-->>A: マージ
  A->>A: git checkout main
  A->>A: ファイルの確認
```

## 14. 不要になったブランチの削除

- 作業用のブランチは自動で消えません。
- `git-lecture`ブランチを削除してください。
- ブランチの削除は、`git branch -d`コマンドで行います。

```sh
git branch -d git-lecture
```

```mermaid
sequenceDiagram
  participant A as main
  participant B as git-lecture
  participant C as GitHub
  A-->>B: git checkout -b git-lecture
  B-->>B: touch git-lecture.md
  B-->>B: git add git-lecture.md
  B-->>B: git commit -m "add git-lecture.md"
  B-->>C: git push origin git-lecture
  C-->>C: プルリクエスト（PR）を作成
  C-->>C: プルリクエスト（PR）の内容を確認
  C-->>C: プルリクエスト（PR）のマージ承認
  B-->>A: マージ
  A-->>A: git checkout main
  A-->>A: ファイルの確認
  B-xB: git branch -d git-lecture
```

## 15. おわりに

- 以上が、Git と GitHub を使った変更管理の操作のすべてです。
- これらの操作を繰り返すことで、変更履歴を残しながら、複数人での開発を行うことができます。
- 個人練習として、`git-lecture.md`を削除する PR を作成してみるのも良いでしょう。
- 課題もやることはほとんど変わりません。「できそうだな」と思えたタイミングで実際にやってみましょう。
- 課題もリポジトリ名称に希望がなければ、このリポジトリをそのまま使っていただければ一部手順を省略できます。
