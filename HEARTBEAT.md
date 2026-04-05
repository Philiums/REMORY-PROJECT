# HEARTBEAT.md

*Template for your agent's periodic memory checks.*

---

## What is Heartbeat?

Heartbeat = your agent's automatic check-ins to maintain memory and perform routine tasks between conversations.

---

## How It Works

Your agent performs these checks automatically at set intervals:

| Interval | What It Does |
|----------|--------------|
| **1 hour** | Session recap, write to today's memory log |
| **6 hours** | Verify 1-hour heartbeat, run backup script |
| **12 hours** | Full ritual check (all systems verified) |

---

## ⚙️ Customizing Your Heartbeat

**You can customize the heartbeat protocol!** This is configured in your OpenClaw config file.

### Where to Configure

Edit your `openclaw.json` and add/modify the `heartbeat` section:

```json
{
  "heartbeat": {
    "enabled": true,
    "prompt": "Read HEARTBEAT.md if it exists...",
    "intervalMinutes": 60,
    "activeHours": "00-24"
  }
}
```

### Customization Options

- **Enable/disable** — set `"enabled": true` or `false`
- **Interval** — change how often checks run (`intervalMinutes`)
- **Active hours** — limit when heartbeat runs (e.g., `"08-22"` for daytime only)
- **Custom prompt** — write your own heartbeat instructions

---

## What Your Agent Should Do

When heartbeat fires, your agent should:

1. **Read today's memory log** — `CORE/memory/YYYY-MM-DD.md`
2. **Write session recap** — what you discussed, decisions made, tasks completed
3. **Tag entries** — use markers like `[DECISION]`, `[TASK]`, `[LESSON]`, `[WIN]`
4. **Run backups** — at the 6-hour mark, run `bash CORE/Scripts/backup-remory.sh`

---

## Example Heartbeat Entry

```markdown
### Heartbeat 1-Hour Recap
- Reviewed project progress with Philippe
- Fixed README.md structure
- Started HEARTBEAT.md template
- Declaration: "1 HOUR HEARTBEAT LOCKED IN"
```

---

## 🔥 PRO TIPS: Different Heartbeat Patterns

Everyone's heartbeat looks different! Here are common patterns:

### 🟢 Light Check (Every 1 hour)
- Quick session recap
- Write to today's memory
- Just acknowledge what's happening
- Good for: busy agents, simple use cases

### 🟡 Medium Check (Every 3-6 hours)
- Light check + check emails/notifications
- Good for: agents managing communications

### 🔴 Heavy Check (Every 12-24 hours)
- Full system verification
- Run all backups
- Memory compression
- Good for: power users who want auto-maintenance

### 📋 Example: Your Heartbeat Could Look Like This

```markdown
# 1 Hour Heartbeat — Light Check
- Recap session: what did we discuss?
- Write to CORE/memory/YYYY-MM-DD.md
- Tag: [DECISION], [TASK], [LESSON]
- Declaration: "1 HOUR HEARTBEAT LOCKED IN"

# 6 Hour Heartbeat — Medium Check
- Run 1-hour check
- Run backup script: bash CORE/Scripts/backup-remory.sh
- Check if any pending tasks
- Declaration: "6 HOUR HEARTBEAT LOCKED IN"

# 12 Hour Heartbeat — Heavy Check
- Run all above
- Verify backups exist
- Memory compression check
- Run FULL ritual
- Declaration: "RITCHIE RAN. FULLY LOCKED IN."
```

---

## 📝 Notes for Your Agent

- Always write to the correct date file (`CORE/memory/YYYY-MM-DD.md`)
- Use consistent tags for easy searching later
- If heartbeat fails — log the error and notify the user
- Keep HEARTBEAT.md in your workspace root so you can reference it

---

*Configure your heartbeat in openclaw.json — make it yours.*