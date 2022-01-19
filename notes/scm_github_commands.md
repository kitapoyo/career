# Git Hub Commands
1. [リモートリポジトリのコピー](#anchor1)
2. [状態確認](#anchor2)
   - -s オプション
3. ブランチ関連
   - [ブランチの一覧表示](#anchor3a)
   - [リモートブランチの一覧表示](#anchor3b)
   - [ブランチ作成](#anchor3c)
   - [ブランチ変更](#anchor3d)
   - [ブランチ削除](#anchor3e)
   - [ブランチ移動](#anchor3f)
   - [ブランチを作成しながらカレントブランチを移動](#anchor3g)
4. [ステージングエリアに登録](#anchor4)
5. 差分
   - [ワークツリーとステージングエリアの差分チェック](#anchor5a)
   - [ステージングエリアと前回コミット ( カレントブランチ ) との差分チェック](#anchor5b)
6. [コミット](#anchor6)
   - 要約したコミットの場合 ( 高頻度で使用します )
7. [ログの表示](#anchor7)
8. 切り戻し
   - [ワークツリーの状態を直前コミットに戻す](#anchor8a)
   - [ステージングエリアの切り戻し ( git add の戻し )](#anchor8b)
   - [直前のコミットの取り消し ( git commit の戻し )](#anchor8c)
   - [マージの取り消し](#anchor8d)
   - [ファイルやフォルダの削除](#anchor8e)
   - [リモートリポジトリとローカルリポジトリの同期](#anchor8f)
   - [fetch と merge を同時に行う](#anchor8g)
   - [GitHub でコミット履歴の削除](#anchor8h)

<a id="anchor1"></a>

## 1. リモートリポジトリのコピー

 ```:コマンド
 git clone < リモートリポジトリのURL >
 ```

<a id="anchor2"></a>

## 2. 状態確認

 ```:コマンド
 git status ( -s )
 ```

### -s オプション
 - 作業ツリーの状況をファイル前の記号で確認できます。

    |記号|意味|
    |----|----|
    |M|変更された|
    |A|ステージングエリアに追加された|
    |D|削除された|
    |R|名前が変更された|
    |C|コピーされた|
    |U|更新されたが、マージされていない|
    |?|ステージングエリアに追加された新規ファイル|

## 3. ブランチ関連

<a id="anchor3a"></a>

### ブランチの一覧表示

 ```:コマンド
 git branch
 ```

<a id="anchor3b"></a>

### リモートブランチの一覧表示

 ```:コマンド
 git branch -r
 ```

<a id="anchor3c"></a>

### ブランチ作成
 ```:コマンド
 git branch < ブランチ名 >
 ```

<a id="anchor3d"></a>

### ブランチ変更

 ```
 git branch -m < 古い名前 > < 新しい名前 >
 ```

<a id="anchor3e"></a>

### ブランチ削除

 ```
 git branch -d < ブランチ名 >
 ```

<a id="anchor3f"></a>

### ブランチの移動

 ```
 git checkout < ブランチ名 >
 ```

<a id="anchor3g"></a>

### ブランチを作成しながらカレントブランチを移動

 ```
 git checkout -b < ブランチ名 >
 ```

<a id="anchor4"></a>

## 4. ステージングエリアに登録
 - **ディレクトリパスを指定した場合、ディレクトリ内のすべてが登録されます。**
 - ちなみにカレント配下すべての登録は ` git add . ` です。

    ```:コマンド
    git add < 対象ファイルやフォルダ >
    ```

## 5. 差分

<a id="anchor5a"></a>

### ワークツリーとステージングエリアの差分チェック

 ```:コマンド
 git diff < 対象ファイルやフォルダ >
 ```

<a id="anchor5b"></a>

### ステージングエリアと前回コミット（ カレントブランチ ）との差分チェック
 - **バイナリファイル（ エクセルなど ）は中身までは確認できないため、注意してください。**

    ```:コマンド
    git diff --cached < 対象ファイルやフォルダ >
    ```

<a id="anchor6"></a>

## 6. コミット
 - **コミットされるのはステージングエリアのみです。**
 - エディタが開くので、説明文追記します。以下内容は、公式のおすすめです。
1. １行目にタイトル
2. ２行目空白
3. ３行目に詳細

    ```:コマンド
    git commit
    ```

### 要約したコミットの場合 ( 高頻度で使用します )

 ```:コマンド
 git commit -m < "コメントの内容" >
 ```

<a id="anchor7"></a>

## 7. ログの表示
 - **オブジェクト ID** が表示されるため、該当のコミット状況に戻す場合に確認します。
 - ` --oneline ` オプションを使用することで、コミット履歴を簡単に表示します。

    ```:コマンド
    git log
    ```

## 8. 切り戻し

<a id="anchor8a"></a>

### ワークツリーの状態を直前コミットに戻す
 - 厳密には、ステージングエリアの状態に戻します。
 - **ファイルを新規作成やファイルの名前変更は戻せません。**

    ```:コマンド
    git checkout -- < ファイル名またはパス >
    ```

<a id="anchor8b"></a>

### ステージングエリアの切り戻し ( git add の戻し )

 ```:コマンド
 git reset HEAD < ファイル名またはパス >
 ```

<a id="anchor8c"></a>

### 直前のコミットの取り消し ( git commit の戻し )

 ```:コマンド
 git reset --soft HEAD^
 ```

<a id="anchor8d"></a>

### マージの取り消し
 - **ORIG_HEAD** は、マージをする直前の **HEAD** のことです。

    ```:コマンド
    git reset --hard ORIG_HEAD
    ```

<a id="anchor8e"></a>

### ファイルやフォルダの削除
 - **ステージングエリアに加えて、コミットしないと削除はされないので注意しましょう。**

    ```:コマンド
    git rm < r > < ファイル名またはパス >
    ```

<a id="anchor8f"></a>

### リモートリポジトリとローカルリポジトリの同期
1. 初めに、リモート **origin** すべてのリモート追跡ブランチを最新の状態にアップデートします。

    ```:コマンド
    git fetch origin
    ```

2. その後、リモート追跡ブランチの内容をローカルブランチに適用します。

    ```:コマンド
    git merge origin/ < ブランチ名 >
    ```

<a id="anchor8g"></a>

### fetch と merge を同時に行う

 ```:コマンド
 git pull origin < ブランチ名 >
 ```

<a id="anchor8h"></a>

### **GitHub でコミット履歴の削除**
 - ある時点まで戻り、それまでのコミットを消します。<br>必ずバックアップを取得して実施してください。
1. 現在から、履歴を消すまでのコミットを確認します。

    ```:コマンド
    git log --name-status
    ```

2. 遡るコミット履歴を指定してリベースを実施します。( 以下の例では、最新から５コミットまでを遡ります )

    ```:コマンド
    git rebase -i HEAD~5
    ```

3. 以下のようにコミット単位に pick 行が表示されるので、一番下以外を削除します。

    ```:表示例
    pick 1111111 コミットメッセージ１
    pick 2222222 コミットメッセージ２
    pick 3333333 コミットメッセージ３
    pick 4444444 コミットメッセージ４
    pick 5555555 コミットメッセージ５
    ```

 - 以下のようなメッセージが表示されます。

    ```:表示例
    error: could not apply 111111... rebuild commit log

    When you have resolved this problem run "git rebase --continue".
    If you would prefer to skip this patch, instead run "git rebase --skip".
    To check out the original branch and stop rebasing run "git rebase --abort".
    Could not apply 7537b39... rebuild commit log
    ```

4. 現在の状態と整合性を保ちます。

    ```:コマンド
    git rebase --continue
    ```

 - 以下のような表示が出た際は、ステージングエリアに登録します。

    ```:表示例
    $ git rebase --continue
    README.md: needs merge
    You must edit all merge conflicts and then
    mark them as resolved using git add
    ```

    ```:コマンド
    git add -A
    git rebase --continue
    ```

    - **Successfully rebased and updated refs/heads/master.** と表示されれば成功です。

5. コミット履歴が消えているか確認します。

    ```:コマンド
    git log --name-status
    ```

6. リモートリポジトリに反映させます。

   ```:コマンド
   git push -f
   ```
