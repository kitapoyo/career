# ログイン
1. [概要](#anchor1)
2. [ログアウト](#anchor2)
3. [ログインメッセージの変更 ( /etc/update-motd.d/ )](#anchor3)
4. ログイン状況確認コマンド
   - [who](#anchor4a)
   - [w](#anchor4b)
   - [last](#anchor4c)
   - [lastb](#anchor4d)
   - [lastlog](#anchor4e)

<a id="anchor1"></a>

## 1. 概要
 - ユーザー名とパスワードともに大文字と小文字を区別します。
 - 入力ミスした場合は ` BackSpace キー ` で消去できますが、画面上には表示されません。

<a id="anchor2"></a>

## 2. ログアウト
 - ` exit ` コマンドを実行するか、` Ctrl + D キー ` を押します。
 - 環境変数 **IGNOREEOF** に設定した数値の数だけ、` Ctrl + D キー ` が無視されます。

<a id="anchor3"></a>

## 3. ログインメッセージの変更 ( /etc/update-motd.d/ )
 - **/etc/update-motd.d/** 以下のスクリプトで変更できます。

## 4. ログイン状況確認コマンド

<a id="anchor4a"></a>

### who コマンド
 - ログイン中のユーザーとログイン日時、接続元IP アドレスが表示できます。

    ```:例
    hoge @ -bash 4.4.20 ~ $ who
    hoge     tty1         2021-07-23 04:09
    hoge     pts/0        2021-07-23 20:09 (_gateway)
    ```
    - **pts/0** はログイン端末名です。

<a id="anchor4b"></a>

### w コマンド
 - ログイン中のユーザーに加え、ロードアベレージなどのシステム情報も表示できます。

    ```:例
    hoge @ -bash 4.4.20 ~ $ w
     21:49:42 up 1 day,  3:23,  2 users,  load average: 0.00, 0.00, 0.00
    USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
    hoge     tty1     -                       04:09   17:28m  0.20s  0.18s -bash
    hoge     pts/0    _gateway         20:09    1.00s  0.52s  0.00s w
    ```

<a id="anchor4c"></a>

### last コマンド
 - 最近ログインしたユーザーの一覧を表示できます。また、リブートの記録も表示できます。

    ```:例
    hoge @ -bash 4.4.20 ~ $ last
    hoge     pts/0        _gateway         Fri Jul 23 20:09   still logged in
    hoge     pts/0        _gateway         Fri Jul 23 04:14 - 04:44  (00:30)
    hoge     tty1                          Fri Jul 23 04:08   still logged in
    hoge     pts/0        _gateway         Thu Jul 22 18:26 - 04:08  (09:41)
    reboot   system boot  4.15.0-147-gener Thu Jul 22 18:25   still running
    ```

<a id="anchor4d"></a>

### lastb コマンド
 - 失敗したログインの記録が表示されます。

    ```:例
    hoge @ -bash 4.4.20 ~ $ sudo lastb
    hoge     tty1                          Fri Jul 23 04:08 - 04:08  (00:00)
    UNKNOWN  pts/0        _gateway         Thu Jul 22 18:26 - 18:26  (00:00)
    UNKNOWN  pts/0        _gateway         Thu Jul 22 18:26 - 18:26  (00:00)
    hoge     tty1                          Fri Jul 16 00:42 - 00:42  (00:00)
    hoge     tty1                          Thu Jul 15 20:29 - 20:29  (00:00)
    ```

<a id="anchor4e"></a>

### lastlog コマンド
 - 最近のログインをユーザーごとに表示します。<br>１度もログインしていないユーザーは **Never logged in** と表示されます。

    ```:例
    sshd                                          **Never logged in**
    hoge             pts/0    _gateway         Fri Jul 23 20:09:42 +0900 2021
    telnetd                                      **Never logged in**
    vboxadd                                    **Never logged in**
    postfix                                      **Never logged in**
    ```
