# SMART ( Self-Monitoring Analysis and Reporting Technology )
1. SMART とは
2. SMART の利用
   - [インストール](#anchor2a)
   - [smartctl コマンド](#anchor2b)
   - [デバイスの確認](#anchor2c)
   - [デバイスの有効化](#anchor2d)
   - [テストの実施](#anchor2e)
   - [テスト結果の表示](#anchor2f)
   - [メール送信](#anchor2g)

## 1. SMART とは
- ハードディスクや SSD に組み込まれている自己診断機能です。
- 対応したデバイスでは、健康状態をチェックして故障を予知したり、危険を通知したりすることができます。

## 2. SMART の利用
 - UbuntuServer では **smartmontools** を使用します。

<a id="anchor2a"></a>

### インストール

 ```:コマンド
 sudo apt -y install smartmontools
 ```

<a id="anchor2b"></a>

### smartctl コマンド

 ```:コマンド
 smartctl [ オプション ] < デバイスのパス >
 ```

|オプション|説明|
|---|---|
|-a|デバイスの詳細な情報を表示します。|
|-c|デバイスの対応情報を表示します。|
|-i|デバイスの情報を表示します。|
|-t|自己診断テストを実施します。テスト方法は３つあります。<br>**short** ：簡易チェック<br>**long** ：完全チェック<br>**conveyance** ：デバイスの運送中に破損がないかチェック|
|-l|最近のテスト結果を表示します。|
|-H|状態を表示します。|

<a id="anchor2c"></a>

### デバイスの確認
 - **SMART support is: Available** と表示されれば対応しています。
 - **SMART support is: Enabled** と表示されれば SMART は有効になっています。
 - /dev/sda が SMART に対応しているか調べる場合

    ```:コマンド
    sudo smartctl -i /dev/sda
    ```

<a id="anchor2d"></a>

### デバイスの有効化
 - /dev/sda を有効化する場合

    ```:コマンド
    sudo smartctl --smart=on /dev/sda
    ```

<a id="anchor2e"></a>

### テストの実施
 - /dev/sda を詳細にテストする場合

    ```:コマンド
    sudo smartctl -t long /dev/sda
    ```

<a id="anchor2f"></a>

### テスト結果の表示
 - /dev/sda の結果の場合

    ```:コマンド
    sudo smartctl -l selftest /dev/sda
    ```

<a id="anchor2g"></a>

### メール送信
 - デバイスを監視し、何か起こればメールを送信することもできます。
 - **/etc/smartd.conf** ファイルを設定します。
    - **DEVICESCAN** ：すべてのデバイスを監視します。
    - **-a** ：すべての属性を監視します。
    - **-m** ：メールを送信します。
    - **-s** ：テストスケジュールを指定します。
    - **-W** ：温度を監視します。
 - すべてのデバイスを監視する場合<br>` DEVICESCAN -a `
 - /dev/sda を監視する場合<br>` /dev/sda -a `
 - エラー時メールを送信する場合<br>` DEVICESCAN -a -m hoge@example.com `
