#!/bin/bash
# Workspace backup script
# Usage: ./backup-remory.sh

# Detect workspace location dynamically
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Go up from CORE/Scripts/ to workspace root
WORKSPACE_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
BACKUP_DIR="${WORKSPACE_DIR}/CORE/Backups"

# Create backup folder if it doesn't exist
mkdir -p "$BACKUP_DIR"

# --- Backup Retention Policy ---
# Prune backups older than 30 days to avoid bloat
RETENTION_DAYS=30
echo "🧹 Checking for old backups to prune..."
find "$BACKUP_DIR" -name "workspace_*.tar.gz" -mtime +$RETENTION_DAYS -delete 2>/dev/null
echo "✅ Pruned backups older than $RETENTION_DAYS days"
# ---------------------------------

TIMESTAMP=$(date +%Y-%m-%d_%H-%M)
BACKUP_NAME="workspace_${TIMESTAMP}.tar.gz"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"

# Create tar.gz excluding .trash, CORE/Backups, and .git to avoid bloat/recursion
tar -czf "$BACKUP_PATH" \
    --exclude='.trash' \
    --exclude='node_modules' \
    --exclude='CORE/Backups' \
    --exclude='.git' \
    -C "$WORKSPACE_DIR" .

echo "Backup created: $BACKUP_NAME"
echo "Location: $BACKUP_PATH"
echo "Size: $(du -h "$BACKUP_PATH" | cut -f1)"

# --- Git Config Check ---
# Verify git is configured before attempting push
if ! git config user.email >/dev/null 2>&1 || ! git config user.name >/dev/null 2>&1; then
    echo "⚠️ Git not configured. Skipping commit/push."
    echo "To enable, run:"
    echo "  git config user.email 'your@email.com'"
    echo "  git config user.name 'Your Name'"
    echo ""
    echo "Backup is saved locally at: $BACKUP_PATH"
    exit 0
fi
# -------------------------

# Git commit and push to your repo
echo "Committing and pushing to GitHub..."
cd "$WORKSPACE_DIR"
git add -A
git commit -m "Backup: $TIMESTAMP"
git push origin master
echo "Git push complete!"