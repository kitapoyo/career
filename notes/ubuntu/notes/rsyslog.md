# rsyslog
1. [rsyslog](#anchor1)
2. [/etc/rsyslog.conf ファイル](#anchor2)
3. [/etc/rsyslog.d/ ディレクトリ](#anchor3)
4. [logger コマンドによるチェック](#anchor4)

<a id="anchor1"></a>

## 1. rsyslog
 - **/etc/rsyslog.conf** ファイルと **/etc/rsyslog.d/** ディレクトリ以下のファイルで設定します。

    ```:コマンド
    sudo cat /etc/rsyslog.conf
    ```

    ```:コマンド
    ls /etc/rsyslog.d
    ```

 - 設定を変更した場合は、再起動が必要です。

    ```:コマンド
    sudo systemctl restart rsyslog
    ```

<a id="anchor2"></a>

## 2. /etc/rsyslog.conf ファイル
 - プラグイン・モジュールやグローバル設定などを記述します。
 - デフォルトでは **imuxsock** と **imklog** モジュールが有効になってます。

    |プラグイン・モジュール|説明|
    |---|---|
    |imuxsock|UNIX ソケットによるローカルロギングサポート|
    |imklog|カーネルのログサポート|
    |immark|マークを出力 ( --MARK-- )|
    |imudp|UDP でメッセージを受信|
    |imtcp|TCP でメッセージを受信|

<a id="anchor3"></a>

## 3. /etc/rsyslog.d/ ディレクトリ
 - どのようなメッセージを何処に出力するかを設定します。
 - **~ .conf** ファイルに設定を記述します。

    ```:コマンド
    cat /etc/rsyslog.d/50-default.conf
    ```

    ```:表示例
    auth,authpriv.*                 /var/log/auth.log
    *.*;auth,authpriv.none          -/var/log/syslog
    ```
     - １行目は、認証のログをプライオリティ関係なく **/var/log/auth.log** に出力すると言う意味です。
     - ２行目は、認証のログ以外は **/var/log/syslog** に出力するという意味です。
 - カーネルのログをすべて **/var/log/kern.log** ファイルに出力する場合

     ```:表示例
     kern.*                          -/var/log/kern.log
     ```

### 書式
 - メッセージの出力先は、ログファイルやユーザーの端末などアクションフィールドと呼ばれます。
 - 基本は、設定したプライオリティより重要度が高いログが出力されます。
 - プライオリティの前の **.** を **=** にすると、指定したプライオリティのみ出力されます。

    ```:設定例
    ファシリティ.プライオリティ 出力先
    ```

### ファシリティ

|ファシリティ|説明|
|---|---|
|auth , authpriv|認証システムによる出力|
|cron|cron による出力|
|deamon|各種デーモンによる出力|
|kern|カーネルによる出力|
|lpr|印刷しステンによる出力|
|mail|メールサービス関連による出力|
|user|ユーザーアプリケーションによる出力|
|local0 ~ local7|ローカルシステムの設定|

### プライオリティ

|プライオリティ|説明|
|---|---|
|emerg|緊急事態|
|alert|早急に対処が必要な事態|
|crit|システムの継続はできるが深刻な状態|
|err|一般的なエラー|
|warning|一般的な警告|
|notice|一般的な通知|
|info|一般的な情報|
|debug|デバッグ情報|
|none|ログを記録しない|

### アクションフィールド

|アクションフィールド|説明|
|---|---|
|/var/log/messeges|ログファイルに出力|
|/dev/tty1|コンソール ( tty1 ) に出力|
|@sv.example.com|ホスト sv.example.com に UDP で出力|
|@@sv.example.com|ホスト sv.example.com に TCP で出力|
|hoge|ユーザー hoge の端末に出力|
|*|ログイン中のすべてのユーザーに出力|

<a id="anchor4"></a>

## 4. logger コマンドによるチェック
 - ログメッセージを生成することができます。
 - **rsyslog.conf** の設定確認に利用できます。

    ```:コマンド
    logger [ -p ファシリティ.プライオリティ ] [ -t タグ ] メッセージ
    ```

 - ファシリティ： syslog 、プライオリティ： err 、タグ： Test でログメッセージを生成する場合

    ```:コマンド
    logger -p syslog.err -t Test "logger test"
    ```

 - ` /var/log/syslog ` での確認

    ```:コマンド
    journalctl /usr/bin/logger -n 1
    ```

    ```:表示例
    Jul 23 22:00:33 srv Test[12136]: logger test
    ```
