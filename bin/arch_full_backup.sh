#! /usr/bin/env bash

set -euo pipefail

# Ensure running as root
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

# Usage check
if [[ -z "${1:-}" ]]; then
  echo "Usage: $0 <destination_path> [source_path]" >&2
  exit 1
fi

# Parse arguments & normalize trailing slashes
DEST_DIR="${1%/}/"
SRC_DIR="${2:-/}"
SRC_DIR="${SRC_DIR%/}/"

LOG_FILE="full_backup.log"
ERR_FILE="full_backup.errors"

echo "Starting rsync backup from '${SRC_DIR}' to '${DEST_DIR}' in background..."

nohup rsync -aAXHv --numeric-ids --delete \
  --exclude='/dev/***' \
  --exclude='/proc/***' \
  --exclude='/sys/***' \
  --exclude='/tmp/***' \
  --exclude='/run/***' \
  --exclude='/mnt/***' \
  --exclude='/media/***' \
  --exclude='/lost+found' \
  --exclude='/var/cache/pacman/pkg/***' \
  --exclude='/var/tmp/***' \
  --exclude='/var/log/***' \
  --exclude='/home/*/.cache/***' \
  --exclude='/root/.cache/***' \
  --exclude="$DEST_DIR" \
  "$SRC_DIR" "$DEST_DIR" \
  >> "$LOG_FILE" 2>> "$ERR_FILE" &

echo "Backup job started in background (PID: $!)."
echo "Logging to ${LOG_FILE} and errors to ${ERR_FILE}."

