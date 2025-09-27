# Maven + Java イメージ
FROM maven:3.9.11-eclipse-temurin-21

# 作業ディレクトリ設定
WORKDIR /app

# pomコピー
COPY pom.xml ./

# 依存ライブラリインストール
RUN mvn dependency:go-offline

# モジュールコピー
COPY ./src ./src

# Mavenビルド（テストスキップ）, jar 移動・リネーム
RUN mvn package -DskipTests && mv target/*.jar app.jar

# SpringBootアプリ起動
CMD ["java", "-jar", "app.jar"]

# ポート公開
EXPOSE 8080
