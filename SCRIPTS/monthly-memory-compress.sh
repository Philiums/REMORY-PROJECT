#!/bin/bash
# monthly-archive.sh
# Archives the previous month's memory files
# Runs on the 1st of each month via cron

# Detect workspace location dynamically
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
MEMORY_DIR="${WORKSPACE_DIR}/CORE/memory"

# Get previous month info
PREV_MONTH=$(date -d "last month" +%m)
PREV_YEAR=$(date -d "last month" +%Y)
FOLDER_NAME="${PREV_YEAR}-${PREV_MONTH}"  # e.g., 2026-03

# Check if folder already exists (already ran this month)
if [ -d "$MEMORY_DIR/$FOLDER_NAME" ]; then
    echo "Folder $FOLDER_NAME already exists. Exiting."
    exit 0
fi

# Find files matching previous month (e.g., 2026-03-*.md)
FILES=$(ls $MEMORY_DIR/${PREV_YEAR}-${PREV_MONTH}-*.md 2>/dev/null)

if [ -z "$FILES" ]; then
    echo "No files found for $FOLDER_NAME. Exiting."
    exit 0
fi

# Create year folder and month subfolder
mkdir -p "$MEMORY_DIR/$PREV_YEAR/$FOLDER_NAME"

# Move files
mv $FILES "$MEMORY_DIR/$PREV_YEAR/$FOLDER_NAME/"

# Compress
tar -czf "$MEMORY_DIR/$PREV_YEAR/$FOLDER_NAME.tar.gz" -C "$MEMORY_DIR/$PREV_YEAR" "$FOLDER_NAME"

# Create index BEFORE deleting folder (so we can count files)
FILE_COUNT=$(ls "$MEMORY_DIR/$PREV_YEAR/$FOLDER_NAME/" 2>/dev/null | wc -l)
echo "# $FOLDER_NAME Memory Archive
- Archived: $(date +%Y-%m-%d)
- Files: $FILE_COUNT
" > "$MEMORY_DIR/$PREV_YEAR/$FOLDER_NAME/index.md"

# --- Cleanup: Remove uncompressed folder after archiving ---
rm -rf "$MEMORY_DIR/$PREV_YEAR/$FOLDER_NAME"
echo "🧹 Cleaned up uncompressed folder: $FOLDER_NAME"
# -------------------------------------------------------------

echo "✅ Archived $FOLDER_NAME"