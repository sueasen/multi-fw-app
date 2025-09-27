# Java イメージ
FROM eclipse-temurin:21-jdk-jammy

# 作業ディレクトリ設定
WORKDIR /app

# pomコピー
COPY pom.xml ./

# 依存ライブラリインストール
RUN apt-get update && apt-get install -y maven && mvn dependency:go-offline

# モジュールコピー
COPY ./src ./src

# Maveビルド（テストスキップ）
RUN mvn package -DskipTests

# SpringBootアプリ起動
CMD ["java", "-jar", "target/spring-boot-app-0.0.1-SNAPSHOT.jar"]

# ポート公開
EXPOSE 8080
