# telegram/routing-map.template.md — Routing Map

<!-- Copy this, fill in your actual IDs, and reference it from ops files. -->

## Group
- Supergroup ID: YOUR_TELEGRAM_GROUP_ID
- Bot: @YOUR_BOT_NAME

## Topic Thread IDs
- General: YOUR_GENERAL_THREAD_ID
- Operations: YOUR_OPS_THREAD_ID
- Security & Audit: YOUR_SECURITY_THREAD_ID
- Briefs: YOUR_BRIEFS_THREAD_ID
- Creative: YOUR_CREATIVE_THREAD_ID  (optional)

## Personal
- Your user ID: YOUR_TELEGRAM_USER_ID  (for CRITICAL DMs)

---

## Quick Reference (copy into cron payloads)

```json
// Ops topic
"delivery": {
  "mode": "announce",
  "channel": "telegram",
  "to": "YOUR_TELEGRAM_GROUP_ID:topic:YOUR_OPS_THREAD_ID"
}

// Security topic
"delivery": {
  "mode": "announce",
  "channel": "telegram",
  "to": "YOUR_TELEGRAM_GROUP_ID:topic:YOUR_SECURITY_THREAD_ID"
}
```
