#!/bin/bash

LOG_DIR="/home/t1tan/log"
BACKUP_DIR="/home/t1tan/backup"
FILES_COUNT=6

cleanup() {
    rm -rf "$LOG_DIR/*"
    rm -rf "$BACKUP_DIR/*"
}

run_test() {
    bash check_folder.sh "$1" "$2" "$3"
}

echo "Тест 4"
for i in $(seq 1 $FILES_COUNT); do
    fallocate -l 2000M "$LOG_DIR/test_file_$i.txt"
done
fallocate -l 1200M "$LOG_DIR/test_file_7.txt"
run_test "$LOG_DIR" 65 5
cleanup


