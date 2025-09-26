# multi-fw-app
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
2.  プロジェクト直下のディレクトリに移動
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
