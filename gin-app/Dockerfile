# ビルドステージ 開発用イメージ
FROM golang:1.25-alpine AS builder

# 作業ディレクトリ作成
WORKDIR /app

# Go ライブラリインストール
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピー
COPY main.go ./
COPY ./src ./src
COPY ./static ./static

# ビルド
RUN go build -o app main.go

# 実行ステージ 実行用イメージ
FROM alpine

# CA証明書をインストールしてTLS通信を可能にする
# RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
# CA証明書をインストールしてTLS通信を可能にする
# RUN apk add --no-cache ca-certificates

# 作業ディレクトリ作成
WORKDIR /app

# 必要なファイルのみコピー
COPY --from=builder /app/app .
COPY --from=builder /app/static ./static

# Ginアプリ起動
CMD ["./app"]