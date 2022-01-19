# ログファイル
1. ログファイル ( /var/log ) とは
2. 継続的な監視
   - /var/log/auth.log を継続監視する場合
3. ログファイルのローテーション ( logrotate )
   - 設定項目
   - 設定ファイル

## 1. ログファイル ( /var/log ) とは
 - ログは通常 **/var/log** ディレクトリ以下に保存されます。
 - 基本は **less** コマンドなどで見ることができます。閲覧に管理者権限が必要な場合があります。

    ```:コマンド
    ls /var/log
    ```

### 主なログファイル

|ファイル名|説明|
|----|----|
|alternatives.log|alternatives システムのログ|
|auth.log|認証関連のログ|
|dmesg|システム起動時等のカーネルログ|
|dpkg.log|パッケージ関連のログ|
|kern.log|カーネルのログ|
|lastlog|ユーザーのログイン記録|
|mail.log|メール関連のログ|
|syslog|システムの汎用ログファイル|
|ufw.log|ファイヤーウォールのログ|
|wtmp|ログイン記録|
|apt/|APT 関連ログを格納するディレクトリ|
|journal/|systemd-journal サービスの永続的なログを格納するディレクトリ|
|mysql/|MySQL 関連のログを格納するディレクトリ|
|nginx/|nginx 関連のログを格納するディレクトリ|
|sysstat/|sysstat パッケージのログを格納するディレクトリ|

## 2. 継続的な監視
 - ` tail -f ` または ` tailf ` コマンドを使用します。

### /var/log/auth.log を継続監視する場合

 ```:コマンド
 tailf /var/log/auth.log
 ```

## 3. ログファイルのローテーション ( logrotate )
 - 定期的にログファイルを切り分け、バックアップをとっていく仕組みです。
 - UbuntuServer では **logrotate** コマンドを使用します。

### 設定項目

|設定|説明|
|----|----|
|daily|毎日ローテーションを行う|
|weekly|毎週ローテーションを行う|
|monthly|毎月ローテーションを行う|
|rotate 数|バックアップログの保存数|
|create アクセス権 ユーザー グループ|パーミッション・所有者・グループを指定して新しいログファイルを作成|
|compress|バックアップログを gzip で圧縮|
|mail メールアドレス|ローテーション完了時にメールで通知|
|include ディレクトリ|指定したディレクトリのファイルを読み込む|

### 設定ファイル
 - **/etc/logrotate.conf** ファイルで設定します。
 - **/etc/logrotate.d** ディレクトリ以下にもソフトウェアごとの設定ファイルが格納されています。
 - デフォルトでは、バックアップファイルは４つまで作成されます。

    ```:設定例
    hoge @ -bash 4.4.20 ~ $ cat /etc/logrotate.conf
    # see "man logrotate" for details
    # rotate log files weekly
    weekly # デフォルトでは、毎週ローテーションを実施

    # use the syslog group by default, since this is the owning group
    # of /var/log/syslog.
    su root syslog

    # keep 4 weeks worth of backlogs
    rotate 4 # バックアップする数

    # create new (empty) log files after rotating old ones
    create # ローテーション後にログファイルを新規作成

    # uncomment this if you want your log files compressed
    #compress

    # packages drop log rotation information into this directory
    include /etc/logrotate.d # このディレクトリからも設定ファイルを読み込む

    # no packages own wtmp, or btmp -- we'll rotate them here
    /var/log/wtmp {
        missingok
        monthly
        create 0664 root utmp
        rotate 1
    }

    /var/log/btmp {
        missingok
        monthly
        create 0660 root utmp
        rotate 1
    }

    # system-specific logs may be configured here
    ```

    ```
    hoge @ -bash 4.4.20 ~ $ cat /etc/logrotate.d/rsyslog
    /var/log/syslog #  /var/log/syslog ファイルに関しては、 { } 内を適用
    {
            rotate 7 # バックアップする数
            daily      # 毎日実施
            missingok
            notifempty
            delaycompress
            compress
            postrotate
                    /usr/lib/rsyslog/rsyslog-rotate
            endscript
    }
    # 以下のファイルに関しては、 { } 内を適用
    /var/log/mail.info
    /var/log/mail.warn
    /var/log/mail.err
    /var/log/mail.log
    /var/log/daemon.log
    /var/log/kern.log
    /var/log/auth.log
    /var/log/user.log
    /var/log/lpr.log
    /var/log/cron.log
    /var/log/debug
    /var/log/messages
    {
            rotate 4
            weekly
            missingok
            notifempty
            compress
            delaycompress
            sharedscripts
            postrotate
                    /usr/lib/rsyslog/rsyslog-rotate
            endscript
    }
    ```
