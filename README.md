# README

## 使用技術
* ruby 2.6.5
* Rails 5.2.4.3

## Herokuへのデプロイ手順
1. heroku loginコマンドで、Herokuにログイン
2. heroku create <アプリ名※省略化>コマンドを使い、Herokuに新規プリケーションを作成
 * 次の形式のURLが設定される「https://*******.herokuapp.com/」 ※ アプリ名を省略した場合は、********部分は自動的に設定される。
 * 上記URLがアプリのURL及Gitリポジトリとなる。
3. git push heroku masterコマンドを使い、Herokuにpushすることでデプロイ
4. heroku run rails db:migrateコマンドを使い、Heroku上にデータベースを作成

## テーブルの構想
### user
|カラム|データ型|用途|
| --- | --- | --- |
|name|string|氏名入力|
|email|string|メールアドレス入力|
|password|string|パスワード入力|

### task
|カラム|データ型|用途|
| --- | --- | --- |
|theme|string|タスク概要入力|
|content|text|タスク内容入力|
|priority|integer|優先順位を1~3で表示|
|status|integer|状況を1~3で表示|
|time_limit|date|完了日選択|
|user_id|integer|Foreign Key|

### task_label
|カラム|データ型|用途|
| --- | --- | --- |
|task_id|integer|Foreign Key|
|label_id|integer|Foreign Key|

### label
|カラム|データ型|用途|
| --- | --- | --- |
|category|string|ラベル入力|
