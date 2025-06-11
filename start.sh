#!/bin/bash
echo "Запускается PostgreSQL..."
service postgresql start

echo "Запускается Nginx..."
nginx -g "daemon off;"