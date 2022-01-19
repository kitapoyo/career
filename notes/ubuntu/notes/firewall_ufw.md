# ファイアウォール ( ufw )
1. 概要
2. ufw コマンド
   - [簡単な使い方の表示](#anchor2a)
   - [ファイアウォール有効化](#anchor2b)
   - [ファイアウォール無効化](#anchor2c)
   - [設定と動作状況表示](#anchor2d)
   - [ポリシー設定](#anchor2e)
   - [出力ログレベル設定](#anchor2f)
   - [通信許可設定](#anchor2g)
   - [ルール削除](#anchor2h)
   - [ルール追加](#anchor2i)
   - [試行回数設定](#anchor2j)
   - [ユーザールール](#anchor2k)

## 1. 概要
 - **iptables** コマンドでも設定できますが、使い方が複雑です。
 - UbuntuServer では、より簡単に設定できる **ufw** コマンドが存在します。

## 2. ufw コマンド

 ```:書式
 ufw サブコマンド
 ```

<a id="anchor2a"></a>

### 簡単な使い方の表示

 ```:コマンド
 ufw help
 ```

<a id="anchor2b"></a>

### ファイアウォール有効化

 ```:コマンド
 ufw enable
 ```

<a id="anchor2c"></a>

### ファイアウォール無効化

 ```:コマンド
 ufw disable
 ```

 - ファイアウォールの設定を無効化します。設定内容は消えません。

<a id="anchor2d"></a>

### 設定と動作状況表示

 ```:コマンド
 ufw status
 ```

 - **numbered** ：ルール番号を表示します。ルールを削除・並び替えする際にこの番号を使用します。
 - **verbose** ：ロギングモードやデフォルトのポリシーを表示します。

<a id="anchor2e"></a>

### ポリシー設定
1. **allow** はルールにマッチしなかった通信を許可します。
2. **deny** はルールにマッチしなかった通信を破棄します。
3. **reject** はルールにマッチしなかった通信を拒否してエラーを返します。 ( Connection Refused )

    ```:書式
    ufw default < allow | deny | reject > [ incoming | outgoing | routed ]
    ```
    - デフォルトでは **incoming ( 外部から内部へ )** の通信が設定されます。

<a id="anchor2f"></a>

### 出力ログレベル設定
 - 出力されるログのレベルを設定します。デフォルトは **medium** です。
 - ログは通常 **/var/log/syslog** に出力されます。ログの出力先は変更可能です。<br>ログは **/var/hog/ufw.logh** ファイルに記録されます。

    ```:書式
    ufw logging < off | low | medium | high | full >
    ```
    - **off** ：ログを記録しません。
    - **low** ：default 以外でルールにマッチしてブロックされた通信を記録します。
    - **medium** ：low に加え、マッチせずに許可された通信・不正パケット・新規の接続を記録します。
    - **high** ：medium に加え、limit にマッチした通信を記録します。
    - **full** ：limit を除く、すべての通信を記録します。

<a id="anchor2g"></a>

### 通信許可設定
 - サービス名・ポート番号を指定して、通信を許可します。
 - サービス名とポート番号の対応は **/etc/services** ファイルで確認できます。
 - アプリケーション名で指定することもできます。以下のコマンドでアプリケーション名を表示できます。
 - 設定は **/etc/ufw/application.d/** で確認できます。

    ```:書式
    ufw allow < サービス名 | ポート番号 | from IP アドレス | プロトコル >
    ```

 - Web サーバーの通信を許可する場合

     ```:コマンド
     sudo ufw allow 80
     ```

     ```：コマンド
     sudo ufw allow http
     ```

 - 192.168.1.0/24 からのアクセスを許可する場合

     ```:コマンド
     sudo ufw allow from 192.168.1.0/24
     ```

 - HTTP / HTTPS を許可する場合

     ```:コマンド
     sudo ufw allow "Apache Full"
     ```

<a id="anchor2h"></a>

### ルール削除
 - 指定したルールを削除します。 ` ufw status numbered ` で表示される番号で指定する方法が簡単です。

    ```:書式
    sudo ufw delete < ルール | ルール番号 >
    ```

<a id="anchor2i"></a>

### ルール追加
 - ルール番号を指定してルールを追加します。ルールは若番から評価されます。

    ```:書式
    sudo ufw insert < ルール番号 | ルール >
    ```

<a id="anchor2j"></a>

### 試行回数設定
 - 指定したサービスへの繰り返される試行 ( 同一 IP アドレスから３０秒に６回以上 ) を拒否します。
 - ` ufw status ` で確認すると、Action 欄が **LIMIT** になります。

    ```:書式
    sudo ufw limit < サービス | ポート番号 >
    ```

<a id="anchor2k"></a>

### ユーザールール
 - 設定したルールは以下に保存されます。**iptables / iptables6** の形式で記述されています。<br>より細かな設定をする場合は、こちらを編集しましょう。
1. **/etc/ufw/user.rules**
2. **/etc/ufw/user6.rules**
