#!/bin/sh

# 设置默认值
HOST=${HOST:-"0.0.0.0"}
PORT=${PORT:-8000}
WORKERS=${WORKERS:-1}

# 创建必要的目录
mkdir -p /app/data

# # 如果accounts.json不存在，创建空的
# if [ ! -f "/app/accounts.json" ]; then
#     echo "{}" > /app/accounts.json
# fi
# 如果文件不存在，创建空的
if [ ! -f "/app/accounts.json" ]; then
  echo "{}" > /app/accounts.json
else
  # 确保权限正常（可读可写）
  chmod 666 /app/accounts.json 2>/dev/null || true

  # 如果内容不是合法 JSON，可以选择自动重置
  # 轻量一点的做法：只在文件为空时写入 {}
  if [ ! -s /app/accounts.json ]; then
    echo "{}" > /app/accounts.json
  fi
fi

# 不再需要更改文件所有权，因为我们使用root用户运行容器

echo "🚀 启动Outlook邮件API服务..."
echo "📋 配置信息:"
echo "   - 主机地址: $HOST"
echo "   - 端口: $PORT"
echo "   - 工作进程: $WORKERS"
echo "   - 数据目录: /app/data"

# 启动应用
exec python main.py 
