#!/bin/bash

LOG_DIR="/home/t1tan/log"
BACKUP_DIR="/home/t1tan/backup"
THRESHOLD="$2"
N="$3"


used_space=$(du -s "$LOG_DIR" | awk '{print $1}')
total_space=$(quota -u t1tan | awk 'NR==3 {print $4}')

used_percent=$((used_space * 100 / total_space))

echo "Заполненность папки $LOG_DIR: $used_percent%"

if [ "$used_percent" -gt "$THRESHOLD" ]; then
    echo "Заполненность превышает $THRESHOLD%. Архивируем файлы..."

    oldest_files=$(find "$LOG_DIR" -type f -printf '%T+ %p\n' | sort | head -n "$N" | awk '{print $2}')

    tar -czf "$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).tar.gz" $oldest_files 
    echo "Файлы успешно архивированы в $BACKUP_DIR."

    for file in $oldest_files; do
        rm "$file"
        echo "Удален файл: $file"
    done
else
    echo "Заполненность не превышает $THRESHOLD%. Ничего не нужно делать."
fi
