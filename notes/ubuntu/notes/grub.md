# GRUB ( GRand Unified Bootloader )
1. ブートローダー とは
2. GRUB の設定ファイル
3. GRUB 設定変更
4. リカバリーモード
5. 管理者パスワードを忘れた場合の復旧

## 1. ブートローダー とは
 - コンピューターを起動した際に、動作するプログラムです。
 - カーネルをストレージから読み込み、システムを起動します。
 - 複数の OS がインストールされている場合はそれらを切り替えたり、複数のカーネルを使い分けたりします。

## 2. GRUB の設定ファイル
 - BIOS が搭載されたコンピューターでは **/boot/grub/grub.cfg** です。
 - UEFI が搭載されたコンピューターでは **/boot/efi/EFI/ubuntu/grub.cfg** です。( 多少異なります )
 - ただし、これらのファイルは直接編集しません。

## 3. GRUB 設定変更
 - **/etc/default/grub** ファイルおよび **/etc/grub.d** ディレリクトリ以下の設定ファイルを編集します。
 - 設定変更後は ` update-grub ` コマンドを実行して **/boot/grub/grub.cfg** ファイルを更新します。

### /etc/default/grub ファイルのパラメータ

 ```:表示例
 # If you change this file, run 'update-grub' afterwards to update
 # /boot/grub/grub.cfg.
 # For full documentation of the options in this file, see:
 #   info -f grub -n 'Simple configuration'

 GRUB_DEFAULT=0
 #GRUB_HIDDEN_TIMEOUT=0
 GRUB_TIMEOUT_STYLE=hidden
 GRUB_TIMEOUT=0
 GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
 GRUB_CMDLINE_LINUX_DEFAULT="maybe-ubiquity"
 GRUB_CMDLINE_LINUX=""
 ( 以下略 )
 ```

|設定パラメータ|説明|
|---|---|
|GRUB_DEFAULT=0|デフォルトで起動する OS の番号またはメニュータイトル|
|#GRUB_HIDDEN_TIMEOUT=0|メニューを表示せず、待機する秒数。コメントされていなければメニューが表示|
|GRUB_HIDDEN_TIMEOUT_QUIET=true|true：カウントダウンを表示しない。false：カウントダウンを表示する|
|GRUB_TIMEOUT=0|デフォルト OS を起動するまでの秒数|
|GRUB_DISTRIBUTOR=|メニューエントリに表示するコマンド|
|GRUB_CMDLINE_LINUX_DEFAULT=|ブートオプション ( 通常起動 )|
|GRUB_CMDLINE_LINUX=|ブートオプション ( 通常起動・リカバリーモード )|

## 4. リカバリーモード
 - デフォルトでネットワークが無効化され、ファイルシステムは読み取り専用になります。

    |メニュー|説明|
    |---|---|
    |resume|リカバリーモードを終了し、システムを通常起動する|
    |clean|不要なファイルを削除し、空き領域を増やす|
    |dpkg|壊れたパッケージを修復する|
    |fsck|ファイルシステムの整合性をチェックする|
    |grub|GRUB を更新する|
    |network|ネットワーク機能を有効化する|
    |root|root ユーザーとしてシェルを起動する|
    |system-summary|システムの情報を表示する|

## 5. 管理者パスワードを忘れた場合の復旧
1. リカバリーモードで **fsck** を実行して、読み書きできる状態にします。
2. **root** を選択し、シェルを起動します。
3. **passwd** コマンドを実行してパスワードを変更します。
4. **Ctrl + D キー** を押して、ログアウトします。
5. リカバリーモードのメニュー画面に戻るので **resume** を選択してシステムを起動します。
