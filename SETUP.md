# REMORY Setup Guide

*Your agent reads this file to automatically set up your memory system.*

---

## What is REMORY?

REMORY = **RE**liable **M**emory **ORY**ganizer

A starter kit for OpenClaw agents that need consistent memory practices. If your agent keeps "forgetting" between sessions, this template fixes that.

---

## What This Does

This template sets up:

1. **Daily Memory Logs** — `CORE/memory/YYYY-MM-DD.md` for each day
2. **Heartbeat Reminders** — so your agent checks memory regularly
3. **Backup Scripts** — automated memory backups
4. **Monthly Compression** — archives old memory files so they don't pile up

---

## How It Works

1. Your agent reads this SETUP.md
2. Agent runs: `bash SCRIPTS/setup-remory.sh`
3. Script creates all necessary folders and copies template files to the right places
4. Done! Your memory system is live.

---

## Manual Setup (If Script Fails)

If the script doesn't work, here's the manual process:

**Choose where you want your memory system to live.** For example:
- `~/workspace/your-agent/CORE/memory`
- Or just `memory/` in your workspace root

### Step 1: Create Folder Structure

```bash
mkdir -p YOUR_PATH/memory
mkdir -p YOUR_PATH/Scripts
mkdir -p YOUR_PATH/Backups
```

### Step 2: Copy Scripts

```bash
cp REMORY-TEMPLATE-PROJECT/SCRIPTS/backup-remory.sh YOUR_PATH/Scripts/
cp REMORY-TEMPLATE-PROJECT/SCRIPTS/monthly-memory-compress.sh YOUR_PATH/Scripts/
chmod +x YOUR_PATH/Scripts/*.sh
```

### Step 3: Create Your First Memory Log

```bash
echo "# $(date +%Y-%m-%d) Memory Log" > YOUR_PATH/memory/$(date +%Y-%m-%d).md
```

### Step 4: Set Up HEARTBEAT.md

Copy the template to your workspace root:

```bash
cp REMORY-TEMPLATE-PROJECT/HEARTBEAT.md ./
```

Or create your own heartbeat file referencing CORE/memory for daily recaps.

---

## Files Included

| File | Purpose |
|------|---------|
| `setup-remory.sh` | Auto-runs everything above |
| `backup-remory.sh` | Backs up memory folder with date stamp |
| `monthly-memory-compress.sh` | Archives old memories monthly |
| `HEARTBEAT.md` | Heartbeat template for your agent |

---

## Need Help?

- Check `README.md` for full project overview
- Your agent should read these files automatically

---

*REMORY: Making memory gaps a thing of the past.*