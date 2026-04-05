#!/bin/bash

# REMORY Setup Script
# Run this to automatically set up your memory system

set -e

echo "🚀 Starting REMORY Setup..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
WORKSPACE_DIR="$(dirname "$PARENT_DIR")"

# If script is run from workspace root, SCRIPT_DIR is already the project folder
# If not, assume we're inside the project folder
if [[ "$SCRIPT_DIR" == *"REMORY-TEMPLATE-PROJECT" ]]; then
    PROJECT_DIR="$SCRIPT_DIR"
else
    PROJECT_DIR="$SCRIPT_DIR/A-LAB/REMORY-TEMPLATE-PROJECT"
fi

echo "📁 Setting up folder structure..."

# Create necessary directories
mkdir -p "$WORKSPACE_DIR/CORE/memory"
mkdir -p "$WORKSPACE_DIR/CORE/Scripts"
mkdir -p "$PROJECT_DIR/Backups"

echo "📋 Copying scripts..."

# Copy backup scripts to CORE/Scripts
cp "$PROJECT_DIR/backup-remory.sh" "$WORKSPACE_DIR/CORE/Scripts/"
cp "$PROJECT_DIR/monthly-memory-compress.sh" "$WORKSPACE_DIR/CORE/Scripts/"

# Make scripts executable
chmod +x "$WORKSPACE_DIR/CORE/Scripts/backup-remory.sh"
chmod +x "$WORKSPACE_DIR/CORE/Scripts/monthly-memory-compress.sh"

echo "📝 Creating today's memory log..."

# Create today's memory log
TODAY=$(date +%Y-%m-%d)
cat > "$WORKSPACE_DIR/CORE/memory/${TODAY}.md" << EOF
# ${TODAY} Memory Log

---

## Session Recap




---

### Heartbeat 1-Hour Recap



---

### Heartbeat 6-Hour Actions



---

*Session in progress...*

EOF

echo "💓 Setting up HEARTBEAT.md..."

# Copy HEARTBEAT template to workspace root
if [ -f "$PROJECT_DIR/HEARTBEAT.md" ]; then
    cp "$PROJECT_DIR/HEARTBEAT.md" "$WORKSPACE_DIR/"
    echo "✅ HEARTBEAT.md copied"
else
    echo "⚠️ HEARTBEAT.md not found in project folder - skipping"
fi

echo "✍️ Adding backup script note to SOUL.md..."

# Add backup script reference to SOUL.md if it exists
SOUL_FILE="$WORKSPACE_DIR/SOUL.md"
if [ -f "$SOUL_FILE" ]; then
    # Check if backup note already exists
    if ! grep -q "backup-workspace.sh" "$SOUL_FILE"; then
        echo -e "\n## Backup Script\n**Location:** \`CORE/Scripts/backup-workspace.sh\`\n**Usage:** Always run this script for backups — it automatically tars, saves to \`CORE/Backups/\`, and pushes to GitHub. Uses dynamic paths so it works for any workspace." >> "$SOUL_FILE"
        echo "✅ Added backup script note to SOUL.md"
    else
        echo "⚠️ Backup script note already exists in SOUL.md - skipping"
    fi
else
    echo "⚠️ SOUL.md not found - skipping backup note"
fi

echo ""
echo "🎉 REMORY Setup Complete!"
echo ""
echo "Your memory system is now ready:"
echo "  - CORE/memory/ created with today's log"
echo "  - CORE/Scripts/ has backup scripts"
echo "  - HEARTBEAT.md is active"
echo ""
echo "Next steps:"
echo "  1. Your agent should read HEARTBEAT.md to start heartbeating"
echo "  2. Check CORE/memory/ for daily logs"
echo "  3. Run 'bash CORE/Scripts/backup-remory.sh' for manual backup"
echo ""

# --- Verify Heartbeat is Configured ---
echo "🔍 Verifying heartbeat configuration..."
if command -v openclaw >/dev/null 2>&1; then
    if openclaw config get heartbeat.enabled 2>/dev/null | grep -q "true"; then
        echo "✅ Heartbeat is enabled in openclaw.json"
    else
        echo "⚠️ Heartbeat may not be enabled. To activate, add this to openclaw.json:"
        echo ""
        echo '  "heartbeat": {'
        echo '    "enabled": true,'
        echo '    "intervalMinutes": 60,'
        echo '    "activeHours": "00-24"'
        echo '  }'
    fi
else
    echo "⚠️ openclaw command not found — skipping heartbeat check"
fi
# ----------------------------------------

echo ""
echo "✨ REMORY: Making memory gaps a thing of the past."