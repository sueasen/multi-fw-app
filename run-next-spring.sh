#!/bin/bash

NEXT_APP="next-app"
BACKEND_APP="spring-boot-app"
BACKEND_URL="https://bookish-dollop-x7vqgqgpqpcvqw4-8080.app.github.dev"

COMMAND=$1
case $COMMAND in
  "build")
    echo "--- docker compose build ---"
    docker compose -f docker-compose.multi.yml build --build-arg NEXT_PUBLIC_BACKEND_URL=$BACKEND_URL $NEXT_APP $BACKEND_APP
    echo "--- build end ---"
    ;;

  "up")
    echo "--- docker compose down ---"
    docker compose -f docker-compose.multi.yml down $NEXT_APP $BACKEND_APP
    echo "--- docker compose up ---"
    docker compose -f docker-compose.multi.yml up -d $NEXT_APP $BACKEND_APP
    echo "--- up end ---"
    ;;

  "upbuild")
    echo "--- docker compose down ---"
    docker compose -f docker-compose.multi.yml down $NEXT_APP $BACKEND_APP
    echo "--- docker compose build ---"
    docker compose -f docker-compose.multi.yml build --build-arg NEXT_PUBLIC_BACKEND_URL=$BACKEND_URL $NEXT_APP $BACKEND_APP
    echo "--- docker compose up ---"
    docker compose -f docker-compose.multi.yml up -d $NEXT_APP $BACKEND_APP
    echo "--- upbuild end ---"
    ;;

  "down")
    echo "--- docker compose down ---"
    docker compose -f docker-compose.multi.yml down $NEXT_APP $BACKEND_APP
    echo "--- down end ---"
    ;;

  *)
    echo "使い方: $0 {build|up|upbuild|down}"
    ;;
esac