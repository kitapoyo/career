# journalctl
1. [journalctl コマンド](#anchor1)
2. [設定ファイル ( journald.conf )](#anchor2)

<a id="anchor1"></a>

## 1. journalctl コマンド
 - systemd が生成するメッセージ ( ジャーナル ) を閲覧するコマンドです。
 - ログの参照に非常に便利です。基本はこのコマンドで十分です。

### 書式
 - オプションの指定がない場合は **less** コマンドを使用して表示します。

    ```:コマンド
    journalctl [ オプション ]
    ```

### オプション

|オプション|説明|
|---|---|
|-f|メッセージの末尾を表示し続けます。 ( tail -f )|
|-o < 書式 >|出力の方式を指定します。 ( short , short-iso , verbose , json )|
|-r|メッセージを新しい順に表示します。デフォルトでは古い順から表示します。|
|-p < プライオリティ >|メッセージのプライオリティが指定した値のログのみ表示します。|
|-u < Unit 名 >|指定した Unit のメッセージを表示します。|
|-b|起動時からのメッセージを表示します。|
|-e|最新のメッセージを表示します。|
|-x|詳細情報も表示します。|
|-n 行数|表示する行数を指定します。|
|-a|エスケープ文字や長い行も含めてプレーンテキストで表示します。|
|--full|エスケープ文字を除いてプレーンテキストで表示します。|
|--no-pager|１ページごとに表示せず、すべてのメッセージを一度に表示します。|
|--since="日時"|指定した日時以降のメッセージを表示します。|
|--until="日時"|指定した日時以前のメッセージを表示します。|

### ２０１８年３月１日１２時以降のメッセージを表示する場合

 ```:コマンド
 journalctl --since="2018-03-01 12:00:00"
 ```

### 直近３０分のメッセージを出力する場合

 ```:コマンド
 journalctl --since="30 min ago"
 ```

### sshd.service 関連のメッセージを表示する場合

 ```:コマンド
 journalctl -u sshd.service
 ```

<a id="anchor2"></a>

## 2. 設定ファイル ( journald.conf )
 - journalctl コマンドで出力されるログは **/var/log/journal** ディレクトリ以下に格納されます。
 - ログファイルはバイナリファイルなので **less** 等で閲覧はできません。

### /etc/systemd/journald.conf ファイル
 - 設定によってはログが永続的に保存されません。以下の項目を確認してください。
1. ` cat /etc/systemd/journald.conf `

    ```:設定例
    [Journal]
    Storage=auto
    以下略
    ```

2. **Storage** の項目が **persistent** であれば、ログは永続的に保存されます。
3. **auto** であれば、再起動により一部のログが消失する可能性があります。<br>**/var/log/journal** に保存できない場合は、メモリ上の **/run/systemd/journal** に保存されるためです。

### 設定変更
 - 設定変更した場合は再起動をします。rsyslog によるログ出力が停止する場合がありますのでこちらも起動します。

    ```:コマンド
    sudo systemctl restart systemd-journald
    sudo systemctl restart rsyslog.service
    ```
