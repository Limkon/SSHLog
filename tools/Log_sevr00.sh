#!/bin/bash

# 从Secrets中读取服务器信息
SERVERS_INFO="${{ secrets.SERVERS_INFO }}"

# 将每行服务器信息放入数组
IFS=$'\n' read -rd '' -a SERVERS <<< "$SERVERS_INFO"

# 循环登录每个服务器
for SERVER_INFO in "${SERVERS[@]}"; do
  IFS=' ' read -r SERVER USER PASSWORD <<< "$SERVER_INFO"
  echo "Logging in as $USER..."
  sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -tt "$USER@$SERVER" << EOF
    echo "登录成功 - 用户: $USER"
    ls -lah
    exit
EOF
done
