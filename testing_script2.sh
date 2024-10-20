#!/bin/bash

LOG_DIR="/home/t1tan/log"
BACKUP_DIR="/home/t1tan/backup"
FILES_COUNT=12

cleanup() {
    rm -rf "$LOG_DIR/*"
    rm -rf "$BACKUP_DIR/*"
}

run_test() {
    bash check_folder.sh "$1" "$2" "$3"
}

echo "Тест 2"
for i in $(seq 1 $FILES_COUNT); do
    fallocate -l 900M "$LOG_DIR/test_file_$i.txt"
done
run_test "$LOG_DIR" 50 $FILES_COUNT
cleanup


