#!/bin/bash

# 定义变量
IMAGE_NAME="my-web-app"
CONTAINER_NAME="my-running-site"
PORT_MAPPING="8080:80"

echo "🚀 开始自动部署..."

# 1. 拉取最新代码
echo "📥 正在拉取最新代码..."
git pull origin main

# 2. 停止并删除旧容器
echo "🛑 正在停止旧容器..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# 3. 删除旧镜像（可选，为了节省空间，防止镜像堆积）
echo "🧹 正在清理旧镜像..."
docker rmi $IMAGE_NAME || true

# 4. 构建新镜像
echo "🔨 正在构建新镜像..."
docker build -t $IMAGE_NAME .

# 5. 启动新容器
echo "▶️ 正在启动新容器..."
docker run -d -p $PORT_MAPPING --name $CONTAINER_NAME $IMAGE_NAME

echo "✅ 部署完成！"
