# REMORY Template

**Memory optimization starter kit for OpenClaw agents.**

---

## What is this?

REMORY is a plug-and-play memory system designed to solve the most common issues new OpenClaw users face:

- Forgetting context between sessions
- Heartbeat checks not working reliably
- No structure for daily memory logs
- Difficulty scaling memory as the agent grows

This template gives you a working foundation from day one.

---

## Who is this for?

- New OpenClaw users setting up their first agent
- Community members experiencing memory gaps or inconsistent behavior
- Anyone wanting a proven memory architecture without the trial-and-error

---

## What's inside?

```
REMORY-TEMPLATE-PROJECT/
├── README.md           ← You are here
├── SETUP.md            ← Make your agent read this for automatic setup
├── setup-remory.sh     ← Script that does the heavy lifting
├── backup-remory.sh    ← Backup script (gets copied to CORE/Scripts/)
├── monthly-memory-compress.sh ← Archive script
├── HEARTBEAT.md        ← Heartbeat template (gets copied to workspace root)
└── Backups/            ← Where backups get stored
```

---

## Quick Start

### Automated Setup (Recommended)

1. Your agent reads `SETUP.md`
2. Agent runs: `bash A-LAB/REMORY-TEMPLATE-PROJECT/setup-remory.sh`
3. Everything auto-configures!

### Manual Setup (If script fails)

See `SETUP.md` for manual fallback steps.

---

## The Memory Architecture

### What Gets Created

| Component | Purpose | Location |
|-----------|---------|----------|
| **Daily memory** | Raw session logs, timestamped | `CORE/memory/YYYY-MM-DD.md` |
| **HEARTBEAT.md** | Periodic task checks | Workspace root |
| **Backup scripts** | Automated backups | `CORE/Scripts/` |

### Heartbeat Intervals

- **1-hour heartbeat** — Light check: session recap, memory write
- **6-hour heartbeat** — Extended check: backup verification
- **12-hour heartbeat** — Full ritual check: all systems verified

---

## Configuring Heartbeat in openclaw.json

To activate heartbeat checks, add this to your `openclaw.json`:

```json
{
  "heartbeat": {
    "enabled": true,
    "prompt": "Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats. If nothing needs attention, reply HEARTBEAT_OK.",
    "intervalMinutes": 60,
    "activeHours": "00-24"
  }
}
```

**Options:**
- `intervalMinutes`: How often heartbeat fires (60 = 1 hour)
- `activeHours`: When heartbeat is active (e.g., "08-22" for daytime only, "00-24" for all day)
- `prompt`: The instruction your agent follows — keep HEARTBEAT.md reference!

---

## Common Issues This Solves

| Symptom | Likely Cause | Solution |
|---------|--------------|----------|
| Agent forgets context | No daily memory log | Use `CORE/memory/YYYY-MM-DD.md` |
| Inconsistent behavior | HEARTBEAT.md empty | Configure heartbeat intervals |
| No backup | No backup script | Run `backup-remory.sh` daily |

---

## Monthly Archive

Run `monthly-memory-compress.sh` manually at the start of each month to archive old memory files.

---

## Memory Logging Styles

**Two approaches, pick what fits your use case:**

### Proactive Logging (Spammy)
Add this to your agent's SOUL.md:
```
- I write everything down in my memory log so I don't forget
```
> Logs after every chat. Great for agents that need constant continuity, but burns more tokens.

### Reactive Logging (Heartbeat-Based)
Add this to your agent's SOUL.md:
```
- I rely on heartbeat intervals to log memory (not every chat!)
```
> Logs only on heartbeat intervals. More efficient, keeps memory clean.

**REMORY uses heartbeat-based by default** — less token burn, structured recaps.

### Pro Tip: Start Proactive, Switch Later

Starting with a proactive agent is actually **super useful early on**:
- Quickly builds context about you
- Fills in USER.md with rich details
- Helps agent understand your personality fast

**But** once your foundation is solid (detailed SOUL.md, USER.md, memory files), consider switching to reactive/heartbeat-based to avoid:
- Token bloat from logging junk
- Slower responses from constant writes
- Cluttered memory files

Think of it like: aggressive learning phase → maintenance phase 🔄

---

## ⚠️ Note for Standard OpenClaw Users

This template uses the HEARTBEAT feature, which was added by Robby for Heyron agents. If you're on a standard OpenClaw setup without custom heartbeat, this template may need adaptation. I'd love to know if it works out of the box or what needs tweaking!

---

*REMORY — Making memory gaps a thing of the past.*