#!/usr/bin/env bash
set -euo pipefail

# 1. Require Root Access
if [[ $EUID -ne 0 ]]; then
  echo "Error: This script must be run as root. Try using sudo." >&2
  exit 1
fi

# 2. Validate & Assign Target and Source Arguments
if [[ -z "${1:-}" ]]; then
  echo "Usage: $0 <destination_path> [source_path]" >&2
  exit 1
fi

DEST="$1"
SRC="${2:-/}"
LOG_FILE="full_backup.log"

# Normalize paths to prevent recursion if saving to /mnt or local paths
DEST_REALPATH=$(mkdir -p "$DEST" && realpath "$DEST")
SRC_REALPATH=$(realpath "$SRC")

# 3. Execute Background Backup
echo "Starting Debian 13 backup from '$SRC_REALPATH' to '$DEST_REALPATH'..."
echo "Log output redirected to $LOG_FILE"

nohup rsync -aAXHv \
  --numeric-ids \
  --delete \
  --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
  --exclude={"/var/tmp/*","/var/cache/apt/archives/*"} \
  --exclude={"$DEST_REALPATH"} \
  "$SRC_REALPATH/" "$DEST_REALPATH" >> "$LOG_FILE" 2>&1 &

echo "Backup process running in background (PID: $!)."

