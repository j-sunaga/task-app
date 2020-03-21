#Readme

## Task-App

Task-Appはタスク管理アプリです。
・タスクの登録・編集・削除・更新機能
・タスクに対する期限・優先順位の設定
・タスクのステータス管理

## Dependency
Ruby:2.6.3

Rails:5.2.3

DB : PostgreSQL

### テーブル設計

#### users
|culumn  |type  |
|---|---|
|id  |integer  |
|name |string  |
|email |string  |

#### tasks
|culumn  |type  |
|---|---|
|id  |integer  |
|user_id  |integer  |
|task_name |string  |
|detail |string  |
|deadline  |date |
|status  |string  |
|priority  |string  |
|status  |string  |

#### labels
|culumn  |type  |
|---|---|
|id  |integer  |
|label |string  |
|friend_id |integer  |

#### task_labels
|culumn  |type  |
|---|---|
|id  |integer  |
|task_id |integer  |
|label_id |integer  |





