# Docker Install in Ubuntu
1. [Docker インストール](#anchor1)
2. [Rootless Mode](#anchor2)
3. [Proxy 設定](#anchor3)

<a id="anchor1"></a>

## 1. Docker インストール

1. 前提ソフトウェアをインストール

    ```:コマンド
    sudo apt -y update && \
    sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common lsb-release
    ```

2. サーバーの公開鍵を取り込み

   ```:コマンド
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
   sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```

3. リポジトリの登録

   ```:コマンド
   sudo apt -y update && \
   echo \
   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https: download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```
    - **/etc/apt/sources.list** または **/etc/apt/sources.list.d/** 以下に、登録されているリポジトリの URL の一覧が格納されています。
    - docker では **stable** , **edge** , **test** が公開されていますが、今回の例では stable として設定しています。

4. Docker インストール

   ```:コマンド
   sudo apt -y install docker-ce docker-ce-cli containerd.io docker-compose && \
   docker --version && docker-compose --version
   ```
   - **Docker version 20.10.6, build 370c289** バージョン確認ができたら成功です。
   - **docker-compose version 1.25.0, build unknown** バージョンの確認ができたら成功です。

5. 現在ログインしているユーザーに Docker の実行権限を付与

    ```:コマンド
    sudo usermod -aG docker $(whoami)
    ```
    - このコマンドは再ログインすることで反映されます。

6. 再起動

    ```:コマンド
    sudo reboot
    ```

    ```:コマンド
    id -nG
    ```
    - 再ログイン後、docker が表示されていれば成功です。

<a id="anchor2"></a>

## 2. Rootless Mode
 - Ubuntu では ` Rails new ` などで作成されるファイルが **root 権限** になってしまいます。
 - ホームディレクトリに **bin/docker** を作成することで、ユーザー権限で Docker を起動します。
1. パッケージの更新

   ```:
   コマンドsudo apt -y update && sudo apt install -y curl uidmap
   ```

2. Docker 停止

   ```:コマンド
   sudo systemctl disable --now docker.service
   ```

3. 環境変数を用意

   ```:コマンド
   export FORCE_ROOTLESS_INSTALL=1
   ```

4. インストールスクリプトをダウンロード・実行

   ```:コマンド
   curl https://get.docker.com/rootless | sh
   ```

5. パスを設定・適用

   ```:コマンド
   echo "export PATH=${HOME}/bin:\$PATH" >> ~/.bashrc &&
   echo "export DOCKER_HOST=unix:///run/user/${UID}/docker.sock" >> ~/.bashrc &&
   source ~/.bashrc
   ```

6. 起動時に Docker を起動

   ```:コマンド
   systemctl --user enable docker
   ```

7. systemd のインスタンスを自動起動

   ```:コマンド
   sudo loginctl enable-linger ${whoami}
   ```

8. 再起動・確認

   ```:コマンド
   sudo reboot
   ```

   ```:コマンド
   which docker
   ```

   - 自身のホームディレクトリ以下の **/bin/docker** が表示されていれば成功です。

<a id="anchor3"></a>

## 3. Proxy 設定
1. Docker に環境変数を設定

   ```:コマンド
   sudo systemctl edit docker
   ```

2. 内容を入力保存

   ```:設定
   [Service]
   Environment="HTTP_PROXY=http://Address:Port"
   Environment="HTTPS_PROXY=http://Address:Port"
   # Environment="NO_PROXY=localhost,127.0.0.1"
   # プロキシを指定しない宛先も設定できます。
   ```

3. 入力確認

    ```:コマンド
    sudo cat /etc/systemd/system/docker.service.d/override.conf
    ```

4. プロキシ確認<br>**HTTP Proxy と HTTPS Proxy** に反映されていれば成功です。

    ```:コマンド
    sudo systemctl daemon-reload && sudo systemctl restart docker && \
    sudo systemctl show docker --property Environment && \
    docker info
    ```
