# =============================================
# Build Stage (ビルドステージ)
# =============================================
# MavenとJava 21 (JDK) を含む公式イメージをベースとして使用
# アプリケーションをビルド（コンパイルとJARファイルの作成）するためだけのステージ
#FROM maven:3.9.6-eclipse-temurin-21-jammy AS build
FROM maven:3.9.11-eclipse-temurin-21 AS build

# 作業ディレクトリを作成
WORKDIR /app

# まずpom.xmlだけをコピーして、依存関係をダウンロードする
# これにより、ソースコードを変更しても、依存関係のダウンロードはキャッシュが使われ、ビルドが高速化する
COPY pom.xml .
RUN mvn dependency:go-offline

# アプリケーションのソースコードをコピー
COPY src ./src

# Mavenを使ってアプリケーションをビルドし、実行可能なJARファイルを作成する
RUN mvn package -DskipTests


# =============================================
# Run Stage (実行ステージ)
# =============================================
# Java 21の実行環境(JRE)のみを含む、軽量な公式イメージをベースとして使用
# ビルドされたアプリケーションを実行するためだけの、軽量で安全なステージ
FROM eclipse-temurin:21-jre-jammy

# 作業ディレクトリを作成
WORKDIR /app

# Buildステージから、ビルドされたJARファイルだけをコピーする
# target/spring-boot-app-0.0.1-SNAPSHOT.jar の部分は、あなたのプロジェクトのArtifactIdとバージョンに合わせてください
COPY --from=build /app/target/spring-boot-app-0.0.1-SNAPSHOT.jar app.jar

# コンテナが起動したときに実行されるコマンド
# "java -jar app.jar" を実行して、Spring Bootアプリケーションを起動する
ENTRYPOINT ["java","-jar","app.jar"]

# アプリケーションがリッスンするポートを公開する
EXPOSE 8080