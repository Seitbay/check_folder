#!/bin/bash

LOG_DIR="/home/t1tan/log"
BACKUP_DIR="/home/t1tan/backup"
FILES_COUNT=7

cleanup() {
    rm -rf "$LOG_DIR/*"
    rm -rf "$BACKUP_DIR/*"
}

run_test() {
    bash check_folder.sh "$1" "$2" "$3"
}

echo "Тест 1"
for i in $(seq 1 $FILES_COUNT); do
    fallocate -l 1000M "$LOG_DIR/test_file_$i.txt"
done
run_test "$LOG_DIR" 30 10
cleanup


