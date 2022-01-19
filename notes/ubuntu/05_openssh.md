# Open SSH
1. [SSH 基礎知識](#anchor1)
   - 認証の順序
   - ポート転送
2. [ssh](#anchor2)
3. [Open SSH サーバーの設定](#anchor3)
4. [Open SSH クライアントの設定](#anchor4)
   - サーバーへの登録
5. [SSH Agent](#anchor5)
   - SSH クライアント設定

<a id="anchor1"></a>

## 1. SSH 基礎知識

### 認証の順序
1. ホスト認証<br>接続先ホスト ( 相手側 ) の正当性を確かめます。<br>ホスト認証は、SSH サーバーのホスト認証鍵を使用します。<br>初回接続の場合は、サーバーのホスト鍵が **~/.ssh/known_hosts** に登録されます。
2. ユーザー認証<br>デフォルトでは、公開鍵認証、パスワード認証の順に実施されます。
 - 公開鍵認証<br>一対の公開鍵と秘密鍵の鍵ペアで暗号化と復号をおこなうことで認証します。
1. あらかじめサーバー ( 相手側 ) に自身の公開鍵を登録する。
2. 接続時にユーザーの鍵が利用できるか確認する。
3. ユーザー側で電子著名が行われる。
4. データと電子著名がサーバーに送られる。
5. サーバー側でデータと著名を検証し、成功すればログインを許可する。
 - パスワード認証

### ポート転送
 - あるポートに送られた TCP 通信を SSH を使用した通信路を経由して、任意のポートへ転送することです。

<a id="anchor2"></a>

## 2. ssh
 - OpenSSH サーバーに接続してログインや任意のコマンドを実行できます。

    ```:コマンド
    ssh [ オプション ] < ユーザー名 @ 接続先 >
    ```

    |オプション|説明|
    |---|---|
    |-p < ポート番号 >|ポート番号を指定します。デフォルトは２２です。|
    |-l < ユーザー名 >|接続するユーザー名を指定します。省略時はコマンドを実行したユーザーです。|
    |-i < ファイル名 >|秘密鍵ファイルを指定します。|
    |-t|仮想端末を割り当てます。|
    |-f|バックグラウンドで実行します。|
    |-N|ポート転送のみ行います。|
    |-L < ローカルポート : リモートホスト : リモートポート >|ローカルポートへのアクセスをリモートホストのポートへ転送します。|
    |-R < ローカルポート : リモートホスト : リモートポート >|リモートホストへのアクセスをローカルホストのローカルポートへ転送します。|

<a id="anchor3"></a>

## 3. Open SSH サーバーの設定
 - インストールすると、ホストの公開鍵と秘密鍵が **/etc/ssh** ディレクトリに作成されます。
 - **/etc/ssh/sshd_config** ファイルに設定を記述していきます。

    ```:設定例
    Port 22
    Protocol 2
    SyslogFacility AUTH
    LogLevel INFO
    LoginGraceTime 2m
    PermitRootLogin prohibit-password
    StrictModes yes
    RSAAuthentication yes
    PubkeyAuthentication no
    PasswordAuthentication yes
    ChallengeResponseAuthentication no
    UsePAM yes
    X11Forwarding yes
    PrintMotd no
    AcceptEnv LANG LC_*
    Subsystem sftp  /usr/lib/openssh/sftp-server
    AllowUsers hoge
    ```

    |項目|説明|
    |---|---|
    |Port|ポート番号を変更できます。デフォルト２２です。|
    |Protocol|SSH バージョンを指定します。|
    |LoginGraceTime|認証の時間を指定します。|
    |PermitRootLogin|ルートユーザーのログイン設定をします。<br>**prohibit-password** では、パスワードでの認証が無効となります。|
    |PubkeyAuthentication|公開鍵認証を有効化するか指定します。|
    |PasswordAuthentication|パスワード認証を有効化するか指定します。|
    |AllowUsers|接続を許可するユーザーを指定します。|

<a id="anchor4"></a>

## 4. Open SSH クライアントの設定
 - 公開鍵認証の鍵生成は **ssh-keygen** コマンドで行います。
 - 鍵ペアは **~/.ssh** ディレクトリ以下に作成されます。
 - 秘密鍵ファイルはパーミッションを **400** に設定します。

    ```:コマンド
    ssh-keygen [ オプション ]
    ```

    |オプション|説明|
    |---|---|
    |-t < タイプ >|暗号化タイプを指定します。 ( rsa1 , rsa , dsa , ecdsa , ed25519 )|
    |-p|既存の鍵のパスフレーズを変更します。|
    |-l|鍵のフィンガープリントを表示します。|
    |-b|ビット暗号強度を指定します。|
    |-f < ファイル名 >|鍵ファイルを指定します。|
    |-R < ホスト名 >|指定したホスト情報を known_hosts ファイルから削除します。|

### サーバーへの登録
 - 鍵ペア作成後 **ssh-copy-id** コマンドを使用して、接続先ホストに公開鍵を登録します。

    ```:コマンド
    ssh-copy-id [ -p ポート番号 ] -i < 公開鍵ファイル名 > < ユーザー名 @ 接続先 >
    ```

<a id="anchor5"></a>

## 5. SSH Agent
 - クライアント側で稼働するデーモンであり、秘密鍵をメモリ上に保持し、必要な時にそれを利用します。
 - その都度、パスフレーズを入力する必要がなくなります。
 - **ssh-agent** コマンドを使用します。
1. ssh-agent の子プロセスとして bash を起動します。

    ```:コマンド
    ssh-agent bash
    ```

2. **ssh-add** コマンドを使用して、秘密鍵を登録します。パスフレーズも入力します。

    ```:コマンド
    ssh-add
    ```

3. 登録の確認をします。

    ```:コマンド
    ssh-add -l
    ```

4. SSH 接続を試して、パスフレーズの入力が不要であることを確認しましょう。

### SSH クライアント設定
 - **ssh** , **scp** などのクライアント設定は **~/.ssh/config** で行います。
 - 頻繁に接続する際など、こちらに登録すると便利です。

   |設定項目|説明|
   |----|----|
   |Host < 接続名 >|任意の接続名|
   |HostName < ホスト >|接続先ホスト名または IP アドレス|
   |User < ユーザー名 >|接続するユーザー名|
   |Port < ポート番号 >|接続先ポート番号|
   |identityFile < パス >|秘密鍵のファイルパス|
   |ConnectTimeout < 秒 >|接続タイムアウト時間|

 - ssh -p 2222 hoge@example.com の場合
    - ` ssh srv ` でログインできるようになります。

    ```:設定例
    Host srv
      HostName example.com
      User hoge
      Port 2222
    ```
