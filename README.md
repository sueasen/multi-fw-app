# multi-fw-app
## 共通実行
### docker-compose
1.  Codespaces のターミナル開く
2.  プロジェクト直下(multi-fw-app) に移動
    ```bash
    cd /workspaces/multi-fw-app
    ```
3.  docker compose を実行
    ```bash
    # ビルド＆起動 (引数にサービス名追加でサービス指定して実行)
    docker compose up --build -d
    # 起動 (引数にサービス名追加でサービス指定して実行)
    docker compose up -d
    # ログ確認 (引数にサービス名追加でサービス指定して実行)
    docker compose logs -f サービス名
    # 停止/削除 ※ --remove-orphans で孤立したコンテナも対象
    docker compose down
    docker compose down --remove-orphans
    # 指定コンテナ削除 (引数にサービス名追加でサービス指定して実行)
    docker compose rm サービス名
    ```

## spring-boot-app
### 通常実行
1.  Codespaces のターミナル開く
2.  spring-boot-app ディレクトリに移動
    ```bash
    cd spring-boot-app
    ```
3.  spring-boot-app 実行
    ```bash
    ./mvnw spring-boot:run
    ```
4.  ビルドと起動が完了すると、コンソールに以下が表示
    ```bash
    Tomcat started on port(s): 8080
    ```
5.  Codespacesが自動的にポート8080を転送し、右下にポップアップが表示されるので「**ブラウザで開く**」をクリック
6.  ブラウザで `https://xxxyyyzzz-8080.app.github.dev`（ポートで確認）にアクセス、ログイン画面が表示

### run-spring-boot.sh
1.  Codespaces のターミナル開く
2.  プロジェクト直下のディレクトリに移動
3.  run-spring-boot.sh に実行権限を付与（1回やればOK）
    ```bash
    chmod +x run-spring-boot.sh
    ```
4.  run-spring-boot.sh を実行
    ```bash
    # イメージビルド
    ./run-spring-boot.sh build
    # コンテナ起動(バックグランド実行)
    ./run-spring-boot.sh start
    # ログ確認
    ./run-spring-boot.sh logs
    # コンテナ停止
    ./run-spring-boot.sh stop
    ```
### docker-compose
1.  Codespaces のターミナル開く
2.  spring-boot-app ディレクトリに移動
    ```bash
    cd spring-boot-app
    ```
3.  docker compose を実行
    ```bash
    # ビルド＆起動
    docker compose up --build -d
    # 起動
    docker compose up -d
    # ログ確認
    docker compose logs -f spring-boot-app
    # 停止/削除
    docker compose down
    ```

## flask-app
### 通常実行
1.  Codespaces のターミナル開く
2.  flask-app ディレクトリに移動
    ```bash
    cd flask-app
    ```
3.  flask-app 実行
    ```bash
    python ./src/app.py
    ```
4.  起動が完了すると、コンソールに以下が表示
    ```bash
    Running on http://127.0.0.1:5000
    ```
5.  Codespacesが自動的にポート5000を転送し、右下にポップアップが表示されるので「**ブラウザで開く**」をクリック
6.  ブラウザで `https://xxxyyyzzz-5000.app.github.dev`（ポートで確認）にアクセス、ログイン画面が表示
### venv実行
1.  Codespaces のターミナル開く
2.  flask-app ディレクトリに移動
    ```bash
    cd flask-app
    ```
3.  venv 環境起動
    ```bash
    python -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    ```
4.  flask-app 起動以降は同じ
    ```bash
    python ./src/app.py
    ```
5.  venv 環境終了
    ```bash
    deactivate
    ```
### gunicorn実行
1.  Codespaces のターミナル開く
2.  flask-app ディレクトリに移動
    ```bash
    cd flask-app
    ```
3.  gunicorn 実行
    ```bash
    PYTHONPATH=src gunicorn src.app:app --bind 0.0.0.0:5000
    ```
### docker-compose
1.  Codespaces のターミナル開く
2.  flask-app ディレクトリに移動
    ```bash
    cd flask-app
    ```
3.  docker compose を実行
    ```bash
    # ビルド＆起動
    docker compose up --build -d
    # 起動
    docker compose up -d
    # ログ確認
    docker compose logs -f flask-app
    # 停止/削除
    docker compose down
    ```
