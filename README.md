# README

## user
|カラム|データ型|用途|
| --- | --- | --- |
|name|string|氏名入力|
|email|string|メールアドレス入力|
|password|string|パスワード入力|

## task
|カラム|データ型|用途|
| --- | --- | --- |
|theme|string|タスク概要入力|
|content|text|タスク内容入力|
|priority|integer|優先順位を1~3で表示|
|status|integer|状況を1~3で表示|
|time_limit|date|完了日選択|
|user_id|integer|Foreign Key|

## task_label
|カラム|データ型|用途|
| --- | --- | --- |
|task_id|integer|Foreign Key|
|label_id|integer|Foreign Key|

## task_label
|カラム|データ型|用途|
| --- | --- | --- |
|category|string|ラベル入力|
