# telegram/topic-architecture.md — Telegram Topic Architecture

## Philosophy: Single Source, No Noise

**One topic = one purpose. Nothing duplicated across topics.**

The biggest mistake in Telegram forum setup is routing the same event to multiple topics "for visibility." This creates noise, makes it hard to audit, and trains you to ignore notifications. Pick one destination per event type and stick to it.

---

## Recommended Topic Structure

For a personal OpenClaw deployment, 4–5 topics is enough:

| # | Topic Name | Thread ID Token | Purpose |
|---|-----------|-----------------|---------|
| 1 | General | YOUR_GENERAL_THREAD_ID | Default fallback. Announcements, session start/end. |
| 2 | Operations | YOUR_OPS_THREAD_ID | Dispatch confirmations, in-flight updates, cron outcomes, task completions. |
| 3 | Security & Audit | YOUR_SECURITY_THREAD_ID | Gideon + Abaddon results, CRITICAL alerts, identity change log. |
| 4 | Briefs | YOUR_BRIEFS_THREAD_ID | Morning brief, weekly summaries, cost reports. |
| 5 | Creative | YOUR_CREATIVE_THREAD_ID | Content drafts, media output, Selah creative pipeline. Optional. |

**DMs:** Sensitive one-off messages, CRITICAL alerts that need immediate attention, voice notes.

---

## Routing Rules

| Event | Destination |
|-------|------------|
| Task dispatched | Ops topic |
| Task completed (agent close ping) | Ops topic |
| Task stale >60min | Ops topic + DM if >3h |
| Gideon audit complete (A/B grade) | Morning brief data only (no Telegram) |
| Gideon audit complete (C grade) | Security topic |
| Gideon audit CRITICAL or D/F | Security topic + DM immediately |
| Abaddon grade A/B | Morning brief only |
| Abaddon grade D/F | Security topic + DM immediately |
| Morning brief | Briefs topic |
| Cost report | Briefs topic |
| Blog draft ready | Ops topic |
| Creative output | Creative topic |
| Errors / unexpected failures | Ops topic |

**Never:** Route the same event to two topics simultaneously.

---

## Setup Instructions

1. Create a Telegram supergroup
2. Enable Topics (Group Settings → Topics → Enable)
3. Create topics with the names above
4. Get each topic's thread ID:
   - Right-click a topic → Copy Link
   - URL format: `https://t.me/c/XXXXXXXXXX/YYY` → YYY is the thread ID
5. Replace `YOUR_*_THREAD_ID` tokens in all config files with actual IDs
6. Replace `YOUR_TELEGRAM_GROUP_ID` with your supergroup's negative ID

---

## Getting Your Group ID

```bash
# After adding your bot to the group, send a message, then:
curl "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates" | python3 -m json.tool | grep chat
```

The `id` field for your group will be a large negative number (e.g. `-1001234567890`).

---

## Anti-Patterns

- **Don't route security alerts to Ops topic** — they'll get lost in the dispatch noise
- **Don't use General as a catch-all** — it becomes useless within a week
- **Don't notify on every cron run** — only notify on errors or significant events
- **Don't post audit files inline** — post grade + top finding only; full file is on disk
