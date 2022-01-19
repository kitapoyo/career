# systemd
1. [systemd とは](#anchor1)
2. [systemctl コマンド](#anchor2)
3. [Unit 構成ファイル](#anchor3)

<a id="anchor1"></a>

## 1. systemd とは
 - システム管理とサービス管理を行います。
 - システムやサービスの起動を **Unit** という処理単位で分割しています。
 - 従来のランレベルに対応するのが、複数の Unit をグループ化したターゲットです。<br>ランレベル：システムの動作状態を示すモードです。

### Unit の種類

|種類|説明|
|---|---|
|service|各種サービスを起動します。|
|device|各種デバイスを表示します。 ( udev のデバイス認識により自動作成 )|
|mount|ファイルシステムをマウントします。 ( /etc/fstab により自動作成 )|
|swap|スワップ領域を有効にします。 ( /etc/fstab により自動作成 )|
|target|複数の Unit をグループ化します。|
|socket|特定のソケットを監視し接続時にサービスを起動します。|

### ランレベルとターゲット

|ランレベル|ターゲット|説明|
|---|---|---|
|0|poweroff.target|システム終了|
|1|rescue.target|レスキューモード|
|2,3,4,5|multi-user.target|マルチユーザーモード|
|2,3,4,5|graphical.targer|グラフィカルログインモード|
|6|reboot.target|システム再起動|

<a id="anchor2"></a>

## 2. systemctl コマンド
 - サービスを管理する際に使用します。

    ```:コマンド
    systemctl < サブコマンド > [ Unit名 ] [ オプション ]
    ```
 - インストールされているすべての service を表示する場合

    ```:コマンド
    sudo systemctl list-unit-files --type service
    ```

### サブコマンド

|サブコマンド|説明|
|---|---|
|start|指定した Unit を起動します。|
|stop|指定した Unit を停止します。|
|restart|指定した Unit を再起動します。|
|try-restart|指定した起動中の Unit を停止後、起動します。|
|reload|指定した Unit の設定を再読み込みします。|
|status|指定した Unit の状態を表示します。|
|is-active|指定した Unit が起動しているか確認します。|
|is-enable|指定した Unit がシステム起動時に自動起動するか確認します。|
|enable|指定した Unit がシステム起動時に自動起動します。|
|disable|指定した Unit がシステム起動時に自動起動しません。|
|mask|指定した Unit をマスクし手動で起動しないようにします。|
|unmask|指定した Unit のマスクを解除します。|
|kill|指定した Unit にシグナルを送ります。|
|list-dependencies|指定した Unit の依存関係を表示します。|
|list-units|起動しているすべての Unit と状態をを表示します。|
|list-unit-files|インストールされているすべての Unit を表示します。|
|reboot|システムを再起動します。|
|poweroff|システムをシャットダウンします。|

### オプション

|オプション|説明|
|---|---|
|-t , --type < 種類 >|Unit の種類を指定します。 ( service , target など )|
|-state < 状態 >|Unit の状態 ( STATE ) を指定します。 ( enabled , disabled loaded など )|
|-l|Unit 名やプロセス名を省略せずに表示します。|
|-s < シグナル >|指定したプロセスにシグナルを送ります。|

<a id="anchor3"></a>

## 3. Unit 構成ファイル
 - Unit 構成ファイルは3つのセクションに分れて設定されています。
1. **[ Unit ]**
2. **[ Service ]**
3. **[ Install ]**
 - Unit を定義したファイルは 以下に配置されています。
1. **/usr/lib/systemd/**<br>システムのデフォルト設定が記録されています。
2. **/etc/systemd/system**<br>管理者が変更可能なファイルです。
 - SSH cat /etc/systemd/system/sshd.service の場合

     ```:表示例
     [Unit]
     Description=OpenBSD Secure Shell server
     After=network.target auditd.service
     ConditionPathExists=!/etc/ssh/sshd_not_to_be_run

     [Service]
     EnvironmentFile=-/etc/default/ssh
     ExecStartPre=/usr/sbin/sshd -t
     ExecStart=/usr/sbin/sshd -D $SSHD_OPTS
     ExecReload=/usr/sbin/sshd -t
     ExecReload=/bin/kill -HUP $MAINPID
     KillMode=process
     Restart=on-failure
     RestartPreventExitStatus=255
     Type=notify
     RuntimeDirectory=sshd
     RuntimeDirectoryMode=0755

     [Install]
     WantedBy=multi-user.target
     Alias=sshd.service
     ```

### 主なパラメータ

|種類|説明|
|----|----|
|Description|Unit の説明|
|Documentation|ドキュメントの場所|
|After|記載された Unit 以降に自身を起動|
|Before|記載された Unit 以前に自信を起動|
|Wants|記載された Unit が必要|
|Type|サービスのタイプ ( simple , forking , oneshot , notify , dbus )|
|ExecStartPre|start での実行前に必要なコマンド|
|ExecStart|start で実行されるコマンド|
|ExecReload|reload で実行されるコマンド|
|ExecStop|stop で実行されるコマンド|
|WantedBy|systenctl enable 実行時に ~.wants ディレクトリ内にシンボリックリンクを作成|
|RequiredBy|systenctl enable 実行時に ~.required ディレクトリ内にシンボリックリンクを作成|
