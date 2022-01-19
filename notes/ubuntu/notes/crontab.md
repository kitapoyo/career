# ジョブスケジューリング
1. [定期的な処理の実行](#anchor1)
2. [システムレベルの crontab ファイル](#anchor2)
3. [ユーザー単位の crontab ファイル](#anchor3)

<a id="anchor1"></a>

## 1. 定期的な処理の実行
 - 定期的に実行する処理は **cron** によって自動化できます。
 - スケジュールは、システムレベルのものとユーザーごとのものに分けられます。
 - システムレベルのものは **crontab ファイル** で管理されています。
 - ユーザー単位の設定は **crontab コマンド** を実行することで管理します。

<a id="anchor2"></a>

## 2. システムレベルの crontab ファイル
 - **/etc/crontab** ファイルと、いくつかのディレクトリに格納された実行ファイルで構成されます。
 - **「 * 」** はワイルドカードです。**「 47 6 * * 7」 は、毎週日曜日の６時４７分**を表します。
 - 以下例では、１時間ごとに **/etc/cron.hourly** ディレリクトリ以下のスクリプトを実行する設定があります。

    ```:設定例
    # /etc/crontab: system-wide crontab
    # Unlike any other crontab you don't have to run the `crontab'
    # command to install the new version when you edit this file
    # and files in /etc/cron.d. These files also have username fields,
    # that none of the other crontabs do.

    # 環境変数の設定
    SHELL=/bin/sh
    PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

    # 具体的なスケジュール
    # m h dom mon dow user  command
    17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
    25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron. daily )
    47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron. weekly )
    52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron. monthly )
    #
    ```

### スケジュールの書式

 ```:書式
 分 時 日 月 曜日 実行ユーザー コマンド
 ```

### 日時に指定可能な値

|フィールド|設定可能な値|
|----|----|
|分|０～５９までの整数もしくは *|
|時|０～５９までの整数もしくは *|
|日|１～３１までの整数もしくは *|
|月|１～１２までの整数もしくは jan ~ dec までの月名もしくは *|
|曜日|０ \| 7 ( 日曜日 ) ～６ ( 土曜日 ) までの整数もしくは Sun ~ Sat までの文字列もしくは *|

<a id="anchor3"></a>

## 3. ユーザー単位の crontab ファイル
 - ユーザー単位はコマンドで行います。
 - **/var/spool/cron/crontabs/ ユーザー名** に作成されますが、直接編集はしません。
 - ファイルの編集操作・実行ログは **/var/log/syslog** ファイルに記録されます。

### 書式

 ```:コマンド書式
 crontab [ オプション ]
 ```

### オプション

|オプション|説明|
|---|---|
|-e|crontab ファイルを編集します。|
|-r|crontab ファイルの内容を削除します。|
|-i|crontab ファイルの内容を表示します。|

### crontab コマンドの制限
 - 以下のファイルにユーザー名を記述することで、ユーザー単位で cron コマンドの利用を制限することができます。
 - デフォルトではいずれのファイルが存在しないので、すべてのユーザーが cron を実行できます。
1. **/etc/cron.allow**
2. **/etc/cron.deny**

#### 評価の順序
1. **/etc/cron.allow** ファイルが存在すれば、そこに記述されたユーザーのみ cron を実行できます。
2. **/etc/cron.allow** が存在しなく、**/etc/cron.deny** が存在すれば、記述されていないすべてのユーザーが cron を実行できます。
3. どちらのファイルもなければ、すべてのユーザーが cron を実行できます。
