# Ubuntu Commands
1. コマンドサマリー
   - [OS 系](#anchor1a)
   - [USer 系](#anchor1b)
2. コマンド逆引き
   - [ユーザーの作成](#anchor2a)
   - [ユーザーの一覧](#anchor2b)
   - [ログインしているユーザーを表示](#anchor2c)
   - [ユーザー作成時のデフォルト値を設定](#anchor2d)
   - [グループの一覧](#anchor2e)
   - [新たなグループへ一時的にログイン](#anchor2f)
   - [sudo 権限の編集](#anchor2g)
   - [環境変数の表示](#anchor2h)
   - [シェルオプションの設定](#anchor2i)
   - [proc 情報 ( Linux が認識しているデバイス情報 ) 表示](#anchor2j)
   - [実行中のプロセスを表示](#anchor2k)
   - [プロセスを強制終了](#anchor2l)
   - [全てのサービスの状態を表示](#anchor2m)
   - [cron 設定](#anchor2n)
   - [プロセスを間隔で更新表示](#anchor2o)
   - [メモリの利用状況表示](#anchor2p)
   - [空いているポート表示](#anchor2q)
   - [プロセスが使用しているポート表示](#anchor2r)
   - [デバイスファイルの表示](#anchor2s)
   - [bashrc 関連ファイルの表示](#anchor2t)
   - [バックグラウンドでコマンド処理](#anchor2u)
   - [メタデータの取得](#anchor2v)
   - [ネットワーク設定ファイルの表示](#anchor2w)
   - [ネットワーク設定コマンド](#anchor2x)
   - [SSH 設定情報表示](#anchor2y)

## 1. コマンドサマリー

<a id="anchor1a"></a>

### OS 系
|コマンド|説明|備考|
|----|----|----|
|date|日付を表示||
|cal|カレンダー表示||
|pwd|カレントディレクトリ表示||
|cd < Path >|ディレクトリ移動|親ディレクトリは cd ..<br>ホームディレクトリは ~/ |
|ls|カレントディレクトリのファイルを表示|ls -al でよく使用<br>ls -a で隠しファイルも表示|
|cat|ファイルの中身を表示|短いファイルを見るのに使用|
|less|ファイルの中身を表示|長いファイルを見るのに使用<br>b １画面戻る<br>f , space １画面進む<br>q　終了する|
|cp < 何を > < 何処へ > |ファイルやディレクトリをコピー|< 何処へ > のファイル名を変えて、別名でコピー<br>-i を使用して上書き防止<br>-v を使用して結果表示<br>-r で再帰的にコピー|
|mv < 何を > < 何処へ > |ファイルやディレクトリを移動|< 何処へ > のファイル名を変えて、別名で移動<br>-i を使用して上書き防止<br>-v を使用して結果表示<br>-r で再帰的に移動|
|mkdir < ディレクトリ > |ディレクトリの作成||
|rmdir < ディレクトリ > |ディレクトリの削除|ディレクトリが空でないと削除できない|
|rm|ファイルやディレクトリの削除|-r でディレクトリの削除<br>-rf でディレクトリ以下強制的に削除<br>sudo でないと削除できない場合多い|
|help| 組み込みコマンド一覧表示|組み込みコマンド = シェル自体に内臓されてるコマンド|
|type| 外部コマンド実行パス表示|外部コマンド = Linuxのファイルとして存在するコマンド|
|printenv|環境変数の表示||
|echo|引数の値を表示|echo $PATH|
|wc|ファイルの文字数・単語数・バイト数を表示||
|head|ファイルの先頭から表示|デフォルトで10行|
|tail|ファイルの末尾から表示|デフォルトで10行|
|ps|実行中のプロセスを表示|デフォルトで10行|

<a id="anchor1b"></a>

### User 系
|コマンド|説明|備考|
|----|----|----|
|su|管理者ユーザーに切り替える|exit コマンドで一般ユーザーに戻る|
|sudo|管理者権限で実行する|入力するパスワードは、現在ログインしているユーザーのもの|
|chmod < パーミッション > < 変更したいファイル >|ファイルやディレクトリの権限変更||
|useradd < ユーザー名 ><br>useradd < ユーザー名 > -g < グループ名 >|ユーザーの追加|管理者権限のみ実行できる<br>-g でグループも同時に設定するのが主流 |
|passwd|ユーザーのパスワードを設定|/etc/shadow ファイルに保存される<br>cat /etc/passwd でユーザー情報を確認できる|
|userdel < ユーザー名 >|ユーザーの削除|管理者権限のみ実行できる|
|groupadd < グループ名 >|グループの追加|/etc/group にグループの情報がある|
|usermod -G < グループ名 > < ユーザー名 > |ユーザーをグループに追加||
|groupdel < グループ名 >|グループの削除|/etc/プライマリグループは削除できない|
|chown < ユーザー名 > < ファイル名 > |ファイルの所持者変更|-R で再帰的に実施|
|chgrp < ユーザー名 > < ファイル名 > |ファイルの所持グループ変更|-R で再帰的に実施|

## 2. コマンド逆引き

<a id="anchor2a"></a>

### 1. ユーザーの作成
 - ` sudo useradd $USER `
 - ` sudo passwd $USER `

<a id="anchor2b"></a>

### 2. ユーザーの一覧
 - ` sudo cat /etc/passwd `
 - ` sudo cat /etc/shadow `
 - **!!** の意味は、パスワードが設定されていない状態です。

<a id="anchor2c"></a>

### 3. ログインしているユーザーを表示
 - ` who `<br>ログインしているユーザー名が表示されます。
 - ` sudo id `<br>ユーザー ID , グループID が表示されます。

<a id="anchor2d"></a>

### 4. ユーザー作成時のデフォルト値を設定
 - ` sudo useradd -D `
 - ` sudo cat /etc/login.defs `

<a id="anchor2e"></a>

### 5. グループの一覧
 - ` sudo cat /etc/group `
 - ` sudo cat /etc/gshadow `
 - **!!** の意味は、パスワードが設定されていない状態です。

<a id="anchor2f"></a>

### 6. 新たなグループへ一時的にログイン
 - ` sudo newgrp < ログインするグループ名 > `

<a id="anchor2g"></a>

### 7. sudo 権限の編集
 - ` sudo visudo `
 - ` sudo cat /etc/sudoers `

<a id="anchor2h"></a>

### 8. 環境変数の表示
 - ` printenv `

<a id="anchor2i"></a>

### 9. シェルオプションの設定
 - 表示<br>` set -o `
 - 有効<br>` set -o < 有効にしたいシェル名 > `
 - 無効<br>` set +o < 無効にしたいシェル名 > `

<a id="anchor2j"></a>

### 10. proc 情報 ( Linux が認識しているデバイス情報 ) 表示
 - ` sudo cat /proc/version `
 - ` sudo cat /proc/cpuinfo `
 - ` sudo cat /proc/meminfo `
 - ` sudo cat /proc/cmdline `
 - ` sudo cat /proc/devices `
 - ` sudo cat /proc/filesystems `
 - ` sudo cat /proc/mounts `
 - ` sudo cat /proc/modules `
 - ` sudo cat /proc/partitions `
 - ` lsusb `

<a id="anchor2k"></a>

### 11. 実行中のプロセスを表示
 - ` ps -aux `

<a id="anchor2l"></a>

### 12. プロセスを強制終了
 - ` kill < 終了するプロセス ID > `

<a id="anchor2m"></a>

### 13. 全てのサービスの状態を表示
 - ` sudo systemctl list-units --type service --all `<br>全てのサービスの状態を出力します。
 - ` sudo systemctl list-units --type service `<br>サービスの有効無効の一覧を出力します。

<a id="anchor2n"></a>

### 14. cron 設定
 - 編集<br>` crontab -e `
 - 表示<br>` crontab -l `
 - システム crontab の表示<br>` sudo cat /etc/crontab `

<a id="anchor2o"></a>

### 15. プロセスを間隔で更新表示
 - ` top `
 - ` q ` で終了できます。

<a id="anchor2p"></a>

### 16. メモリの利用状況表示
 - ` free -m `

<a id="anchor2q"></a>

### 17. 空いているポート表示
 - ` ss -atu `

<a id="anchor2r"></a>

### 18. プロセスが使用しているポート表示
 - ` lsof -i `<br>実行中のプロセスを表示します。
 - ` kill < 1010 > `<br>プロセスを強制終了します。コマンドの後の数字はプロセス ID です。

<a id="anchor2s"></a>

### 19. デバイスファイルの表示
 - ` sudo ls /dev/ `
 - ` lsblk `

<a id="anchor2t"></a>

### 20. bashrc 関連ファイルの表示
 - ` sudo cat /etc/profile `<br>ログイン時にすべてのユーザーから実行されます。
 - ` sudo cat /etc/bashrc `<br>ユーザーの ` .bashrc ` ( bash 実行 ) から実行されます。
 - ` sudo cat ~/.bash_profile `<br>ログイン時に実行されるユーザー専用の設定です。
 - ` sudo cat ~/.bashrc `<br>bash 起動時に実行されるユーザー専用の設定です。

<a id="anchor2u"></a>

### 21. バックグラウンドでコマンド処理
 - ` sleep 10 & `<br>コマンドの後に、` & ` を追記することで、バックグラウンドで実行できます。

<a id="anchor2v"></a>

### 22. メタデータの取得
 - ` curl http://169.254.169.254/latest/meta-data `<br>表示された内容を追記して情報を取得します。
 - 例として、パブリック IP アドレスを得るコマンドです。<br>` curl http://169.254.169.254/latest/meta-data/public-ipv4 `<br>` sudo cat /var/log/cloud-init-output.log `

<a id="anchor2w"></a>

### 23. ネットワーク設定ファイルの表示
 - ` sudo cat /etc/services `<br>サービスとポート番号が記述されています。
 - ` sudo cat /etc/hostname `<br>プライベートホスト名が記述されています。
 - ` sudo cat /etc/hosts `<br>ホスト名と IP アドレスの対応が記述されています。エントリを追記することで、簡易的に名前解決ができます。
 - ` sudo ls /etc/sysconfig/network-scripts/ `<br>ネットワークインターフェースの設定ファイルが配置されています。
 - ` sudo cat /etc/resolv.conf `<br>DNS サーバーを指定しています。
 - ` sudo cat /etc/nsswitch.conf `<br>名前解決の優先ルールを定義しています。

<a id="anchor2x"></a>

### 24. ネットワーク設定コマンド
 - ` hostnamectl `<br>ホスト名と関連情報を出力します。<br>EC2 の場合 ： ` curl http://169.254.169.254/latest/meta-data/public-hostname `
 - ` dig `<br>DNS サーバーに登録されている設定情報を出力できます。<br>オプション無しの場合は、A レコードの情報を出力します。

<a id="anchor2y"></a>

### 25. SSH 設定情報表示
 - 公開鍵の格納場所<br>` sudo cat /etc/.ssh/authorized_keys `
 - SSH 設定ファイル<br>` sudo cat /etc/ssh/sshd_config`<br>**PasswordAuthentication no** の場合は、パスワード認証が無効化されています。
