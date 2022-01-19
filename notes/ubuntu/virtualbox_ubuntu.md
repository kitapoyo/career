# VirtualBox Install
1. [はじめに](#anchor1)
   - 設定環境
   - 作業の目的
   - 事前準備
2. [VirtualBox 設定](#anchor2)
   - 作成
   - LAN 接続設定
3. [Lubuntu 設定](#anchor3)
   - Lubuntu 起動
   - Lubuntu インストール
   - ログイン確認
4. [Lubuntu セットアップ](#anchor4)
   - [Proxy](#anchor4a)
   - [SSH](#anchor4b)
   - [sudo](#anchor4c)
   - [su](#anchor4d)
5. [VirtualBox の画面拡張](#anchor5)
   - VBoxGuestAdditions.iso マウント
   - 古いファイルの削除
   - カーネル更新
   - VBoxGuestAdditions.iso インストール
   - 再起動
6. [共有フォルダの作成](#anchor6)
   - ホスト OS 側の設定
   - ゲスト OS 側の設定
7. [最後に](#anchor7)

<a id="anchor1"></a>

## 1. はじめに
 - 個人での学習用や検証用を想定しています。本番環境で使用しないでください。
 - Lubuntu の Version を合わせていただければ基本は動作すると思います。
 - 一部手順やコマンドでユーザー名を **hoge** で記述しています。<br>コマンドを実行する際は、自身のユーザー名と置き換えてください。

### 設定環境
 - ホスト OS ： **Windows 10**
 - ゲスト OS ： **Lubuntu 20.04.3 LTS ( Focal Fossa ) 64bit Desktop 版**
 - TeraTerm ： **Version 4.105**
 - VirtualBox ： **Version 6.1.16**

### 作業の目的
 - Virtual Box で Lubuntu を起動
 - Virtual Box での画面拡大
 - ホスト OS と ゲスト OS 間でのファイル共有
 - TeraTerm による ゲスト OS への SSH ログイン

### 事前準備
1. [TeraTerm のインストール](https://ja.osdn.net/projects/ttssh2/releases/)
2. [VirtualBox のインストール](https://www.virtualbox.org/wiki/Downloads)
3. [Lubuntu のダウンロード](https://lubuntu.me/downloads/)

<a id="anchor2"></a>

## 2. VirtualBox 設定

### 1. 作成
1. **新規(N)**> 使用する仮想プロジェクト名前を入力します。
2. **タイプ(T)**> **Linux**を選択します。
3. **バージョン ( V )** > **Ubuntu ( 64 bit )**を選択します。> **次へ ( N )**
4. メモリーサイズ > デフォルトで OK です。> **次へ( N )**
5. ハードディスク > **仮想ハードディスクを作成する ( C )** を選択し、それ以外はデフォルトで OK です。> **作成**<br>Docker 等を使用する場合はハードディスクのサイズを ２０G くらいには増やしましょう。
6. VirtualBox 画面の **ツール**の下に**作成した名前の項目**が存在していれば成功です。

### 2. LAN 接続設定
 - ホストオンリーアダプターを設定することで **ホスト OS** と **ゲスト OS** 間で通信可能にします。( SSH 等で使用 )
 - Cisco Any Connect 等の VPN を使用する際は、LAN 通信を制限され、通信ができない可能性があります。
1. **設定 ( N )** > **ネットワーク** > **アダプター２** > **ネットワークアダプタを有効化 ( E )**にチェックをいれます。
2. **割り当て ( A )** の項目を**ホストオンリーアダプター**で選択して **OK** をクリックします。
3. ネットワークの項目に**アダプター２**が作成されていれば成功です。

#### ※ ポートフォワーディング SSH 接続設定 ( やらなくても問題ありません )
 - ` ssh localhost ` のようにホスト OS のアドレスでゲスト OS にログインできるようになります。
 - ローカルネットワークを制限される VPN 等の環境下でも、ゲスト OS への SSH が可能になります。
 - **宛先や送信元を指定しない場合、ユーザー名とパスワードが一致していれば、他者がログインできます。<br>セキュリティには十分は十分考慮して使用してください。**
1. **設定 ( N )** > **ネットワーク** > **アダプター１** > **高度( D )** > **ポートフォワーディング ( P )**をクリックします。
2. 右上の **+** 項目から **ssh 22** のポートを追加設定します。
3. SSH を ゲスト OS にインストールした後に、` ssh 127.0.0.1 ` 等でログインを確認してください。

#### ※ USB NIC のマウント ( USB NIC を使用する場合です。やらなくても問題ありません。 )
 - USB NIC があると、以下のようなことができるのでおすすめです。<br>ホスト OS で自社内ネットワークに接続<br>ゲスト OS で検証用ネットワークに接続
1. **設定 ( N )** > **USB** > 右上の **+** 項目から使用する機器名を選択して自動マウントに追加します。
2. ゲスト OS を起動後、**ifconfig** 等のコマンドで認識されているか確認してください。

<a id="anchor3"></a>

## 3. Lubuntu 環境設定

### 1. Lubuntu 起動
1. **ストレージ** > **IDE セカンダリマスター [ 光学ドライブ ]** を選択して、ダウンロードした **Lubuntu の iso** をマウントします。
2. **起動 ( T )** をクリックして ゲスト OS を起動させます。
3. 言語を **English ( 日本語でもできます )** > **Start Lubuntu** で Enter を押してください。<br>**言語が日本語の場合、あらゆる箇所で文字化けをする可能性があります。**
4. GUI の デスクトップが表示されたら成功です。

### 2. Lubuntu インストール
1. デスクトップに **Install Lubuntu 20.04 LTS** という名前のディスクアイコンがあると思いますのでクリックします。
2. Welcome > **American English** を選択して次へ進みます。
3. Location > **日本の場所**を選択して次へ進みます。
4. Keyboard > **Japanese** > **Default** を選択して次へ進みます。<br>**普段使用しているキーボード入力を選択してください。**
5. Partitions > **Erase disk** を選択して次へ進みます。
6. Users > ユーザーの設定をして次へ進みます。<br>**What is your name ?** に **ログインユーザー名** を入力します。他の名前は自動で入力されますのでデフォルトで OK です。<br>**Choose a password to keep your account safe.** に **ログインパスワード**を入力します。<br>**SSH する際のユーザー名 パスワード になりますので忘れないでください。**
7. Summary > デフォルトのまま、**Install** を選択します。
8. **Install Now** を選択して、しばらく待ちます。
9. **ALL done.** の表示がされたら **Done** をクリックして再起動します。
10. ログイン画面が表示されたら、ユーザー名を確認してパスワードを入力します。<br>ログインして、デスクトップが表示されたら成功です。

### 3. ログイン確認
1. 左下の鳥のアイコンをクリックします。
2. **System Tools** 項目にある **QTerminal** を選択してください。<br>存在しない場合は、Search で **terminal** と検索すれば出てくると思います。<br>また、デスクトップに QTerminal のショートカットを作成すると便利です。
3. コマンドプロンプトが表示されたら以下のコマンドを実行してください。<br>設定した **ユーザー名** が表示されていれば成功です。<br>ダウンロードした Lubuntu のバージョンが一致していれば成功です。

    ```:コマンド
    whoami
    ```

    ```:表示例
    hoge@hoge-virtualbox:~$ whoami
    hoge
    ```

    ```:コマンド
    lsb_release -a
    ```

    ```:表示例
    hoge@hoge-virtualbox:~$ lsb_release -a
    No LSB modules are available.
    Distributor ID: Ubuntu
    Description:    Ubuntu 20.04.3 LTS
    Release:        20.04
    Codename:       focal
    ```

#### 4. ゲスト OS の終了
 - ゲスト OS を終了する場合は、左上の **閉じる** で終了することができます。
 - またはコマンドプロンプトで ` sudo shutdown -r now ` コマンドを実行してください。

<a id="anchor4"></a>

## 4. Lubuntu セットアップ

<a id="anchor4a"></a>

### ※ Proxy 環境の場合
 - インターネット接続がプロキシを経由している場合は、プロキシの設定が必要です。
 - 本記事では、環境変数に設定ではなく、**apt.conf** を作成する方法を記述します。
1. apt.conf の作成

    ```:コマンド
    sudo vim /etc/apt/apt.conf
    ```

2. Proxy 設定記述
 - エディタが開かれたら、以下の内容を記述して保存します。
    - **username** ：プロキシサーバーのユーザー名
    - **password** ：プロキシサーバーのパスワード
    - **proxy** ：プロキシサーバーの名前
    - **port** ：プロキシサーバーのポート番号

    ```:記述内容
    Acquire::http::Proxy "http://username:password@proxy:port";
    Acquire::https::Proxy "https://username:password@proxy:port";
    ```

3. Proxy 設定確認
 -  ` sudo apt -y update ` が実行できれば成功です。
 -**プロキシを使用しない場合は、apt.conf ファイル名を変更するか、コメントアウトする必要があります。**

<a id="anchor4b"></a>

### SSH
 - sudo コマンドのパスワードは、**ユーザー設定をした際のパスワード** を入力してください。

1. パッケージ インストール

    ```:コマンド
    sudo apt -y update && sudo apt -y upgrade && \
    sudo apt -y install dkms net-tools ssh
    ```

2. ゲスト OS アドレス 確認

    ```:コマンド
    ifconfig
    ```

 - この例では 192.168.56.108 がゲスト OS の IP アドレスです。

    ```:表示例
    hoge@hoge-virtualbox:~$ ifconfig
    enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
           inet 192.168.56.108  netmask 255.255.255.0  broadcast 192.168.56.255
           #以下略
    ```

3. SSH ログイン
 - 上記 ゲスト OS の IP アドレス宛てに TeraTerm で SSH ログインを実行してください。
 - ユーザー名とパスワードは、ユーザー登録をした際の情報を入力してください。
 - ログイン出来たら成功です。TeraTerm を使用してコピペや画面拡大ができます。

<a id="anchor4c"></a>

### sudo
 -**sudoers ファイルを編集することで ` sudo ` の使用時に、パスワードを聞かれなくなります。検証用などに設定しましょう。**
 - nano エディタで開かれます。nano での保存は ` Ctrl＋O ` で、終了は ` Ctrl＋X ` です。
1. sudoers ファイル 編集

    ```:コマンド
    sudo visudo
    ```

2. 設定追記

    ```:コピー
    hoge ALL=(ALL:ALL) NOPASSWD: ALL
    ```
    - ファイルが表示されたら、行末の **#includedir /etc/sudoers.d** の行の下に以下内容を追記して保存します。
    - **hoge** の個所は自身のユーザー名に置き換えて記述してください。

3. 設定確認

    ```：コマンド
    sudo cat /etc/sudoers
    ```

    ```:表示例
    hoge@hoge-virtualbox:~$ sudo cat /etc/sudoers
    #
    # This file MUST be edited with the 'visudo' command as root.
    # 中略
    #includedir /etc/sudoers.d
    hoge ALL=(ALL:ALL) NOPASSWD: ALL
    ```

<a id="anchor4d"></a>

### su ( スーパーユーザー )
 - ゲスト OS 内で絶対的な権限を持ったアカウントを作成します。
1. su 作成

    ```:コマンド
    sudo passwd root
    ```
 - コマンド入力後、パスワードの入力要求画面が表示されます。<br>任意のパスワードを設定してください。
 - **passwd: password updated successfully** とプロンプトに表示されたら成功です。

    ```:表示例
    hoge@hoge-virtualbox:~$ sudo passwd root
    New password:
    Retype new password:
    passwd: password updated successfully
    ```

2. su ログイン

    ```:コマンド
    su -
    ```
 - スーパーユーザーはプロンプト表記が **#** になります。
 - ` exit ` でスーパーユーザーからログアウトできます。

    ```:表示例
    hoge@hoge-virtualbox:~$ su -
    Password:
    root@hoge-virtualbox:~# exit
    logout
    hoge@hoge-virtualbox:~$
    ```

<a id="anchor5"></a>

## 5. VirtualBox の画面拡張
 - デフォルトでは画面拡大ができないため、ブラウザを使用する場合は不便です。
 - 作業する場合は、Virtual Box のゲスト OS を停止してください。

### 1. VBoxGuestAdditions.iso マウント
 - ソフトは Virtual Box のインストール時に保存されていると思います。
    - 例： **C:\Program Files\Oracle\VirtualBox\ VBoxGuestAdditions.iso**
 - VirtualBox の **ストレージ** > **「 光学ドライブ 」** に **VBoxGuestAdditions.iso** をマウントして ゲスト OS を起動します。

### 2. 古いファイルの削除
 - 念のため、古い情報を一度削除します。

    ```:コマンド
    sudo apt purge virtualbox-guest-*
    ```

### 3. カーネル更新
 - 必要な情報をアップデートします。

     ```:コマンド
     sudo apt -y update && sudo apt -y install dkms virtualbox-guest-utils && \
     sudo apt -y upgrade
     ```

### 4. VBoxGuestAdditions.iso インストール
 - **hoge** や **VBox_GAs_6.0.10** の部分は、各ユーザー名や version で変わります。
 - インストールする際に、**yes or no** で選択をされる場合がありますが、**yes** を入力してください。

    ```:コマンド
    sudo /media/hoge/VBox_GAs_6.0.10/VBoxLinuxAdditions.run
    ```

 - 自動でマウントされていない場合は、手動でマウントを実行します。( ホームディレクトリの **read ディレクトリ** にマウントする場合 )

    ```:コマンド
    mkdir ~/read \
    sudo mount /dev/sr0 ~/read/ \
    sudo ~/read/VBoxLinuxAdditions.run
    ```

### 5. 再起動
 - 再起動後、ゲスト OS 画面拡大をクリックして画面が拡大できれば成功です。

    ```:コマンド
    sudo reboot
    ```

<a id="anchor6"></a>

## 6. 共有フォルダの作成
 - ホストOSとゲストOSの間でファイルを共有できるようにします。**samba** でも同様なことができます。
 - ゲスト OS 側に **vmdir** という名前で共有フォルダーをホームディレクトリ配下に作成します。

### 1. ホスト OS 側の設定
 - ホスト OS のデスクトップやホームディレクトリに共有用のフォルダを作成してください。
1. VitualBox の設定画面に移動してください。
2. **設定 ( S )** > **共有フォルダー** > **左上の +** から共有フォルダーの追加まで進んでください。
3. **フォルダーのパス** に ホスト OS 側のディレクトリを指定してください。
4. **マウントポイントのパス** に ゲスト OS 側のディレクトリを指定してください。<br> 例： **/home/hoge/vmdir** ※ **hoge** は設定したユーザー名で置き換えてください。
5. **自動マウント** にチェックを入れてください。
6. **永続化する** にチェックを入れて、OK をクリックしてください。

### 2. ゲスト OS 側の設定
1. 共有フォルダ作成

    ```:コマンド
    sudo mkdir ~/vmdir && sudo chmod 777 ~/vmdir
    ```

2. 権限の付与
 - 共有フォルダの位置によっては、ユーザーの権限追加が必要です。
 - コマンド実行後、ゲスト OS を再起動します。<br>再起動することで権限が追加されます。

    ```:コマンド
    sudo gpasswd -a $USER vboxsf
    ```

3. 権限の確認

    ```:コマンド
    groups
    ```

 - **vboxsf** が追加されていれば成功です。

    ```:表示例
    hoge@hoge-virtualbox:~$ groups
    hoge adm cdrom sudo dip plugdev lpadmin vboxsf sambashare
    ```

4. ファイル共有の確認
 - 設定した共有フォルダ **~/vmdir** にファイルを作成して、ホスト OS と ゲスト OS でお互いに参照ができれば成功です。

<a id="anchor7"></a>

## 7. 最後に
 - ここまで設定できれば、学習用や検証用に Lubuntu を動かせると思います。
 - Telnet , Samba , FTP , TFTP , PPPoE , SNMP , Docker , Ruby 等をインストールして自身の環境にしてみてください。
 - 各コマンドの説明詳細は省いていますので、気になった方は別の記事で調べてみてください。
