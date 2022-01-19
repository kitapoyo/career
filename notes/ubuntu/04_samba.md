# Samba
1. [インストール](#anchor1)
2. [Samba の制御](#anchor2)
3. [Samba の設定](#anchor3)
   - Global Settings
   - Share Definitions
   - samba.conf の構文チェック
4. [Samba ユーザーの作成](#anchor4)
   - pdbedit コマンド
   - smbpasswd コマンド
5. [共有の作成](#anchor5)
   - ログイン後のサブコマンド
   - 自身のホームディレクトリにログインする場合

<a id="anchor1"></a>

## 1. インストール
 - Linux を Microsoft ネットワークに参加できるようにするソフトウェアです。
 - LAN 内で運用されるサーバーです。インターネットでは使用しないようにしてください。

    ```:コマンド
    sudo apt -y install samba
    ```

<a id="anchor2"></a>

## 2. Samba の制御
 - 以下のデーモンで構成されています。
1. **smbd** ：ファイルサーバーやユーザー認証するデーモン
2. **nmbd** ：名前解決を担当するデーモン

    ```:コマンド
    sudo systemctl start smbd nmbd
    ```

<a id="anchor3"></a>

## 3. Samba の設定
 - **/etc/samba/smb.conf** で行います。**;** や **#** で始まる行はコメントです。
 - 大きく分けて、以下の２つの大部分から構成されます。

### Global Settings
 - サーバーの全般的な設定を行う部分で、変更の際は再起動が必要です。

    |項目|説明|
    |---|---|
    |workgroup|所属するワークグループまたはドメイン名を指定します。|
    |server string|Samba サーバーのコメントを記述します。|
    |log file|ログファイルの格納場所で、デフォルトでは接続機器ごとにログファイルが分かれます。<br>**%m** はクライアントの NetBIOS 名を表します。<br>１つのログファイルにまとめたい場合は **/var/log/samba/smbd.log** のように指定します。|
    |max log size|最大ログサイズを K バイト単位で指定します。０の場合、上限なしです。|
    |server role|サーバーの役割を指定します。<br>standalone server ：ファイルサーバーやプリンタサーバーとして単独で使用する場合<br>member server ：Active Directory のメンバーサーバーの場合<br>active directory domain controller ：Active Directory のドメインコントローラの場合|
    |passwd program|Samba ユーザーアカウント情報を保存するデーターベース形式を指定します。|
    |unix password sync|Samba ユーザーアカウントのパスワードを Linux ユーザーアカウントのパスワードに反映させるか指定します。|
    |passwd program , passwd chat|有効にすると、Samba ユーザーのパスワードを変更した際に **passwd program** で指定したコマンドが実行されます。|
    |pam password change|有効にすると、パスワード変更に PAM を使用します。|

    ```:設定例
    #======================= Global Settings =======================

    [global]
       workgroup = WORKGROUP
       server string = %h server (Samba, Ubuntu)

    #### Debugging/Accounting ####
       log file = /var/log/samba/log.%m
       max log size = 1000

    ####### Authentication #######
       server role = standalone server
       passdb backend = tdbsam
       obey pam restrictions = yes
       unix password sync = yes
       passwd program = /usr/bin/passwd %u
       passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n     *password\supdated\ssuccessfully* .
       pam password change = yes
       map to guest = bad user
    ```

### Share Definitions
 - ファイル共有やプリンタ共有を設定する部分です。

    |項目|説明|
    |---|---|
    |browseable|共有が表示されるか指定します。**no** に設定すると共有は表示されません。|
    |read only|読み取り専用か書き込み可能か指定します。同様のパラメータに **writable** があります。|
    |create mask|新規ファイルのアクセス権を指定します。|
    |directory mask|新規ディレクトリのアクセス権を指定します。|
    |vaild users|アクセス可能なユーザーを指定します。**%S** はユーザー名を表します。<br>**valid users = %S** とすることで、ホームディレクトリは自身のみアクセスできます。|

    ```:設定例
    #======================= Share Definitions =======================
    [homes]
       comment = Home Directories
       browseable = no
       read only = yes
       create mask = 0700
       directory mask = 0700

       valid users = %S

    [printers]
       comment = All Printers
       browseable = no
       path = /var/spool/samba
       printable = yes
       guest ok = no
       read only = yes
       create mask = 0700

    [print$]
       comment = Printer Drivers
       path = /var/lib/samba/printers
       browseable = yes
       read only = yes
       guest ok = no
    ```

### samba.conf の構文チェック

 ```:コマンド
 testparm -s
 ```

<a id="anchor4"></a>

## 4. Samba ユーザーの作成
 - Linux のユーザーアカウントとは別に管理されますが、同じ名前のユーザーが Linux に登録されている必要があります。
 - Samba ユーザーの作成には **pdbedit** コマンドを使用します。
 - Samba ユーザーのパスワードを変更するには **smbpasswd** コマンドを使用します。

    ```:コマンド
    pdbedit [ オプション ]
    ```
    - **-L** ：Samba ユーザーの一覧を表示します。
    - **-a ユーザー名** ：Samba ユーザーを追加します。
    - **-x ユーザー名** ：Samba ユーザーを削除します。

 - **unix password sync** が **yes** の場合、Linux ユーザーのパスワードも変更されます。

    ```:コマンド
    smbpassword < ユーザー名 >
    ```

<a id="anchor5"></a>

## 5. 共有の作成
 - ` /etc/samba/smb.conf ` に設定を追記します。

    ```
    [homes]
       comment = Home Directories
       browseable = no
       read only = yes
       create mask = 0700
       directory mask = 0700

       valid users = %S
    ```
    - Windows エクスプローラーのアドレス欄に ` \\ IP アドレス \ ユーザー名 ` でアクセスしてみましょう。

## Samba クライアント
 - Linux ホストから、Windows ファイルサーバーや Samba サーバーを利用できます。
 - **smbclient** パッケージが必要です。

    ```:コマンド
    sudo apt -y install smbclient
    ```

 -  書式

    ```:コマンド
    smbclient [ オプション ] < 接続先 >
    ```
    - **-L** ：リスト表示をリクエストします。
    - **-N** ：認証を行わない。
    - **-U ユーザー名** ：接続ユーザーを指定します。

### ログイン後のサブコマンド

|サブコマンド|説明|
|---|---|
|cd ディレクトリ|指定したディレクトリに移動|
|del ファイル|指定したファイルを削除|
|dir|ファイル一覧表示|
|exit|接続を狩猟する|
|get ファイル|指定したファイルをダウンロードする|
|mget ファイル|指定した複数のファイルをダウンロードする|
|mkdir ディレクトリ|ディレクトリを作成する|
|put ファイル|指定したファイルをアップロードする|
|lcd ディレクトリ|ローカル側のディレクトリを移動する|
|rmdir ディレクトリ|ディレクトリを削除する|

### 自身のホームディレクトリにログインする場合

 ```:コマンド
 smbclient //127.0.0.1/hoge -U hoge
 ```
