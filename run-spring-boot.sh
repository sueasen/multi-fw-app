#!/bin/bash

# ==============================================================================
# Spring Boot Docker実行スクリプト
# ==============================================================================
# 使い方:
# 1. ターミナルでこのファイルに実行権限を与える:
#    chmod +x run-spring-boot.sh
# 2. イメージをビルドする (初回またはコード変更時):
#    ./run-spring-boot.sh build
# 3. コンテナを実行する:
#    ./run-spring-boot.sh start
# 4. 実行中のコンテナを停止する:
#    ./run-spring-boot.sh stop
# 5. 実行中のコンテナのログを表示する:
#    ./run-spring-boot.sh logs
# ==============================================================================

# --- 設定 (必要に応じて変更) ---
# Dockerイメージ名とタグ
IMAGE_NAME="spring-boot-app:latest"
# Dockerfileがあるディレクトリのパス
DOCKERFILE_PATH="./spring-boot-app"
# 実行するコンテナ名
CONTAINER_NAME="spring-boot-app"

# --- スクリプト本体 ---

# 第1引数に応じて処理を分岐
COMMAND=$1

case $COMMAND in
  "build")
    echo "--- Dockerイメージをビルドします ---"
    docker build -t $IMAGE_NAME $DOCKERFILE_PATH
    echo "--- ビルドが完了しました ---"
    ;;

  "start")
    echo "--- 既存のコンテナがあれば停止・削除します ---"
    docker stop $CONTAINER_NAME > /dev/null 2>&1
    docker rm $CONTAINER_NAME > /dev/null 2>&1
    echo "--- 新しいコンテナを実行します ---"
    docker run -d -p 8080:8080 \
      -e SUPABASE_URL=$SUPABASE_URL \
      -e SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY \
      -e SUPABASE_JWT_SECRET=$SUPABASE_JWT_SECRET \
      -e TIDB_HOST=$TIDB_HOST \
      -e TIDB_USER=$TIDB_USER \
      -e TIDB_PASSWORD=$TIDB_PASSWORD \
      -e TIDB_DB_NAME=$TIDB_DB_NAME \
      -e TIDB_PORT=$TIDB_PORT \
      --name $CONTAINER_NAME \
      $IMAGE_NAME
    
    echo "--- コンテナ '$CONTAINER_NAME' がバックグラウンドで起動しました ---"
    echo "ログを表示するには、'./run-spring-boot.sh logs' を実行してください。"
    ;;

  "stop")
    echo "--- コンテナ '$CONTAINER_NAME' を停止・削除します ---"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
    echo "--- 停止しました ---"
    ;;

  "logs")
    echo "--- コンテナ '$CONTAINER_NAME' のログを表示します (Ctrl+Cで終了) ---"
    docker logs -f $CONTAINER_NAME
    ;;

  *)
    echo "使い方: $0 {build|start|stop|logs}"
    exit 1
    ;;
esac